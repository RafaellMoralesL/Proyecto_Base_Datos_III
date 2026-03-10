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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;
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
  PRIMARY KEY (`id_detalle`),
  KEY `idx_detalle_venta_idventa` (`id_venta`),
  KEY `idx_detalle_venta_idproducto` (`id_producto`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
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
  `password_empleado` varchar(25) DEFAULT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `correo_empleado` (`correo_empleado`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
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
  `stock` int NOT NULL,
  `ubicacion_interna` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id_inventario`),
  UNIQUE KEY `idx_producto_almacen` (`id_producto`,`id_almacen`),
  KEY `id_almacen` (`id_almacen`),
  KEY `idx_inventario_producto` (`id_producto`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`id_almacen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
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
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo_serie` (`codigo_serie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `id_empleado` int NOT NULL,
  `estado` enum('pendiente','completada','cancelada') DEFAULT 'pendiente',
  PRIMARY KEY (`id_venta`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Temporary view structure for view `vw_reporte_ventas_simuladas`
--

DROP TABLE IF EXISTS `vw_reporte_ventas_simuladas`;
/*!50001 DROP VIEW IF EXISTS `vw_reporte_ventas_simuladas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reporte_ventas_simuladas` AS SELECT 
 1 AS `id_venta`,
 1 AS `fecha`,
 1 AS `id_producto`,
 1 AS `codigo_serie`,
 1 AS `nombre_producto`,
 1 AS `cantidad`,
 1 AS `precio_unitario`,
 1 AS `valor_total`,
 1 AS `nombre_empleado`*/;
SET character_set_client = @saved_cs_client;

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
-- Final view structure for view `vw_reporte_ventas_simuladas`
--

/*!50001 DROP VIEW IF EXISTS `vw_reporte_ventas_simuladas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_reporte_ventas_simuladas` AS select `v`.`id_venta` AS `id_venta`,`v`.`fecha` AS `fecha`,`p`.`id_producto` AS `id_producto`,`p`.`codigo_serie` AS `codigo_serie`,`p`.`nombre` AS `nombre_producto`,count(`dv`.`id_detalle`) AS `cantidad`,`p`.`precio` AS `precio_unitario`,(count(`dv`.`id_detalle`) * `p`.`precio`) AS `valor_total`,`e`.`nombre_empleado` AS `nombre_empleado` from (((`venta` `v` join `detalle_venta` `dv` on((`v`.`id_venta` = `dv`.`id_venta`))) join `producto` `p` on((`dv`.`id_producto` = `p`.`id_producto`))) join `empleado` `e` on((`v`.`id_empleado` = `e`.`id_empleado`))) where (`v`.`estado` = 'completada') group by `v`.`id_venta`,`v`.`fecha`,`p`.`id_producto`,`p`.`codigo_serie`,`p`.`nombre`,`p`.`precio`,`e`.`nombre_empleado` */;
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

-- Dump completed on 2026-03-09 20:31:33
