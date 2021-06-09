#!/bin/bash
set -e


config_hosts(){
    echo  ${HOSTNAME} > /etc/hostname
    cat /root/addhosts >> /etc/hosts
    #hostname ${HOSTNAME}
    IP_SBD=`cat /etc/hosts | grep sbd | cut -d " " -f1`
}

newUser(){
    # ---------------- creación de usuario 
    echo "MAQ2-->usuarioBD-->${USUARIO}" > /root/datos.txt
    echo "MAQ2-->passwordBD-->${PASSW}" >> /root/datos.txt
    useradd -rm -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}" 
    echo "root:${PASSWD}" | chpasswd
    echo "${USUARIO}:${PASSWD}" | chpasswd
}

config_Sudoers(){
    echo "${USUARIO} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/id_rsa.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}

config_apache(){
    #sed -i "s/\${APACHE_RUN_USER}/\www-data/g" /etc/apache2/apache2.conf
    #sed -i "s/${APACHE_RUN_DIR}/$/g" /etc/apache2/apache2.conf
    #asocia las variables del apache2.conf con los valores definidos en /etc/apache2/envars
    source /etc/apache2/envvars
    # con apache2 -S veremos los valores del las variables asociadas
    echo SetEnvIf Authorization '"(.*)"' HTTP_AUTHORIZATION='$1' >> /etc/apache2/apache2.conf
    # Apache gets grumpy about PID files pre-existing
    #rm -f /var/run/apache2/apache2.pid
}

config_phpmyadmin(){
    expect -f /root/phpmyadmin.exp
    ln -sf /usr/share/phpmyadmin /var/www/phpmyadmin
    sed -i "s/\$dbuser=''/\$dbuser='${USUARIO}'/g" /etc/phpmyadmin/config-db.php 
    sed -i "s/\$dbpass=''/\$dbpass='${PASSWD}'/g" /etc/phpmyadmin/config-db.php 
    sed -i "s/\$dbname='phpmyadmin'/\$dbname=''/g" /etc/phpmyadmin/config-db.php     
    sed -i "s/\$dbserver='localhost'/\$dbserver='${IP_SBD}'/g" /etc/phpmyadmin/config-db.php     
    sed -i "s/localhost/${IP_SBD}/g" /usr/share/phpmyadmin/libraries/config.default.php
    
    chown -R ${USUARIO}:${USUARIO} /var/www/phpmyadmin

    USUARIO=${USUARIO:-}
    PASSWD=${PASSWD:-}
    POYECTO=${PROYECTO:-}

    mkdir /root/bd
    touch /root/bd/sandia.txt
    echo "probando" >> /root/bd/sandia.txt
    echo "argumentos/environment"
    echo "--->${USUARIO}" > /root/bd/sandia.txt
    echo "--->${PASSWD}" >> /root/bd/sandia.txt
    echo "--->${PROYECTO}" >> /root/bd/sandia.txt
    echo "param: $0 ---> $1 ---> $2 ---> $3" >> /root/bd/sandia.txt
    service apache2 start

}

config_php(){
    cd /var/www/html

    chgrp -R www-data "/var/www/html"
    chmod g+w -R "/var/www/html"
}

config_vhost(){
    cd /etc/apache2/sites-available
    touch ${PROYECTO}.conf
    echo "<VirtualHost *:80>" > ${PROYECTO}.conf
    echo "DocumentRoot /var/www/html" >> ${PROYECTO}.conf
    echo "ServerName asir.tech" >> ${PROYECTO}.conf
    echo "ServerAlias www.asir.tech" >> ${PROYECTO}.conf
    echo "<Directory /var/www/html>" >> ${PROYECTO}.conf
    echo "    AllowOverride All" >> ${PROYECTO}.conf
    echo "    Require all granted" >> ${PROYECTO}.conf
    echo "</Directory>" >> ${PROYECTO}.conf
    echo "</VirtualHost>" >> ${PROYECTO}.conf
    a2ensite ${PROYECTO}.conf
    service apache2 reload
    cd /etc/apache2/sites-enabled
    a2ensite ${PROYECTO}.conf
    service apache2 reload
}

config_git(){
    cd /var/www/html
    if [ ! -d  /var/www/html/.git/ ];
    then 
        echo "no existe .git"
        git init
        git remote add origin https://usuario:pass@github.com/usuario/nombreproyecto.git
        git checkout -b master
        git pull origin master
    fi
    #rm -rf ./git
}

main(){
    config_hosts
    newUser
    config_Sudoers
    config_ssh
    config_apache
    config_phpmyadmin
    config_git
    config_php
    config_vhost
    tail -f /dev/null
}



main


# Start Apache in foreground
/usr/sbin/apache2 -DFOREGROUND