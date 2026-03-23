CREATE DATABASE  IF NOT EXISTS `sistema_inventario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_inventario`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_inventario
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `almacen` (
  `id_almacen` int NOT NULL AUTO_INCREMENT,
  `nombre_almacen` varchar(50) NOT NULL,
  `ubicacion_almacen` varchar(80) NOT NULL,
  PRIMARY KEY (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` VALUES (1,'Almacen Central','Av. Principal 123, Ciudad Central'),(2,'Almacen Norte','Zona Industrial Norte, Calle 5'),(3,'Almacen Sur','Avenida del Sur 456, Zona Comercial');
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Computacion','Equipos de computo y tecnologia'),(2,'Perifericos','Mouse, teclados, auriculares y similares'),(3,'Componentes','Partes internas de PC'),(4,'Accesorios','Cables, hubs y accesorios varios');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `id_almacen` int NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`),
  KEY `id_almacen` (`id_almacen`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `detalle_venta_ibfk_3` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (1,1,1,1,1500.00,1),(2,1,2,1,25.00,1),(3,2,4,1,900.00,1),(4,2,3,1,225.00,1),(5,2,5,1,350.00,1),(6,3,6,1,850.00,2),(7,3,9,3,75.00,2),(8,3,10,1,125.00,2),(9,4,4,1,900.00,3),(10,5,3,1,225.00,1),(11,5,5,1,350.00,1),(12,6,1,1,1500.00,2),(13,6,8,2,525.00,2),(14,7,2,1,25.00,3),(15,7,3,1,225.00,3),(16,8,7,2,750.00,1),(17,8,9,1,75.00,1),(18,8,10,1,125.00,1);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre_empleado` varchar(60) NOT NULL,
  `correo_empleado` varchar(60) NOT NULL,
  `id_rol` int NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `correo_empleado` (`correo_empleado`),
  KEY `fk_empleado_rol` (`id_rol`),
  CONSTRAINT `fk_empleado_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Carlos Rodriguez','carlos.rodriguez@lagali.com',1,1),(2,'Maria Garcia','maria.garcia@lagali.com',2,1),(3,'Luis Martinez','luis.martinez@lagali.com',2,1),(4,'Ana Lopez','ana.lopez@lagali.com',2,1),(5,'Pedro Sanchez','pedro.sanchez@lagali.com',2,1);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado_auth`
--

DROP TABLE IF EXISTS `empleado_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado_auth` (
  `id_empleado` int NOT NULL,
  `password_empleado` varchar(255) NOT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `intentos_fallidos` int DEFAULT '0',
  `bloqueado_hasta` datetime DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `empleado_auth_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado_auth`
--

LOCK TABLES `empleado_auth` WRITE;
/*!40000 ALTER TABLE `empleado_auth` DISABLE KEYS */;
INSERT INTO `empleado_auth` VALUES (1,'968ab6060151798185c8284d1b88f56f299f45ef3c2852c6704a20268c198f84',NULL,0,NULL),(2,'c146712f0db1987063646f5d1a6648983586ec586d5b94a6043c180414c8448f',NULL,0,NULL),(3,'c146712f0db1987063646f5d1a6648983586ec586d5b94a6043c180414c8448f',NULL,0,NULL),(4,'4b70803972fdc84cbf3ae03953de0322e8eaa25a1e36b25b2a23bbd0811d2c9a',NULL,0,NULL),(5,'4b70803972fdc84cbf3ae03953de0322e8eaa25a1e36b25b2a23bbd0811d2c9a',NULL,0,NULL);
/*!40000 ALTER TABLE `empleado_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_almacen` int NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `ubicacion_interna` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id_inventario`,`id_almacen`),
  UNIQUE KEY `idx_producto_almacen` (`id_producto`,`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY LIST (`id_almacen`)
(PARTITION p_almacen_1 VALUES IN (1) ENGINE = InnoDB,
 PARTITION p_almacen_2 VALUES IN (2) ENGINE = InnoDB,
 PARTITION p_almacen_3 VALUES IN (3) ENGINE = InnoDB,
 PARTITION p_almacen_general VALUES IN (4,5,6,7,8,9,10) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,1,15,'A-01-01'),(4,2,1,50,'A-01-02'),(7,3,1,20,'A-01-03'),(10,4,1,10,'A-02-01'),(13,5,1,40,'A-02-02'),(16,6,1,18,'A-02-03'),(19,7,1,25,'A-03-01'),(22,8,1,35,'A-03-02'),(25,9,1,100,'A-03-03'),(28,10,1,30,'A-04-01'),(2,1,2,8,'B-02-01'),(5,2,2,30,'B-02-02'),(8,3,2,12,'B-02-03'),(11,4,2,6,'B-03-01'),(14,5,2,25,'B-03-02'),(17,6,2,10,'B-03-03'),(20,7,2,15,'B-04-01'),(23,8,2,20,'B-04-02'),(26,9,2,60,'B-04-03'),(29,10,2,18,'B-05-01'),(3,1,3,5,'C-01-02'),(6,2,3,25,'C-01-03'),(9,3,3,8,'C-02-01'),(12,4,3,4,'C-02-02'),(15,5,3,20,'C-02-03'),(18,6,3,7,'C-03-01'),(21,7,3,10,'C-03-02'),(24,8,3,15,'C-03-03'),(27,9,3,50,'D-01-01'),(30,10,3,12,'D-01-02');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `codigo_serie` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(80) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_categoria` int NOT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo_serie` (`codigo_serie`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'PL-001','Laptop HP Pavilion','Laptop 15.6\" Intel Core i5',1500.00,1),(2,'PM-002','Mouse Inalambrico','Mouse wireless USB recargable',25.00,2),(3,'PTM-003','Teclado Mecanico','Teclado gaming RGB switches rojos',225.00,2),(4,'PMO-004','Monitor 24\"','Monitor Full HD 1920x1080 60Hz',900.00,1),(5,'PA-005','Auriculares USB','Auriculares con microfono USB',350.00,2),(6,'PW-006','Webcam HD','Camara web 1080p con microfono',850.00,2),(7,'PD-007','Disco SSD 500GB','SSD interno SATA III 2.5\"',750.00,3),(8,'PMR-008','Memoria RAM 8GB','RAM DDR4 3200MHz Kingston',525.00,3),(9,'PMH-009','Cable HDMI 2m','Cable HDMI alta velocidad 4K',75.00,4),(10,'PAH-010','Hub USB 4 puertos','Hub USB 3.0 alimentado',125.00,4);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion_rol` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador','Usuario con acceso total al sistema'),(2,'Operador','Usuario puede realizar ventas');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencia`
--

DROP TABLE IF EXISTS `transferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencia` (
  `id_transferencia` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_almacen_origen` int NOT NULL,
  `id_almacen_destino` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_solicitud` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_completada` datetime DEFAULT NULL,
  `estado` enum('solicitada','aprobada','rechazada','completada','cancelada') DEFAULT 'solicitada',
  `id_empleado_solicita` int NOT NULL,
  `id_empleado_aprueba` int DEFAULT NULL,
  PRIMARY KEY (`id_transferencia`),
  KEY `id_producto` (`id_producto`),
  KEY `id_almacen_origen` (`id_almacen_origen`),
  KEY `id_almacen_destino` (`id_almacen_destino`),
  KEY `id_empleado_solicita` (`id_empleado_solicita`),
  KEY `id_empleado_aprueba` (`id_empleado_aprueba`),
  CONSTRAINT `transferencia_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `transferencia_ibfk_2` FOREIGN KEY (`id_almacen_origen`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `transferencia_ibfk_3` FOREIGN KEY (`id_almacen_destino`) REFERENCES `almacen` (`id_almacen`),
  CONSTRAINT `transferencia_ibfk_4` FOREIGN KEY (`id_empleado_solicita`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `transferencia_ibfk_5` FOREIGN KEY (`id_empleado_aprueba`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `transferencia_chk_1` CHECK ((`cantidad` > 0)),
  CONSTRAINT `transferencia_chk_2` CHECK ((`id_almacen_origen` <> `id_almacen_destino`))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencia`
--

LOCK TABLES `transferencia` WRITE;
/*!40000 ALTER TABLE `transferencia` DISABLE KEYS */;
INSERT INTO `transferencia` VALUES (1,1,1,2,5,'2026-03-01 08:00:00','2026-03-01 09:30:00','completada',4,1),(2,2,2,1,10,'2026-03-02 10:00:00','2026-03-02 11:15:00','completada',5,1),(3,3,1,3,8,'2026-03-03 14:00:00',NULL,'solicitada',4,NULL),(4,4,3,2,3,'2026-03-04 09:00:00','2026-03-04 10:00:00','completada',5,1),(5,5,1,2,15,'2026-03-05 11:00:00',NULL,'aprobada',4,1),(6,6,2,3,5,'2026-03-06 15:00:00',NULL,'rechazada',5,1),(7,7,1,3,10,'2026-03-07 08:30:00',NULL,'solicitada',4,NULL),(8,8,2,1,12,'2026-03-08 12:00:00',NULL,'cancelada',5,1);
/*!40000 ALTER TABLE `transferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL,
  `id_empleado` int NOT NULL,
  `id_almacen` int NOT NULL,
  `estado` enum('pendiente','completada','cancelada') DEFAULT 'pendiente',
  PRIMARY KEY (`id_venta`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_almacen` (`id_almacen`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (1,'2026-03-01 10:30:00',1525.00,2,1,'completada'),(2,'2026-03-02 14:15:00',1475.00,3,1,'completada'),(3,'2026-03-03 09:45:00',1200.00,2,2,'completada'),(4,'2026-03-04 16:20:00',900.00,3,3,'completada'),(5,'2026-03-05 11:00:00',575.00,2,1,'completada'),(6,'2026-03-06 13:30:00',2550.00,3,2,'completada'),(7,'2026-03-07 15:45:00',250.00,2,3,'completada'),(8,'2026-03-08 10:15:00',1700.00,3,1,'completada');
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_productos_por_categoria`
--

DROP TABLE IF EXISTS `vw_productos_por_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_por_categoria` AS SELECT 
 1 AS `id_categoria`,
 1 AS `nombre_categoria`,
 1 AS `id_producto`,
 1 AS `codigo_serie`,
 1 AS `nombre_producto`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_por_ubicacion`
--

DROP TABLE IF EXISTS `vw_productos_por_ubicacion`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_por_ubicacion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_por_ubicacion` AS SELECT 
 1 AS `id_almacen`,
 1 AS `nombre_almacen`,
 1 AS `ubicacion_almacen`,
 1 AS `ubicacion_interna`,
 1 AS `id_producto`,
 1 AS `codigo_serie`,
 1 AS `nombre_producto`,
 1 AS `stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_reporte_inventario_general`
--

DROP TABLE IF EXISTS `vw_reporte_inventario_general`;
/*!50001 DROP VIEW IF EXISTS `vw_reporte_inventario_general`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reporte_inventario_general` AS SELECT 
 1 AS `id_producto`,
 1 AS `codigo_serie`,
 1 AS `nombre_producto`,
 1 AS `stock_actual`,
 1 AS `precio_unitario`,
 1 AS `valor_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_reporte_ventas`
--

DROP TABLE IF EXISTS `vw_reporte_ventas`;
/*!50001 DROP VIEW IF EXISTS `vw_reporte_ventas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reporte_ventas` AS SELECT 
 1 AS `id_venta`,
 1 AS `fecha`,
 1 AS `id_producto`,
 1 AS `codigo_serie`,
 1 AS `nombre_producto`,
 1 AS `cantidad`,
 1 AS `precio_unitario`,
 1 AS `valor_total`,
 1 AS `nombre_empleado`,
 1 AS `nombre_almacen`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_resumen_transferencias`
--

DROP TABLE IF EXISTS `vw_resumen_transferencias`;
/*!50001 DROP VIEW IF EXISTS `vw_resumen_transferencias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_resumen_transferencias` AS SELECT 
 1 AS `id_transferencia`,
 1 AS `nombre_producto`,
 1 AS `almacen_origen`,
 1 AS `almacen_destino`,
 1 AS `cantidad`,
 1 AS `fecha_solicitud`,
 1 AS `estado`,
 1 AS `empleado_solicita`,
 1 AS `empleado_aprueba`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_productos_por_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_por_categoria` AS select `c`.`id_categoria` AS `id_categoria`,`c`.`nombre` AS `nombre_categoria`,`p`.`id_producto` AS `id_producto`,`p`.`codigo_serie` AS `codigo_serie`,`p`.`nombre` AS `nombre_producto`,`p`.`precio` AS `precio` from (`categoria` `c` join `producto` `p` on((`c`.`id_categoria` = `p`.`id_categoria`))) order by `c`.`nombre`,`p`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_por_ubicacion`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_por_ubicacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_por_ubicacion` AS select `a`.`id_almacen` AS `id_almacen`,`a`.`nombre_almacen` AS `nombre_almacen`,`a`.`ubicacion_almacen` AS `ubicacion_almacen`,`i`.`ubicacion_interna` AS `ubicacion_interna`,`p`.`id_producto` AS `id_producto`,`p`.`codigo_serie` AS `codigo_serie`,`p`.`nombre` AS `nombre_producto`,`i`.`stock` AS `stock` from ((`inventario` `i` join `producto` `p` on((`i`.`id_producto` = `p`.`id_producto`))) join `almacen` `a` on((`i`.`id_almacen` = `a`.`id_almacen`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_reporte_inventario_general`
--

/*!50001 DROP VIEW IF EXISTS `vw_reporte_inventario_general`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_reporte_inventario_general` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo_serie` AS `codigo_serie`,`p`.`nombre` AS `nombre_producto`,coalesce(sum(`i`.`stock`),0) AS `stock_actual`,`p`.`precio` AS `precio_unitario`,(coalesce(sum(`i`.`stock`),0) * `p`.`precio`) AS `valor_total` from (`producto` `p` left join `inventario` `i` on((`p`.`id_producto` = `i`.`id_producto`))) group by `p`.`id_producto`,`p`.`codigo_serie`,`p`.`nombre`,`p`.`precio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_reporte_ventas`
--

/*!50001 DROP VIEW IF EXISTS `vw_reporte_ventas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_reporte_ventas` AS select `v`.`id_venta` AS `id_venta`,`v`.`fecha` AS `fecha`,`p`.`id_producto` AS `id_producto`,`p`.`codigo_serie` AS `codigo_serie`,`p`.`nombre` AS `nombre_producto`,`dv`.`cantidad` AS `cantidad`,`dv`.`precio_unitario` AS `precio_unitario`,(`dv`.`cantidad` * `dv`.`precio_unitario`) AS `valor_total`,`e`.`nombre_empleado` AS `nombre_empleado`,`a`.`nombre_almacen` AS `nombre_almacen` from ((((`venta` `v` join `detalle_venta` `dv` on((`v`.`id_venta` = `dv`.`id_venta`))) join `producto` `p` on((`dv`.`id_producto` = `p`.`id_producto`))) join `empleado` `e` on((`v`.`id_empleado` = `e`.`id_empleado`))) join `almacen` `a` on((`v`.`id_almacen` = `a`.`id_almacen`))) where (`v`.`estado` = 'completada') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_resumen_transferencias`
--

/*!50001 DROP VIEW IF EXISTS `vw_resumen_transferencias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_resumen_transferencias` AS select `t`.`id_transferencia` AS `id_transferencia`,`p`.`nombre` AS `nombre_producto`,`ao`.`nombre_almacen` AS `almacen_origen`,`ad`.`nombre_almacen` AS `almacen_destino`,`t`.`cantidad` AS `cantidad`,`t`.`fecha_solicitud` AS `fecha_solicitud`,`t`.`estado` AS `estado`,`es`.`nombre_empleado` AS `empleado_solicita`,`ea`.`nombre_empleado` AS `empleado_aprueba` from (((((`transferencia` `t` join `producto` `p` on((`t`.`id_producto` = `p`.`id_producto`))) join `almacen` `ao` on((`t`.`id_almacen_origen` = `ao`.`id_almacen`))) join `almacen` `ad` on((`t`.`id_almacen_destino` = `ad`.`id_almacen`))) join `empleado` `es` on((`t`.`id_empleado_solicita` = `es`.`id_empleado`))) left join `empleado` `ea` on((`t`.`id_empleado_aprueba` = `ea`.`id_empleado`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-22 20:46:52
