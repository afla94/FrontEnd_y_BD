-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-09-2023 a las 18:04:06
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `departamentobienestar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `atributos`
--

CREATE TABLE `atributos` (
  `id_atributo` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `descrpicion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `id_solicitud` int(11) NOT NULL,
  `fk_id_usuario` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `disponible` varchar(50) NOT NULL,
  `dia` date NOT NULL,
  `hora` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id_tipo_usuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id_tipo_usuario`, `nombre`, `descripcion`) VALUES
(1, 'estudiante', 'este usuario puede solicitar citas a lo psicólogos'),
(2, 'psicologo', 'este usuario puede mirar las solicitudes de los estudiantes'),
(3, 'administrador', 'este usuario puede todos los módulos del programa'),
(4, 'secretario', 'este usuario puede asignar psicólogos a las solicitudes de los estudiantes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario_permisos`
--

CREATE TABLE `tipo_usuario_permisos` (
  `id_tipo_usuario_permisos` int(11) NOT NULL,
  `fk_id_tipo_usuario` int(11) NOT NULL,
  `fk_id_permiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `fk_id_tipo_usuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `dirreccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(20) DEFAULT NULL,
  `contraseña` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `fk_id_tipo_usuario`, `nombre`, `dirreccion`, `telefono`, `correo`, `contraseña`) VALUES
(1, 1, 'juan perez', 'cra 65 n 74 144', '3212020231', 'juanperez@gmail.com', 156164);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_atributo`
--

CREATE TABLE `usuario_atributo` (
  `id_usuario_atributo` int(11) NOT NULL,
  `fk_id_usuario` int(11) NOT NULL,
  `fk_id_atributo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `atributos`
--
ALTER TABLE `atributos`
  ADD PRIMARY KEY (`id_atributo`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD KEY `fk_id_usuario` (`fk_id_usuario`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id_tipo_usuario`),
  ADD KEY `id_tipo_usuario` (`id_tipo_usuario`);

--
-- Indices de la tabla `tipo_usuario_permisos`
--
ALTER TABLE `tipo_usuario_permisos`
  ADD KEY `fk_id_permiso` (`fk_id_permiso`),
  ADD KEY `fk_id_tipo_usuario` (`fk_id_tipo_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `ID` (`id_usuario`),
  ADD KEY `fk_id_tipo_usuario` (`fk_id_tipo_usuario`);

--
-- Indices de la tabla `usuario_atributo`
--
ALTER TABLE `usuario_atributo`
  ADD PRIMARY KEY (`id_usuario_atributo`),
  ADD KEY `fk_id_usuario` (`fk_id_usuario`),
  ADD KEY `fk_id_atributo` (`fk_id_atributo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `solicitudes_ibfk_1` FOREIGN KEY (`fk_id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `tipo_usuario_permisos`
--
ALTER TABLE `tipo_usuario_permisos`
  ADD CONSTRAINT `tipo_usuario_permisos_ibfk_1` FOREIGN KEY (`fk_id_permiso`) REFERENCES `permisos` (`id_permiso`),
  ADD CONSTRAINT `tipo_usuario_permisos_ibfk_2` FOREIGN KEY (`fk_id_tipo_usuario`) REFERENCES `tipo_usuario` (`id_tipo_usuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`fk_id_tipo_usuario`) REFERENCES `tipo_usuario` (`id_tipo_usuario`);

--
-- Filtros para la tabla `usuario_atributo`
--
ALTER TABLE `usuario_atributo`
  ADD CONSTRAINT `usuario_atributo_ibfk_1` FOREIGN KEY (`fk_id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuario_atributo_ibfk_2` FOREIGN KEY (`fk_id_atributo`) REFERENCES `atributos` (`id_atributo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
