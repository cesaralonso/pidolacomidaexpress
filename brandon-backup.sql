-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 21, 2017 at 04:28 AM
-- Server version: 5.6.35
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `pidolacomida`
--

-- --------------------------------------------------------

--
-- Table structure for table `ciudad`
--

CREATE TABLE `ciudad` (
  `idciudad` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviacion` varchar(15) DEFAULT NULL,
  `estado_idestado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ciudad`
--

INSERT INTO `ciudad` (`idciudad`, `nombre`, `abreviacion`, `estado_idestado`) VALUES
(1, 'Ciudad Guzmán', 'GZMN', 1);

-- --------------------------------------------------------

--
-- Table structure for table `combo`
--

CREATE TABLE `combo` (
  `idcombo` int(11) NOT NULL,
  `restaurante_idrestaurante` int(11) DEFAULT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(205) NOT NULL,
  `precio` float DEFAULT NULL,
  `fecha_ini` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp850;

--
-- Dumping data for table `combo`
--

INSERT INTO `combo` (`idcombo`, `restaurante_idrestaurante`, `nombre`, `descripcion`, `precio`, `fecha_ini`, `fecha_fin`, `baja`, `created_at`, `created_by`) VALUES
(22, 1, 'Combo pareja', 'Combo para disfrutar en pareja', 50, '2017-01-01 00:00:00', '2017-12-01 00:00:00', 1, '2017-10-30 21:22:47', 1),
(23, 1, 'Combo amigos', 'Combo para amigos', 55, '2017-02-02 12:00:00', '2017-02-02 12:00:00', 0, '2017-10-30 21:30:10', 1),
(24, 2, 'Super quesadillas', 'Muchas quesadillas ', 20, '2017-01-01 00:00:00', '2017-12-01 00:00:00', 0, '2017-11-08 22:27:00', 1),
(25, 1, 'nuevo com', 'xcgh', 100, '2017-01-01 18:00:00', '2017-01-01 18:00:00', 1, '2017-11-08 23:01:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `combo_has_restaurante_has_platillo`
--

CREATE TABLE `combo_has_restaurante_has_platillo` (
  `combo_idcombo` int(11) NOT NULL,
  `res_has_platillo_res_idrestaurante` int(11) NOT NULL,
  `res_has_pla_platillo_idplatillo` int(11) NOT NULL,
  `cantidad` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp850;

--
-- Dumping data for table `combo_has_restaurante_has_platillo`
--

INSERT INTO `combo_has_restaurante_has_platillo` (`combo_idcombo`, `res_has_platillo_res_idrestaurante`, `res_has_pla_platillo_idplatillo`, `cantidad`) VALUES
(22, 1, 1, 4),
(22, 1, 2, 2),
(23, 1, 1, 4),
(23, 1, 2, 7),
(24, 2, 4, 4),
(25, 1, 2, 5),
(25, 1, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `conducta`
--

CREATE TABLE `conducta` (
  `idconducta` int(11) NOT NULL,
  `conducta` varchar(35) DEFAULT NULL,
  `gravedad` int(1) DEFAULT NULL,
  `motociclista_idmotociclista` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `baja` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `coordenada`
--

CREATE TABLE `coordenada` (
  `idcoordenada` int(11) NOT NULL,
  `lat` varchar(45) DEFAULT NULL,
  `lng` varchar(45) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `destinatario`
--

CREATE TABLE `destinatario` (
  `destinatario` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `direccion`
--

CREATE TABLE `direccion` (
  `iddireccion` int(11) NOT NULL,
  `calle` varchar(45) NOT NULL,
  `entrecalle1` varchar(45) DEFAULT NULL,
  `entrecalle2` varchar(45) DEFAULT NULL,
  `lat` varchar(45) DEFAULT NULL,
  `lng` varchar(45) DEFAULT NULL,
  `numext` int(6) NOT NULL,
  `numint` varchar(1) DEFAULT NULL,
  `colonia` varchar(45) NOT NULL,
  `cp` varchar(6) NOT NULL,
  `ciudad_idciudad` int(11) NOT NULL,
  `principal` tinyint(1) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `direccion`
--

INSERT INTO `direccion` (`iddireccion`, `calle`, `entrecalle1`, `entrecalle2`, `lat`, `lng`, `numext`, `numint`, `colonia`, `cp`, `ciudad_idciudad`, `principal`, `baja`, `created_by`, `created_at`, `modified_at`) VALUES
(1, 'Ramón corona # 34', 'Primero de mayo', 'Pascual galindo', '134', '-9993', 1, '2', 'Centro', '49900', 1, 1, NULL, NULL, '2017-10-25 22:08:13', NULL),
(3, 'p.o. Box 6268', 'Humold', 'Calle 2', '98797', '-98867', 3, '1', '365 barr avenue', '39762', 1, 0, NULL, NULL, '2017-10-25 22:12:14', NULL),
(4, 'OGAZON 1', 'calle 1', 'Calle 2', '78768', '-0987', 1, '2', 'Centro', '49000', 1, 1, NULL, NULL, '2017-10-25 22:26:52', NULL),
(5, 'lk', 'lk', 'lk', 'lk', 'lk', 0, 'l', 'lk', 'lllll', 1, 1, NULL, NULL, '2017-10-25 22:28:26', NULL),
(6, 'Ogazon #12', 'lk', 'lk', 'lk', 'lk', 0, 'l', 'lk', 'lklkl', 1, 1, NULL, NULL, '2017-10-25 22:30:11', '2017-10-29 16:18:13'),
(7, 'Ramón corona #120', 'Primero de mayo', 'Pascual galindo', '9879', '-8986', 2, '1', 'Centro', '49900', 1, 1, NULL, 1, '2017-10-25 22:35:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `idemail` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `tipo` varchar(25) CHARACTER SET big5 DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `enfermedad`
--

CREATE TABLE `enfermedad` (
  `idenfermedad` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `estado`
--

CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviacion` varchar(15) DEFAULT NULL,
  `pais_idpais` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `estado`
--

INSERT INTO `estado` (`idestado`, `nombre`, `abreviacion`, `pais_idpais`) VALUES
(1, 'Jalisco', 'JAL', 1);

-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

CREATE TABLE `factura` (
  `idfactura` int(11) NOT NULL,
  `pago_idpago` int(11) NOT NULL,
  `rfc` varchar(45) NOT NULL,
  `cadena` varchar(345) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `direccion_iddireccion` int(11) NOT NULL,
  `srcPDF` varchar(225) DEFAULT NULL,
  `srcXML` varchar(225) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gasolina`
--

CREATE TABLE `gasolina` (
  `idgasolina` int(11) NOT NULL,
  `marca` varchar(15) DEFAULT NULL,
  `litros` int(3) DEFAULT NULL,
  `costo` float DEFAULT NULL,
  `metodopago` varchar(35) DEFAULT NULL,
  `factura` tinyint(1) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `horario`
--

CREATE TABLE `horario` (
  `idhorario` int(11) NOT NULL,
  `hora_ini` time NOT NULL,
  `hora_fin` time NOT NULL,
  `semana_idsemana` varchar(10) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `horario`
--

INSERT INTO `horario` (`idhorario`, `hora_ini`, `hora_fin`, `semana_idsemana`, `baja`, `created_at`, `created_by`) VALUES
(1, '08:00:00', '12:00:00', 'LUNES', NULL, '2017-10-26 20:49:57', NULL),
(2, '14:00:00', '21:00:00', 'MARTES', NULL, '2017-10-26 20:49:57', NULL),
(3, '00:00:00', '00:00:00', 'SÁBADO', NULL, '2017-10-26 23:08:45', NULL),
(5, '00:05:00', '00:00:00', 'SÁBADO', NULL, '2017-10-26 23:09:27', NULL),
(6, '07:00:00', '16:00:00', 'MIÉRCOLES', NULL, '2017-10-26 23:13:35', NULL),
(7, '08:00:00', '20:00:00', 'JUEVES', NULL, '2017-10-26 23:16:04', NULL),
(8, '00:00:00', '00:00:00', 'LUNES', NULL, '2017-10-26 23:50:10', NULL),
(9, '00:00:00', '00:00:00', 'MARTES', NULL, '2017-10-26 23:50:13', NULL),
(19, '00:00:00', '00:00:00', 'DOMINGO', NULL, '2017-10-27 00:10:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `idimage` int(11) NOT NULL,
  `src` varchar(145) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`idimage`, `src`, `title`, `description`, `baja`, `created_at`, `created_by`) VALUES
(1, 'default.jpg', 'Imagen Defualt', 'Imagen por default', NULL, '2017-10-25 22:08:13', NULL),
(28, 'casa-junto-rio-1510168082462.jpg', NULL, NULL, NULL, '2017-11-08 19:08:02', NULL),
(43, 'Quesadilla-1510178377027.jpg', NULL, NULL, NULL, '2017-11-08 21:59:37', NULL),
(44, 'tacos-de-adobada-1510178444813.png', NULL, NULL, NULL, '2017-11-08 22:00:44', NULL),
(45, 'tacos-de-adobada-1510181941580.png', NULL, NULL, NULL, '2017-11-08 22:59:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ingrediente`
--

CREATE TABLE `ingrediente` (
  `idingrediente` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `proteinas` float DEFAULT NULL,
  `calorias` float DEFAULT NULL,
  `carbohidratos` float DEFAULT NULL,
  `grasas` float DEFAULT NULL,
  `ensalada` tinyint(1) DEFAULT NULL,
  `carne` tinyint(1) DEFAULT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingrediente`
--

INSERT INTO `ingrediente` (`idingrediente`, `nombre`, `proteinas`, `calorias`, `carbohidratos`, `grasas`, `ensalada`, `carne`, `unidad_medida`, `baja`, `created_by`, `created_at`) VALUES
(1, 'Jitomate', NULL, NULL, NULL, NULL, 1, 0, 'Gramos', 0, NULL, '2017-11-02 20:58:25'),
(2, 'Cebolla', NULL, NULL, NULL, NULL, 1, 0, 'Gramos', 0, NULL, '2017-11-02 20:59:01'),
(3, 'Res', NULL, NULL, NULL, NULL, 0, 1, 'Gramos', 0, NULL, '2017-11-02 20:59:36'),
(4, 'Pollo', NULL, NULL, NULL, NULL, 0, 1, 'Gramos', 0, NULL, '2017-11-02 21:01:30'),
(5, 'Aceite', NULL, NULL, NULL, NULL, 0, 0, 'Litros', 0, NULL, '2017-11-03 00:47:46');

-- --------------------------------------------------------

--
-- Table structure for table `ingrediente_has_enfermedad`
--

CREATE TABLE `ingrediente_has_enfermedad` (
  `ingrediente_idingrediente` int(11) NOT NULL,
  `enfermedad_idenfermedad` int(11) NOT NULL,
  `descripcion` varchar(245) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `moto`
--

CREATE TABLE `moto` (
  `idmoto` int(11) NOT NULL,
  `marca` varchar(45) NOT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `anio` int(4) NOT NULL,
  `kilometros` int(6) NOT NULL,
  `f_compra` date NOT NULL,
  `status` varchar(25) DEFAULT NULL,
  `status_descripcion` varchar(255) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `motociclista`
--

CREATE TABLE `motociclista` (
  `idmotociclista` int(11) NOT NULL,
  `nombres` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `edad` int(2) DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `status_descripcion` varchar(45) DEFAULT NULL,
  `tipolicencia` varchar(25) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `motoTaller`
--

CREATE TABLE `motoTaller` (
  `idmotoTaller` int(11) NOT NULL,
  `f_ingresa` datetime DEFAULT NULL,
  `f_sale` varchar(45) DEFAULT NULL,
  `problema_reportado` varchar(300) DEFAULT NULL,
  `solucion` varchar(350) DEFAULT NULL,
  `costo_manodeobra` float DEFAULT NULL,
  `costo_refacciones` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `factura` tinyint(1) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `moto_has_motociclista_moto_idmoto` int(11) NOT NULL,
  `moto_has_motociclista_motociclista_idmotociclista` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `moto_has_gasolina`
--

CREATE TABLE `moto_has_gasolina` (
  `moto_idmoto` int(11) NOT NULL,
  `gasolina_idgasolina` int(11) NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `moto_has_motociclista`
--

CREATE TABLE `moto_has_motociclista` (
  `moto_idmoto` int(11) NOT NULL,
  `motociclista_idmotociclista` int(11) NOT NULL,
  `f_toma` datetime NOT NULL,
  `f_deja` datetime DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `status_description` varchar(245) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `oferta`
--

CREATE TABLE `oferta` (
  `idoferta` int(11) NOT NULL,
  `nombre` varchar(145) NOT NULL,
  `descripcion` varchar(245) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  `fecha_ini` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `precio` float DEFAULT NULL,
  `res_has_pla_restaurante_idrestaurante` int(11) NOT NULL,
  `res_has_pla_platillo_idplatillo` int(11) NOT NULL,
  `image_idimage` int(15) DEFAULT '1',
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `oferta`
--

INSERT INTO `oferta` (`idoferta`, `nombre`, `descripcion`, `tipo`, `fecha_ini`, `fecha_fin`, `precio`, `res_has_pla_restaurante_idrestaurante`, `res_has_pla_platillo_idplatillo`, `image_idimage`, `baja`, `created_at`, `created_by`) VALUES
(43, '¡Taquitos en oferta!', 'Compra un taco de adobada y llévate dos grátis', '3x1', '2017-01-01 00:00:00', '2017-12-01 00:00:00', 10, 1, 2, 44, NULL, '2017-11-04 00:53:17', NULL),
(106, 'Llévate 3 y paga sólo una', 'Compra una quesadilla con carne y te regalamos otras dos :9', '3x1', '2017-01-01 00:00:00', '2017-12-01 00:00:00', 20, 1, 1, 43, NULL, '2017-11-07 23:40:26', NULL),
(109, 'Pollo a mitad de precio!', 'Ven por tu pollo a mitad de precio! :9', '50%', '2017-01-01 00:00:00', '2017-12-01 00:00:00', 25, 1, 5, 45, NULL, '2017-11-08 21:11:06', NULL),
(110, '¡Pozole al 2x1!', 'Compra un pozole y llévate otro totalmente grátis!', '2x1', '2017-01-01 00:00:00', '2017-12-01 00:00:00', 50, 2, 3, 1, NULL, '2017-11-08 21:47:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `oferta_has_image`
--

CREATE TABLE `oferta_has_image` (
  `oferta_idoferta` int(11) NOT NULL,
  `image_idimage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `oferta_has_image`
--

INSERT INTO `oferta_has_image` (`oferta_idoferta`, `image_idimage`) VALUES
(43, 1),
(106, 28);

-- --------------------------------------------------------

--
-- Table structure for table `orden`
--

CREATE TABLE `orden` (
  `idorden` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  `restaurante_idrestaurante` int(11) NOT NULL,
  `horaSolicitado` datetime NOT NULL,
  `direccion_iddireccion` int(11) NOT NULL,
  `status` varchar(25) NOT NULL,
  `status_description` varchar(155) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orden_has_platilloOrdenado`
--

CREATE TABLE `orden_has_platilloOrdenado` (
  `orden_idorden` int(11) NOT NULL,
  `platilloOrdenado_idplatilloOrdenado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pago`
--

CREATE TABLE `pago` (
  `idpago` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  `total` float NOT NULL,
  `iva` float NOT NULL,
  `orden_idorden` int(11) NOT NULL,
  `facturar` tinyint(1) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pais`
--

CREATE TABLE `pais` (
  `idpais` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviacion` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pais`
--

INSERT INTO `pais` (`idpais`, `nombre`, `abreviacion`) VALUES
(1, 'México', 'MX');

-- --------------------------------------------------------

--
-- Table structure for table `parada`
--

CREATE TABLE `parada` (
  `idparada` int(11) NOT NULL,
  `h_encamino` datetime DEFAULT NULL,
  `h_llega` datetime DEFAULT NULL,
  `h_sale` datetime DEFAULT NULL,
  `h_llegandoadestino` datetime DEFAULT NULL,
  `h_entregado` datetime DEFAULT NULL,
  `h_esperadaarribo` datetime DEFAULT NULL,
  `h_esperadaencamino` datetime DEFAULT NULL,
  `status` varchar(35) DEFAULT NULL,
  `status_descripcion` varchar(145) DEFAULT NULL,
  `km_recorridos` float DEFAULT NULL,
  `litros_gasolinaestimadausada` float DEFAULT NULL,
  `destinatario_destinatario` varchar(25) NOT NULL,
  `direccion_iddireccion` int(11) NOT NULL,
  `iddestinatario` int(11) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `parada_has_coordenada`
--

CREATE TABLE `parada_has_coordenada` (
  `parada_idparada` int(11) NOT NULL,
  `coordenada_idcoordenada` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `platillo`
--

CREATE TABLE `platillo` (
  `idplatillo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `tipoComida_idtipoComida` int(11) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `platillo`
--

INSERT INTO `platillo` (`idplatillo`, `nombre`, `descripcion`, `tipoComida_idtipoComida`, `baja`, `created_by`, `created_at`) VALUES
(1, 'Quesadilla con carne', 'Ricas quesadillas con carne', 1, NULL, 1, '2017-10-26 19:57:00'),
(2, 'Taco de adobada', 'Ricos tacos de adobada', 1, NULL, 1, '2017-10-26 20:09:11'),
(3, 'Pozole', 'Rico pozole de grano', 1, NULL, 1, '2017-10-30 19:27:16'),
(4, 'Mega quesadillas', 'Quesadilla grande :9', 1, NULL, 1, '2017-11-08 19:14:15'),
(5, 'Pollo a la plancha', 'Rico pollo a la plancha', 1, NULL, 1, '2017-11-08 19:15:03');

-- --------------------------------------------------------

--
-- Table structure for table `platilloHorario`
--

CREATE TABLE `platilloHorario` (
  `platillo_idplatillo` int(11) NOT NULL,
  `hora_ini` time NOT NULL,
  `hora_fin` time NOT NULL,
  `semana_idsemana` varchar(10) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `platilloHorario`
--

INSERT INTO `platilloHorario` (`platillo_idplatillo`, `hora_ini`, `hora_fin`, `semana_idsemana`, `baja`, `created_by`, `updated_at`) VALUES
(1, '04:00:00', '14:00:00', 'VIERNES', NULL, NULL, '2017-11-08 23:00:30'),
(1, '06:00:00', '12:00:00', 'LUNES', NULL, NULL, '2017-10-27 20:25:58'),
(1, '09:00:00', '03:00:00', 'MARTES', NULL, NULL, '2017-10-27 21:09:59'),
(1, '09:00:00', '13:00:00', 'SÁBADO', NULL, NULL, '2017-10-30 19:26:05'),
(1, '09:00:00', '14:00:00', 'MIÉRCOLES', NULL, NULL, '2017-10-27 21:10:41'),
(1, '09:00:00', '16:00:00', 'SÁBADO', NULL, NULL, '2017-10-29 14:54:31'),
(1, '09:00:00', '16:00:00', 'VIERNES', NULL, NULL, '2017-10-29 14:54:03');

-- --------------------------------------------------------

--
-- Table structure for table `platilloOrdenado`
--

CREATE TABLE `platilloOrdenado` (
  `idplatilloOrdenado` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  `res_has_pla_restaurante_idrestaurante` int(11) NOT NULL,
  `res_has_pla_platillo_idplatillo` int(11) NOT NULL,
  `horaSale` datetime NOT NULL,
  `horaEntregado` datetime NOT NULL,
  `horaPreparacion` datetime NOT NULL,
  `horaSolicitado` datetime NOT NULL,
  `status` varchar(25) NOT NULL,
  `status_description` varchar(145) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `platilloOrdenado_has_rest_plat_ing`
--

CREATE TABLE `platilloOrdenado_has_rest_plat_ing` (
  `platilloOrdenado_idplatilloOrdenado` int(11) NOT NULL,
  `res_pla_ing_idrest_plat_ing` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante`
--

CREATE TABLE `restaurante` (
  `idrestaurante` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `direccion_iddireccion` int(11) NOT NULL,
  `restaurante_matriz_idrestaurante_matriz` int(11) NOT NULL,
  `user_iduser` int(11) NOT NULL,
  `razon` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `restaurante_idrestaurante` int(11) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `restaurante`
--

INSERT INTO `restaurante` (`idrestaurante`, `descripcion`, `direccion_iddireccion`, `restaurante_matriz_idrestaurante_matriz`, `user_iduser`, `razon`, `nombre`, `restaurante_idrestaurante`, `baja`, `created_by`, `created_at`) VALUES
(1, 'Restaurante de comida variada', 6, 0, 1, 'razon', 'Los cantaritos', NULL, NULL, 1, '2017-10-25 22:30:11'),
(2, 'Restaurante de comida expres!', 7, 0, 1, 'razon social', 'La parrila', NULL, NULL, 1, '2017-10-25 22:35:26');

-- --------------------------------------------------------

--
-- Table structure for table `restauranteHorario`
--

CREATE TABLE `restauranteHorario` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `hora_ini` time NOT NULL,
  `hora_fin` time NOT NULL,
  `semana_idsemana` varchar(10) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_email`
--

CREATE TABLE `restaurante_has_email` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `email_idemail` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_image`
--

CREATE TABLE `restaurante_has_image` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `image_idimage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_platillo`
--

CREATE TABLE `restaurante_has_platillo` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `platillo_idplatillo` int(11) NOT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `tiempopreparacion` time DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `restaurante_has_platillo`
--

INSERT INTO `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`, `precio`, `descripcion`, `tiempopreparacion`, `baja`, `created_at`, `created_by`) VALUES
(1, 1, '15', 'Ricas quesadillas con carne', '00:20:00', NULL, '2017-10-26 19:57:00', 1),
(1, 2, '10', 'Ricos tacos de adobada', '00:10:00', NULL, '2017-10-26 20:09:11', 1),
(1, 5, '60', 'Rico pollo a la plancha', '00:25:00', NULL, '2017-11-08 19:15:03', 1),
(2, 3, '50', 'Rico pozole de grano', '00:35:00', NULL, '2017-10-30 19:27:16', 1),
(2, 4, '35', 'Quesadilla grande :9', '00:20:00', NULL, '2017-11-08 19:14:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_platillo_has_image`
--

CREATE TABLE `restaurante_has_platillo_has_image` (
  `restaurante_has_platillo_restaurante_idrestaurante` int(11) NOT NULL,
  `restaurante_has_platillo_platillo_idplatillo` int(11) NOT NULL,
  `image_idimage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_tarjeta`
--

CREATE TABLE `restaurante_has_tarjeta` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `tarjeta_idtarjeta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_has_telefono`
--

CREATE TABLE `restaurante_has_telefono` (
  `restaurante_idrestaurante` int(11) NOT NULL,
  `telefono_idtelefono` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurante_platillo_ingrediente`
--

CREATE TABLE `restaurante_platillo_ingrediente` (
  `idrest_plat_ing` int(11) NOT NULL,
  `res_has_pla_restaurante_idrestaurante` int(11) NOT NULL,
  `res_has_pla_platillo_idplatillo` int(11) NOT NULL,
  `ingrediente_idingrediente` int(11) NOT NULL,
  `precio` float NOT NULL DEFAULT '0',
  `medida` float DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `restaurante_platillo_ingrediente`
--

INSERT INTO `restaurante_platillo_ingrediente` (`idrest_plat_ing`, `res_has_pla_restaurante_idrestaurante`, `res_has_pla_platillo_idplatillo`, `ingrediente_idingrediente`, `precio`, `medida`, `default`) VALUES
(30, 1, 1, 2, 10, 10, 0),
(31, 1, 1, 3, 0, 100, 1),
(32, 1, 2, 4, 0, 230, 1),
(33, 1, 2, 1, 0, 10, 1),
(34, 1, 2, 3, 111, 11, 0),
(35, 1, 1, 4, 0, 100, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `idrol` varchar(45) NOT NULL,
  `descripcion` varchar(145) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`idrol`, `descripcion`) VALUES
('1', 'CLIENTE'),
('2', 'EMPRESA');

-- --------------------------------------------------------

--
-- Table structure for table `semana`
--

CREATE TABLE `semana` (
  `idsemana` varchar(10) NOT NULL,
  `orden` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `semana`
--

INSERT INTO `semana` (`idsemana`, `orden`) VALUES
('DOMINGO', 7),
('JUEVES', 4),
('LUNES', 1),
('MARTES', 2),
('MIÉRCOLES', 3),
('SÁBADO', 6),
('VIERNES', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tarjeta`
--

CREATE TABLE `tarjeta` (
  `idtarjeta` int(11) NOT NULL,
  `numero` binary(60) NOT NULL,
  `clave` binary(60) NOT NULL,
  `nombre` binary(60) DEFAULT NULL,
  `banco` varchar(15) NOT NULL,
  `principal` tinyint(1) DEFAULT NULL,
  `activa` tinyint(1) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `telefono`
--

CREATE TABLE `telefono` (
  `idtelefono` int(11) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `lada` varchar(5) NOT NULL,
  `compania` varchar(15) DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `telefono`
--

INSERT INTO `telefono` (`idtelefono`, `numero`, `lada`, `compania`, `baja`, `created_at`) VALUES
(1, '3416789087', '+51', 'Telcel', NULL, '2017-10-25 22:08:13'),
(2, '3411361316', '+51', 'Telcel', NULL, '2017-10-25 22:09:30');

-- --------------------------------------------------------

--
-- Table structure for table `tipoComida`
--

CREATE TABLE `tipoComida` (
  `idtipoComida` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `descripcion` varchar(145) DEFAULT NULL,
  `region` varchar(45) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipoComida`
--

INSERT INTO `tipoComida` (`idtipoComida`, `nombre`, `descripcion`, `region`, `baja`, `created_at`, `created_by`) VALUES
(1, 'Mexicana', 'Comida tradicional mexicana', 'México', NULL, '2017-10-26 19:56:24', NULL),
(2, 'Italiana', 'Comida tradicional italiana', 'Italia', NULL, '2017-10-26 19:56:24', NULL),
(3, 'China', 'Comida tradicional china', 'China', NULL, '2017-10-26 19:56:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `iduser` int(11) NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `email` varchar(45) CHARACTER SET big5 NOT NULL,
  `password` binary(60) NOT NULL,
  `telefono_idtelefono` int(11) NOT NULL,
  `rol_idrol` varchar(45) NOT NULL,
  `image_idimage` int(11) NOT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`iduser`, `nombres`, `apellidos`, `email`, `password`, `telefono_idtelefono`, `rol_idrol`, `image_idimage`, `baja`, `created_at`, `created_by`) VALUES
(1, 'Brandon', 'Villa', 'brandon@gmail.com', 0x243261243130246b31566f77783874435172464a62465441304c79584f585a46476d36634b76324d726746416157344b3542376f36644b7369736d57, 2, '1', 1, NULL, '2017-10-25 22:09:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_has_direccion`
--

CREATE TABLE `user_has_direccion` (
  `user_iduser` int(11) NOT NULL,
  `direccion_iddireccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_has_tarjeta`
--

CREATE TABLE `user_has_tarjeta` (
  `user_iduser` int(11) NOT NULL,
  `user_rol_idrol` varchar(45) NOT NULL,
  `tarjeta_idtarjeta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `viaje`
--

CREATE TABLE `viaje` (
  `idviaje` int(11) NOT NULL,
  `orden_idorden` int(11) NOT NULL,
  `moto_has_motociclista_moto_idmoto` int(11) NOT NULL,
  `moto_has_motociclista_motociclista_idmotociclista` int(11) NOT NULL,
  `h_salida` datetime NOT NULL,
  `h_regresa` datetime DEFAULT NULL,
  `status` varchar(35) DEFAULT NULL,
  `status_descripcion` varchar(145) DEFAULT NULL,
  `km_iniciales` float NOT NULL,
  `km_recorridos` float DEFAULT NULL,
  `litros_gasolina_inicia` float NOT NULL,
  `litros_gasolina_termina` float DEFAULT NULL,
  `litros_gasolina_usados` float DEFAULT NULL,
  `baja` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`idciudad`),
  ADD KEY `fk_ciudad_estado1_idx` (`estado_idestado`);

--
-- Indexes for table `combo`
--
ALTER TABLE `combo`
  ADD PRIMARY KEY (`idcombo`),
  ADD KEY `nombre` (`nombre`),
  ADD KEY `descripcion` (`descripcion`);

--
-- Indexes for table `combo_has_restaurante_has_platillo`
--
ALTER TABLE `combo_has_restaurante_has_platillo`
  ADD PRIMARY KEY (`combo_idcombo`,`res_has_platillo_res_idrestaurante`,`res_has_pla_platillo_idplatillo`),
  ADD KEY `fk_combo_has_restaurante_has_platillo_restaurante_has_plati_idx` (`res_has_platillo_res_idrestaurante`,`res_has_pla_platillo_idplatillo`),
  ADD KEY `fk_combo_has_restaurante_has_platillo_combo1_idx` (`combo_idcombo`);

--
-- Indexes for table `conducta`
--
ALTER TABLE `conducta`
  ADD PRIMARY KEY (`idconducta`),
  ADD KEY `fk_conducta_motociclista1_idx` (`motociclista_idmotociclista`);

--
-- Indexes for table `coordenada`
--
ALTER TABLE `coordenada`
  ADD PRIMARY KEY (`idcoordenada`);

--
-- Indexes for table `destinatario`
--
ALTER TABLE `destinatario`
  ADD PRIMARY KEY (`destinatario`);

--
-- Indexes for table `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`iddireccion`),
  ADD KEY `fk_direccion_ciudad1_idx` (`ciudad_idciudad`),
  ADD KEY `calle` (`calle`),
  ADD KEY `entrecalles` (`entrecalle1`,`entrecalle2`),
  ADD KEY `colonia` (`colonia`),
  ADD KEY `cp` (`cp`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`idemail`);

--
-- Indexes for table `enfermedad`
--
ALTER TABLE `enfermedad`
  ADD PRIMARY KEY (`idenfermedad`),
  ADD KEY `nombre` (`nombre`);

--
-- Indexes for table `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`idestado`),
  ADD KEY `fk_estado_pais1_idx` (`pais_idpais`);

--
-- Indexes for table `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idfactura`),
  ADD KEY `fk_factura_direccion1_idx` (`direccion_iddireccion`),
  ADD KEY `fk_factura_pago1_idx` (`pago_idpago`),
  ADD KEY `rfc` (`rfc`);

--
-- Indexes for table `gasolina`
--
ALTER TABLE `gasolina`
  ADD PRIMARY KEY (`idgasolina`);

--
-- Indexes for table `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`idhorario`,`semana_idsemana`),
  ADD UNIQUE KEY `index_unique1` (`hora_ini`,`hora_fin`,`semana_idsemana`),
  ADD KEY `fk_horario_semana1_idx` (`semana_idsemana`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`idimage`);

--
-- Indexes for table `ingrediente`
--
ALTER TABLE `ingrediente`
  ADD PRIMARY KEY (`idingrediente`),
  ADD KEY `calorias` (`calorias`),
  ADD KEY `proteinas` (`proteinas`),
  ADD KEY `carbohidratos` (`carbohidratos`);

--
-- Indexes for table `ingrediente_has_enfermedad`
--
ALTER TABLE `ingrediente_has_enfermedad`
  ADD PRIMARY KEY (`ingrediente_idingrediente`,`enfermedad_idenfermedad`),
  ADD KEY `fk_ingrediente_has_enfermedad_enfermedad1_idx` (`enfermedad_idenfermedad`),
  ADD KEY `fk_ingrediente_has_enfermedad_ingrediente1_idx` (`ingrediente_idingrediente`);

--
-- Indexes for table `moto`
--
ALTER TABLE `moto`
  ADD PRIMARY KEY (`idmoto`);

--
-- Indexes for table `motociclista`
--
ALTER TABLE `motociclista`
  ADD PRIMARY KEY (`idmotociclista`);

--
-- Indexes for table `motoTaller`
--
ALTER TABLE `motoTaller`
  ADD PRIMARY KEY (`idmotoTaller`),
  ADD KEY `fk_motoTaller_moto_has_motociclista1_idx` (`moto_has_motociclista_moto_idmoto`,`moto_has_motociclista_motociclista_idmotociclista`);

--
-- Indexes for table `moto_has_gasolina`
--
ALTER TABLE `moto_has_gasolina`
  ADD PRIMARY KEY (`moto_idmoto`,`gasolina_idgasolina`),
  ADD KEY `fk_moto_has_gasolina_gasolina1_idx` (`gasolina_idgasolina`),
  ADD KEY `fk_moto_has_gasolina_moto1_idx` (`moto_idmoto`);

--
-- Indexes for table `moto_has_motociclista`
--
ALTER TABLE `moto_has_motociclista`
  ADD PRIMARY KEY (`moto_idmoto`,`motociclista_idmotociclista`),
  ADD KEY `fk_moto_has_motociclista_motociclista1_idx` (`motociclista_idmotociclista`),
  ADD KEY `fk_moto_has_motociclista_moto1_idx` (`moto_idmoto`);

--
-- Indexes for table `oferta`
--
ALTER TABLE `oferta`
  ADD PRIMARY KEY (`idoferta`),
  ADD KEY `fk_oferta_restaurante_has_platillo1_idx` (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`),
  ADD KEY `nombre` (`nombre`),
  ADD KEY `descripcion` (`descripcion`),
  ADD KEY `FK_oferta_image_idimage` (`image_idimage`);

--
-- Indexes for table `oferta_has_image`
--
ALTER TABLE `oferta_has_image`
  ADD PRIMARY KEY (`oferta_idoferta`),
  ADD KEY `fk_oferta_has_image_image1_idx` (`image_idimage`),
  ADD KEY `fk_oferta_has_image_oferta1_idx` (`oferta_idoferta`);

--
-- Indexes for table `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`idorden`),
  ADD KEY `fk_orden_user1_idx` (`user_iduser`),
  ADD KEY `fk_orden_direccion1_idx` (`direccion_iddireccion`),
  ADD KEY `status` (`status`),
  ADD KEY `horaSolicitado` (`horaSolicitado`),
  ADD KEY `fk_orden_restaurante1_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `orden_has_platilloOrdenado`
--
ALTER TABLE `orden_has_platilloOrdenado`
  ADD PRIMARY KEY (`orden_idorden`,`platilloOrdenado_idplatilloOrdenado`),
  ADD KEY `fk_orden_has_platilloOrdenado_platilloOrdenado1_idx` (`platilloOrdenado_idplatilloOrdenado`),
  ADD KEY `fk_orden_has_platilloOrdenado_orden1_idx` (`orden_idorden`);

--
-- Indexes for table `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`idpago`),
  ADD KEY `fk_pago_orden1_idx` (`orden_idorden`);

--
-- Indexes for table `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`idpais`);

--
-- Indexes for table `parada`
--
ALTER TABLE `parada`
  ADD PRIMARY KEY (`idparada`),
  ADD KEY `fk_parada_destinatario1_idx` (`destinatario_destinatario`),
  ADD KEY `fk_parada_direccion1_idx` (`direccion_iddireccion`);

--
-- Indexes for table `parada_has_coordenada`
--
ALTER TABLE `parada_has_coordenada`
  ADD PRIMARY KEY (`parada_idparada`,`coordenada_idcoordenada`),
  ADD KEY `fk_parada_has_coordenada_coordenada1_idx` (`coordenada_idcoordenada`),
  ADD KEY `fk_parada_has_coordenada_parada1_idx` (`parada_idparada`);

--
-- Indexes for table `platillo`
--
ALTER TABLE `platillo`
  ADD PRIMARY KEY (`idplatillo`,`tipoComida_idtipoComida`),
  ADD KEY `nombre` (`nombre`),
  ADD KEY `descripcion` (`descripcion`),
  ADD KEY `fk_platillo_tipoComida1_idx` (`tipoComida_idtipoComida`);

--
-- Indexes for table `platilloHorario`
--
ALTER TABLE `platilloHorario`
  ADD PRIMARY KEY (`platillo_idplatillo`,`hora_ini`,`hora_fin`,`semana_idsemana`),
  ADD KEY `semana_idsemana` (`semana_idsemana`);

--
-- Indexes for table `platilloOrdenado`
--
ALTER TABLE `platilloOrdenado`
  ADD PRIMARY KEY (`idplatilloOrdenado`),
  ADD KEY `fk_platilloOrdenado_user1_idx` (`user_iduser`),
  ADD KEY `fk_platilloOrdenado_restaurante_has_platillo1_idx` (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`),
  ADD KEY `status` (`status`),
  ADD KEY `horaSale` (`horaSale`),
  ADD KEY `horaPreparacion` (`horaPreparacion`),
  ADD KEY `horaSolicitado` (`horaSolicitado`),
  ADD KEY `horaEntregado` (`horaEntregado`);

--
-- Indexes for table `platilloOrdenado_has_rest_plat_ing`
--
ALTER TABLE `platilloOrdenado_has_rest_plat_ing`
  ADD PRIMARY KEY (`platilloOrdenado_idplatilloOrdenado`,`res_pla_ing_idrest_plat_ing`),
  ADD KEY `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_re_idx` (`res_pla_ing_idrest_plat_ing`),
  ADD KEY `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_pl_idx` (`platilloOrdenado_idplatilloOrdenado`);

--
-- Indexes for table `restaurante`
--
ALTER TABLE `restaurante`
  ADD PRIMARY KEY (`idrestaurante`),
  ADD KEY `fk_restaurante_direccion1_idx` (`direccion_iddireccion`),
  ADD KEY `fk_restaurante_user1_idx` (`user_iduser`),
  ADD KEY `fk_restaurante_restaurante1_idx` (`restaurante_idrestaurante`),
  ADD KEY `nombre` (`nombre`),
  ADD KEY `descripcion` (`descripcion`);

--
-- Indexes for table `restauranteHorario`
--
ALTER TABLE `restauranteHorario`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`hora_ini`,`hora_fin`,`semana_idsemana`),
  ADD KEY `semana_idsemana` (`semana_idsemana`);

--
-- Indexes for table `restaurante_has_email`
--
ALTER TABLE `restaurante_has_email`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`email_idemail`),
  ADD KEY `fk_restaurante_has_email_email1_idx` (`email_idemail`),
  ADD KEY `fk_restaurante_has_email_restaurante1_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `restaurante_has_image`
--
ALTER TABLE `restaurante_has_image`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`image_idimage`),
  ADD KEY `fk_restaurante_has_image_image1_idx` (`image_idimage`),
  ADD KEY `fk_restaurante_has_image_restaurante1_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `restaurante_has_platillo`
--
ALTER TABLE `restaurante_has_platillo`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`platillo_idplatillo`),
  ADD KEY `fk_restaurante_has_platillo_platillo1_idx` (`platillo_idplatillo`),
  ADD KEY `fk_restaurante_has_platillo_restaurante1_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `restaurante_has_platillo_has_image`
--
ALTER TABLE `restaurante_has_platillo_has_image`
  ADD PRIMARY KEY (`restaurante_has_platillo_restaurante_idrestaurante`,`restaurante_has_platillo_platillo_idplatillo`,`image_idimage`),
  ADD KEY `fk_restaurante_has_platillo_has_image_image1_idx` (`image_idimage`),
  ADD KEY `fk_restaurante_has_platillo_has_image_restaurante_has_plati_idx` (`restaurante_has_platillo_restaurante_idrestaurante`,`restaurante_has_platillo_platillo_idplatillo`);

--
-- Indexes for table `restaurante_has_tarjeta`
--
ALTER TABLE `restaurante_has_tarjeta`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`tarjeta_idtarjeta`),
  ADD KEY `fk_restaurante_has_tarjeta_tarjeta1_idx` (`tarjeta_idtarjeta`),
  ADD KEY `fk_restaurante_has_tarjeta_restaurante1_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `restaurante_has_telefono`
--
ALTER TABLE `restaurante_has_telefono`
  ADD PRIMARY KEY (`restaurante_idrestaurante`,`telefono_idtelefono`),
  ADD KEY `fk_restaurante_has_telefono_telefono1_idx` (`telefono_idtelefono`),
  ADD KEY `fk_restaurante_has_telefono_restaurante_idx` (`restaurante_idrestaurante`);

--
-- Indexes for table `restaurante_platillo_ingrediente`
--
ALTER TABLE `restaurante_platillo_ingrediente`
  ADD PRIMARY KEY (`idrest_plat_ing`,`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`,`ingrediente_idingrediente`),
  ADD KEY `fk_restaurante_has_platillo_has_ingrediente_ingrediente1_idx` (`ingrediente_idingrediente`),
  ADD KEY `fk_restaurante_has_platillo_has_ingrediente_restaurante_has_idx` (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indexes for table `semana`
--
ALTER TABLE `semana`
  ADD PRIMARY KEY (`idsemana`);

--
-- Indexes for table `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD PRIMARY KEY (`idtarjeta`),
  ADD UNIQUE KEY `numero_UNIQUE` (`numero`);

--
-- Indexes for table `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`idtelefono`),
  ADD KEY `numero` (`numero`);

--
-- Indexes for table `tipoComida`
--
ALTER TABLE `tipoComida`
  ADD PRIMARY KEY (`idtipoComida`),
  ADD KEY `nombre` (`nombre`),
  ADD KEY `region` (`region`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`iduser`,`rol_idrol`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `fk_user_telefono1_idx` (`telefono_idtelefono`),
  ADD KEY `fk_user_rol1_idx` (`rol_idrol`),
  ADD KEY `fk_user_image1_idx` (`image_idimage`);

--
-- Indexes for table `user_has_direccion`
--
ALTER TABLE `user_has_direccion`
  ADD PRIMARY KEY (`user_iduser`,`direccion_iddireccion`),
  ADD KEY `fk_user_has_direccion_direccion1_idx` (`direccion_iddireccion`),
  ADD KEY `fk_user_has_direccion_user1_idx` (`user_iduser`);

--
-- Indexes for table `user_has_tarjeta`
--
ALTER TABLE `user_has_tarjeta`
  ADD PRIMARY KEY (`user_iduser`,`user_rol_idrol`,`tarjeta_idtarjeta`),
  ADD KEY `fk_user_has_tarjeta_tarjeta1_idx` (`tarjeta_idtarjeta`),
  ADD KEY `fk_user_has_tarjeta_user1_idx` (`user_iduser`,`user_rol_idrol`);

--
-- Indexes for table `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`idviaje`),
  ADD KEY `fk_viaje_moto_has_motociclista1_idx` (`moto_has_motociclista_moto_idmoto`,`moto_has_motociclista_motociclista_idmotociclista`),
  ADD KEY `fk_viaje_orden1_idx` (`orden_idorden`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `idciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `combo`
--
ALTER TABLE `combo`
  MODIFY `idcombo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `conducta`
--
ALTER TABLE `conducta`
  MODIFY `idconducta` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `coordenada`
--
ALTER TABLE `coordenada`
  MODIFY `idcoordenada` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `direccion`
--
ALTER TABLE `direccion`
  MODIFY `iddireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `idemail` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `enfermedad`
--
ALTER TABLE `enfermedad`
  MODIFY `idenfermedad` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `estado`
--
ALTER TABLE `estado`
  MODIFY `idestado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `factura`
--
ALTER TABLE `factura`
  MODIFY `idfactura` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gasolina`
--
ALTER TABLE `gasolina`
  MODIFY `idgasolina` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `horario`
--
ALTER TABLE `horario`
  MODIFY `idhorario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `idimage` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `ingrediente`
--
ALTER TABLE `ingrediente`
  MODIFY `idingrediente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `moto`
--
ALTER TABLE `moto`
  MODIFY `idmoto` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `motociclista`
--
ALTER TABLE `motociclista`
  MODIFY `idmotociclista` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `motoTaller`
--
ALTER TABLE `motoTaller`
  MODIFY `idmotoTaller` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oferta`
--
ALTER TABLE `oferta`
  MODIFY `idoferta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
--
-- AUTO_INCREMENT for table `orden`
--
ALTER TABLE `orden`
  MODIFY `idorden` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pago`
--
ALTER TABLE `pago`
  MODIFY `idpago` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pais`
--
ALTER TABLE `pais`
  MODIFY `idpais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `parada`
--
ALTER TABLE `parada`
  MODIFY `idparada` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `platillo`
--
ALTER TABLE `platillo`
  MODIFY `idplatillo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `platilloOrdenado`
--
ALTER TABLE `platilloOrdenado`
  MODIFY `idplatilloOrdenado` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `restaurante`
--
ALTER TABLE `restaurante`
  MODIFY `idrestaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `restaurante_platillo_ingrediente`
--
ALTER TABLE `restaurante_platillo_ingrediente`
  MODIFY `idrest_plat_ing` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `telefono`
--
ALTER TABLE `telefono`
  MODIFY `idtelefono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tipoComida`
--
ALTER TABLE `tipoComida`
  MODIFY `idtipoComida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `viaje`
--
ALTER TABLE `viaje`
  MODIFY `idviaje` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `fk_ciudad_estado1` FOREIGN KEY (`estado_idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `combo_has_restaurante_has_platillo`
--
ALTER TABLE `combo_has_restaurante_has_platillo`
  ADD CONSTRAINT `fk_combo_has_restaurante_has_platillo_combo1` FOREIGN KEY (`combo_idcombo`) REFERENCES `combo` (`idcombo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_combo_has_restaurante_has_platillo_restaurante_has_platillo1` FOREIGN KEY (`res_has_platillo_res_idrestaurante`,`res_has_pla_platillo_idplatillo`) REFERENCES `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `conducta`
--
ALTER TABLE `conducta`
  ADD CONSTRAINT `fk_conducta_motociclista1` FOREIGN KEY (`motociclista_idmotociclista`) REFERENCES `motociclista` (`idmotociclista`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `direccion`
--
ALTER TABLE `direccion`
  ADD CONSTRAINT `fk_direccion_ciudad1` FOREIGN KEY (`ciudad_idciudad`) REFERENCES `ciudad` (`idciudad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `estado`
--
ALTER TABLE `estado`
  ADD CONSTRAINT `fk_estado_pais1` FOREIGN KEY (`pais_idpais`) REFERENCES `pais` (`idpais`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_factura_direccion1` FOREIGN KEY (`direccion_iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_factura_pago1` FOREIGN KEY (`pago_idpago`) REFERENCES `pago` (`idpago`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `fk_horario_semana1` FOREIGN KEY (`semana_idsemana`) REFERENCES `semana` (`idsemana`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ingrediente_has_enfermedad`
--
ALTER TABLE `ingrediente_has_enfermedad`
  ADD CONSTRAINT `fk_ingrediente_has_enfermedad_enfermedad1` FOREIGN KEY (`enfermedad_idenfermedad`) REFERENCES `enfermedad` (`idenfermedad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingrediente_has_enfermedad_ingrediente1` FOREIGN KEY (`ingrediente_idingrediente`) REFERENCES `ingrediente` (`idingrediente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `motoTaller`
--
ALTER TABLE `motoTaller`
  ADD CONSTRAINT `fk_motoTaller_moto_has_motociclista1` FOREIGN KEY (`moto_has_motociclista_moto_idmoto`,`moto_has_motociclista_motociclista_idmotociclista`) REFERENCES `moto_has_motociclista` (`moto_idmoto`, `motociclista_idmotociclista`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `moto_has_gasolina`
--
ALTER TABLE `moto_has_gasolina`
  ADD CONSTRAINT `fk_moto_has_gasolina_gasolina1` FOREIGN KEY (`gasolina_idgasolina`) REFERENCES `gasolina` (`idgasolina`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_moto_has_gasolina_moto1` FOREIGN KEY (`moto_idmoto`) REFERENCES `moto` (`idmoto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `moto_has_motociclista`
--
ALTER TABLE `moto_has_motociclista`
  ADD CONSTRAINT `fk_moto_has_motociclista_moto1` FOREIGN KEY (`moto_idmoto`) REFERENCES `moto` (`idmoto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_moto_has_motociclista_motociclista1` FOREIGN KEY (`motociclista_idmotociclista`) REFERENCES `motociclista` (`idmotociclista`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `oferta`
--
ALTER TABLE `oferta`
  ADD CONSTRAINT `FK_oferta_image_idimage` FOREIGN KEY (`image_idimage`) REFERENCES `image` (`idimage`),
  ADD CONSTRAINT `fk_oferta_restaurante_has_platillo1` FOREIGN KEY (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`) REFERENCES `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `oferta_has_image`
--
ALTER TABLE `oferta_has_image`
  ADD CONSTRAINT `fk_oferta_has_image_image1` FOREIGN KEY (`image_idimage`) REFERENCES `image` (`idimage`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_oferta_has_image_oferta1` FOREIGN KEY (`oferta_idoferta`) REFERENCES `oferta` (`idoferta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `fk_orden_direccion1` FOREIGN KEY (`direccion_iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orden_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orden_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `orden_has_platilloOrdenado`
--
ALTER TABLE `orden_has_platilloOrdenado`
  ADD CONSTRAINT `fk_orden_has_platilloOrdenado_orden1` FOREIGN KEY (`orden_idorden`) REFERENCES `orden` (`idorden`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orden_has_platilloOrdenado_platilloOrdenado1` FOREIGN KEY (`platilloOrdenado_idplatilloOrdenado`) REFERENCES `platilloOrdenado` (`idplatilloOrdenado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_pago_orden1` FOREIGN KEY (`orden_idorden`) REFERENCES `orden` (`idorden`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `parada`
--
ALTER TABLE `parada`
  ADD CONSTRAINT `fk_parada_destinatario1` FOREIGN KEY (`destinatario_destinatario`) REFERENCES `destinatario` (`destinatario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_parada_direccion1` FOREIGN KEY (`direccion_iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `parada_has_coordenada`
--
ALTER TABLE `parada_has_coordenada`
  ADD CONSTRAINT `fk_parada_has_coordenada_coordenada1` FOREIGN KEY (`coordenada_idcoordenada`) REFERENCES `coordenada` (`idcoordenada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_parada_has_coordenada_parada1` FOREIGN KEY (`parada_idparada`) REFERENCES `parada` (`idparada`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `platillo`
--
ALTER TABLE `platillo`
  ADD CONSTRAINT `fk_platillo_tipoComida1` FOREIGN KEY (`tipoComida_idtipoComida`) REFERENCES `tipoComida` (`idtipoComida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `platilloHorario`
--
ALTER TABLE `platilloHorario`
  ADD CONSTRAINT `platillohorario_ibfk_1` FOREIGN KEY (`semana_idsemana`) REFERENCES `semana` (`idsemana`),
  ADD CONSTRAINT `platillohorario_ibfk_2` FOREIGN KEY (`platillo_idplatillo`) REFERENCES `platillo` (`idplatillo`);

--
-- Constraints for table `platilloOrdenado`
--
ALTER TABLE `platilloOrdenado`
  ADD CONSTRAINT `fk_platilloOrdenado_restaurante_has_platillo1` FOREIGN KEY (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`) REFERENCES `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_platilloOrdenado_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `platilloOrdenado_has_rest_plat_ing`
--
ALTER TABLE `platilloOrdenado_has_rest_plat_ing`
  ADD CONSTRAINT `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_plat1` FOREIGN KEY (`platilloOrdenado_idplatilloOrdenado`) REFERENCES `platilloOrdenado` (`idplatilloOrdenado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_rest1` FOREIGN KEY (`res_pla_ing_idrest_plat_ing`) REFERENCES `restaurante_platillo_ingrediente` (`idrest_plat_ing`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante`
--
ALTER TABLE `restaurante`
  ADD CONSTRAINT `fk_restaurante_direccion1` FOREIGN KEY (`direccion_iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restauranteHorario`
--
ALTER TABLE `restauranteHorario`
  ADD CONSTRAINT `restaurantehorario_ibfk_1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`),
  ADD CONSTRAINT `restaurantehorario_ibfk_2` FOREIGN KEY (`semana_idsemana`) REFERENCES `semana` (`idsemana`);

--
-- Constraints for table `restaurante_has_email`
--
ALTER TABLE `restaurante_has_email`
  ADD CONSTRAINT `fk_restaurante_has_email_email1` FOREIGN KEY (`email_idemail`) REFERENCES `email` (`idemail`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_email_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_has_image`
--
ALTER TABLE `restaurante_has_image`
  ADD CONSTRAINT `fk_restaurante_has_image_image1` FOREIGN KEY (`image_idimage`) REFERENCES `image` (`idimage`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_image_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_has_platillo`
--
ALTER TABLE `restaurante_has_platillo`
  ADD CONSTRAINT `fk_restaurante_has_platillo_platillo1` FOREIGN KEY (`platillo_idplatillo`) REFERENCES `platillo` (`idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_platillo_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_has_platillo_has_image`
--
ALTER TABLE `restaurante_has_platillo_has_image`
  ADD CONSTRAINT `fk_restaurante_has_platillo_has_image_image1` FOREIGN KEY (`image_idimage`) REFERENCES `image` (`idimage`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_platillo_has_image_restaurante_has_platillo1` FOREIGN KEY (`restaurante_has_platillo_restaurante_idrestaurante`,`restaurante_has_platillo_platillo_idplatillo`) REFERENCES `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_has_tarjeta`
--
ALTER TABLE `restaurante_has_tarjeta`
  ADD CONSTRAINT `fk_restaurante_has_tarjeta_restaurante1` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_tarjeta_tarjeta1` FOREIGN KEY (`tarjeta_idtarjeta`) REFERENCES `tarjeta` (`idtarjeta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_has_telefono`
--
ALTER TABLE `restaurante_has_telefono`
  ADD CONSTRAINT `fk_restaurante_has_telefono_restaurante` FOREIGN KEY (`restaurante_idrestaurante`) REFERENCES `restaurante` (`idrestaurante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_telefono_telefono1` FOREIGN KEY (`telefono_idtelefono`) REFERENCES `telefono` (`idtelefono`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `restaurante_platillo_ingrediente`
--
ALTER TABLE `restaurante_platillo_ingrediente`
  ADD CONSTRAINT `fk_restaurante_has_platillo_has_ingrediente_ingrediente1` FOREIGN KEY (`ingrediente_idingrediente`) REFERENCES `ingrediente` (`idingrediente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_restaurante_has_platillo_has_ingrediente_restaurante_has_p1` FOREIGN KEY (`res_has_pla_restaurante_idrestaurante`,`res_has_pla_platillo_idplatillo`) REFERENCES `restaurante_has_platillo` (`restaurante_idrestaurante`, `platillo_idplatillo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_image1` FOREIGN KEY (`image_idimage`) REFERENCES `image` (`idimage`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_rol1` FOREIGN KEY (`rol_idrol`) REFERENCES `rol` (`idrol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_telefono1` FOREIGN KEY (`telefono_idtelefono`) REFERENCES `telefono` (`idtelefono`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_has_direccion`
--
ALTER TABLE `user_has_direccion`
  ADD CONSTRAINT `fk_user_has_direccion_direccion1` FOREIGN KEY (`direccion_iddireccion`) REFERENCES `direccion` (`iddireccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_has_direccion_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_has_tarjeta`
--
ALTER TABLE `user_has_tarjeta`
  ADD CONSTRAINT `fk_user_has_tarjeta_tarjeta1` FOREIGN KEY (`tarjeta_idtarjeta`) REFERENCES `tarjeta` (`idtarjeta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_has_tarjeta_user1` FOREIGN KEY (`user_iduser`,`user_rol_idrol`) REFERENCES `user` (`iduser`, `rol_idrol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `fk_viaje_moto_has_motociclista1` FOREIGN KEY (`moto_has_motociclista_moto_idmoto`,`moto_has_motociclista_motociclista_idmotociclista`) REFERENCES `moto_has_motociclista` (`moto_idmoto`, `motociclista_idmotociclista`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_viaje_orden1` FOREIGN KEY (`orden_idorden`) REFERENCES `orden` (`idorden`) ON DELETE NO ACTION ON UPDATE NO ACTION;
