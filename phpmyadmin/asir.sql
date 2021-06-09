-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-06-2021 a las 09:57:42
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.4.1

CREATE DATABASE asir;
USE asir;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `asir`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `img` varchar(50) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `email`, `nombre`, `apellidos`, `img`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'alex', 'admin', 'alex@gmail.com', 'Alex', 'Bueno', 'alex05-06-21-06-2021admin4.png', 'activo', NULL, NULL),
(2, 'olivia', 'admin', 'olivia@gmail.com', 'Olivia', 'Iglesias', 'olivia19-06-21-06-2021admin6.png', 'inactivo', NULL, NULL),
(3, 'morgado', 'admin', 'morgado@gmail.com', 'Jose', 'Morgado', 'morgado35-06-21-06-2021admin8.png', 'activo', NULL, NULL),
(4, 'luisa', 'admin', 'luisa@gmail.com', 'Luisa', 'Parra', 'luisa28-06-21-06-2021admin1.png', 'activo', NULL, NULL),
(5, 'gines', 'admin', 'gines@gmail.com', 'Gines', 'Esteban', 'gines08-06-21-06-2021admin.7.png', 'activo', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `aciclo` varchar(1) NOT NULL,
  `ciudad` varchar(25) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `email` varchar(50) NOT NULL,
  `img` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`dni`, `nombre`, `apellidos`, `aciclo`, `ciudad`, `telefono`, `email`, `img`, `created_at`, `updated_at`) VALUES
('111111111', 'Irinaa', 'Kilichenko', '1', 'Tenerife', '678567780', 'irina@gmail.com', '1111111112021-06-09-06-33.png', NULL, NULL),
('222222222', 'Paula', 'Piero', '2', 'Alicante', '645009189', 'paula@gmail.com', '2222222222021-06-09-06-14.png', NULL, NULL),
('333333333', 'Bruno', 'Zambrano', '2', 'Burgos', '654779908', 'bruno@gmail.com', '3333333332021-06-09-06-48.png', NULL, NULL),
('444444444', 'Ander', 'Campano', '1', 'Sevilla', '690092314', 'ander@gmail.com', '4444444442021-06-09-06-22.png', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

CREATE TABLE `asignaturas` (
  `id` int(11) NOT NULL,
  `nombre_asig` varchar(100) NOT NULL,
  `dni_prof` varchar(9) NOT NULL,
  `aciclo` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asignaturas`
--

INSERT INTO `asignaturas` (`id`, `nombre_asig`, `dni_prof`, `aciclo`, `created_at`, `updated_at`) VALUES
(1, 'Seguridad y Alta Disponibilidad', '221133440', '2', NULL, NULL),
(2, 'Sistemas Operativos', '123456789', '1', NULL, NULL),
(3, 'Fundamentos de Hardware', '112233445', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `asignatura` varchar(100) NOT NULL,
  `ciudad` varchar(25) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `email` varchar(50) NOT NULL,
  `img` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`dni`, `nombre`, `apellidos`, `asignatura`, `ciudad`, `telefono`, `email`, `img`, `created_at`, `updated_at`) VALUES
('112233445', 'Fernanda', 'Figueroa', 'Fundamentos de Hardware', 'Girona', '609345632', 'fernanda@gmail.com', '1122334452021-06-09-06-59.png', NULL, NULL),
('123456789', 'Bernardo', 'Lopez', 'Sistemas operativos', 'Valencia', '654123201', 'bernardo@gmail.com', '1234567892021-06-09-06-07.png', NULL, NULL),
('221133440', 'Sergio', 'Abdala', 'Seguridad y Alta Disponibilidad', 'Bilbao', '612009394', 'sergio@gmail.com', '2211334402021-06-09-06-12.png', NULL, NULL),
('331134562', 'Andrea', 'Vargas', 'Base de Datos', 'Aguadulce', '656545578', 'andrea@gmail.com', '3311345622021-06-09-06-22.png', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asignaturas_dniprof_foreign` (`dni_prof`) USING BTREE;

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`dni`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD CONSTRAINT `profesores_dni_foreign` FOREIGN KEY (`dni_prof`) REFERENCES `profesores` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
