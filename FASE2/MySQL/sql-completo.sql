
-- SISTEMA DE INVENTARIO - FASE 2 BD

DROP DATABASE IF EXISTS sistema_inventario;
CREATE DATABASE sistema_inventario;
USE sistema_inventario;


-- TABLAS


-- TABLA: ROL
DROP TABLE IF EXISTS rol;
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion_rol VARCHAR(100)
);

INSERT INTO rol (nombre_rol, descripcion_rol) VALUES
('Administrador', 'Usuario con acceso total al sistema'),
('Operador', 'Usuario puede realizar ventas');

-- TABLA: ALMACEN
DROP TABLE IF EXISTS almacen;
CREATE TABLE almacen (
    id_almacen INT AUTO_INCREMENT PRIMARY KEY,
    nombre_almacen VARCHAR(50) NOT NULL,
    ubicacion_almacen VARCHAR(80) NOT NULL
);

INSERT INTO almacen (nombre_almacen, ubicacion_almacen) VALUES
('Almacen Central', 'Av. Principal 123, Ciudad Central'),
('Almacen Norte', 'Zona Industrial Norte, Calle 5'),
('Almacen Sur', 'Avenida del Sur 456, Zona Comercial');

-- TABLA: CATEGORIA
DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100)
);

INSERT INTO categoria (nombre, descripcion) VALUES
('Computacion', 'Equipos de computo y tecnologia'),
('Perifericos', 'Mouse, teclados, auriculares y similares'),
('Componentes', 'Partes internas de PC'),
('Accesorios', 'Cables, hubs y accesorios varios');

-- TABLA: PRODUCTO
DROP TABLE IF EXISTS producto;
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_serie VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(80),
    precio DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    UNIQUE KEY codigo_serie (codigo_serie),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

INSERT INTO producto (codigo_serie, nombre, descripcion, precio, id_categoria) VALUES
('PL-001', 'Laptop HP Pavilion', 'Laptop 15.6" Intel Core i5', 1500, 1),
('PM-002', 'Mouse Inalambrico', 'Mouse wireless USB recargable', 25, 2),
('PTM-003', 'Teclado Mecanico', 'Teclado gaming RGB switches rojos', 225, 2),
('PMO-004', 'Monitor 24"', 'Monitor Full HD 1920x1080 60Hz', 900, 1),
('PA-005', 'Auriculares USB', 'Auriculares con microfono USB', 350, 2),
('PW-006', 'Webcam HD', 'Camara web 1080p con microfono', 850, 2),
('PD-007', 'Disco SSD 500GB', 'SSD interno SATA III 2.5"', 750, 3),
('PMR-008', 'Memoria RAM 8GB', 'RAM DDR4 3200MHz Kingston', 525, 3),
('PMH-009', 'Cable HDMI 2m', 'Cable HDMI alta velocidad 4K', 75, 4),
('PAH-010', 'Hub USB 4 puertos', 'Hub USB 3.0 alimentado', 125, 4);

-- TABLA: INVENTARIO
DROP TABLE IF EXISTS inventario;
CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_almacen INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    ubicacion_interna VARCHAR(80),
    UNIQUE KEY idx_producto_almacen (id_producto, id_almacen),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

INSERT INTO inventario (id_producto, id_almacen, stock, ubicacion_interna) VALUES
(1, 1, 15, 'A-01-01'), (1, 2, 8, 'B-02-01'), (1, 3, 5, 'C-01-02'),
(2, 1, 50, 'A-01-02'), (2, 2, 30, 'B-02-02'), (2, 3, 25, 'C-01-03'),
(3, 1, 20, 'A-01-03'), (3, 2, 12, 'B-02-03'), (3, 3, 8, 'C-02-01'),
(4, 1, 10, 'A-02-01'), (4, 2, 6, 'B-03-01'), (4, 3, 4, 'C-02-02'),
(5, 1, 40, 'A-02-02'), (5, 2, 25, 'B-03-02'), (5, 3, 20, 'C-02-03'),
(6, 1, 18, 'A-02-03'), (6, 2, 10, 'B-03-03'), (6, 3, 7, 'C-03-01'),
(7, 1, 25, 'A-03-01'), (7, 2, 15, 'B-04-01'), (7, 3, 10, 'C-03-02'),
(8, 1, 35, 'A-03-02'), (8, 2, 20, 'B-04-02'), (8, 3, 15, 'C-03-03'),
(9, 1, 100, 'A-03-03'), (9, 2, 60, 'B-04-03'), (9, 3, 50, 'D-01-01'),
(10, 1, 30, 'A-04-01'), (10, 2, 18, 'B-05-01'), (10, 3, 12, 'D-01-02');


DROP TABLE IF EXISTS empleado;
CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empleado VARCHAR(60) NOT NULL,
    correo_empleado VARCHAR(60) NOT NULL,
    id_rol INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_empleado_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    UNIQUE KEY correo_empleado (correo_empleado)
);

INSERT INTO empleado (nombre_empleado, correo_empleado, id_rol, activo) VALUES
('Carlos Rodriguez', 'carlos.rodriguez@lagali.com', 1, TRUE),
('Maria Garcia', 'maria.garcia@lagali.com', 2, TRUE),
('Luis Martinez', 'luis.martinez@lagali.com', 2, TRUE),
('Ana Lopez', 'ana.lopez@lagali.com', 2, TRUE),
('Pedro Sanchez', 'pedro.sanchez@lagali.com', 2, TRUE);


-- TABLA: VENTA 
DROP TABLE IF EXISTS venta;
CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    id_empleado INT NOT NULL,
    id_almacen INT NOT NULL,
    estado ENUM('pendiente', 'completada', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

INSERT INTO venta (fecha, total, id_empleado, id_almacen, estado) VALUES
('2026-03-01 10:30:00', 1525.00, 2, 1, 'completada'),
('2026-03-02 14:15:00', 1475.00, 3, 1, 'completada'),
('2026-03-03 09:45:00', 1200.00, 2, 2, 'completada'),
('2026-03-04 16:20:00', 900.00, 3, 3, 'completada'),
('2026-03-05 11:00:00', 575.00, 2, 1, 'completada'),
('2026-03-06 13:30:00', 2550.00, 3, 2, 'completada'),
('2026-03-07 15:45:00', 250.00, 2, 3, 'completada'),
('2026-03-08 10:15:00', 1700.00, 3, 1, 'completada');

-- TABLA: DETALLE_VENTA 
DROP TABLE IF EXISTS detalle_venta;
CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_almacen INT NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, id_almacen) VALUES
(1, 1, 1, 1500, 1),
(1, 2, 1, 25, 1),
(2, 4, 1, 900, 1),
(2, 3, 1, 225, 1),
(2, 5, 1, 350, 1),
(3, 6, 1, 850, 2),
(3, 9, 3, 75, 2),
(3, 10, 1, 125, 2),
(4, 4, 1, 900, 3),
(5, 3, 1, 225, 1),
(5, 5, 1, 350, 1),
(6, 1, 1, 1500, 2),
(6, 8, 2, 525, 2),
(7, 2, 1, 25, 3),
(7, 3, 1, 225, 3),
(8, 7, 2, 750, 1),
(8, 9, 1, 75, 1),
(8, 10, 1, 125, 1);

-- TABLA: TRANSFERENCIA
DROP TABLE IF EXISTS transferencia;
CREATE TABLE transferencia (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_almacen_origen INT NOT NULL,
    id_almacen_destino INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_completada DATETIME NULL,
    estado ENUM('solicitada', 'aprobada', 'rechazada', 'completada', 'cancelada') DEFAULT 'solicitada',
    id_empleado_solicita INT NOT NULL,
    id_empleado_aprueba INT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_almacen_origen) REFERENCES almacen(id_almacen),
    FOREIGN KEY (id_almacen_destino) REFERENCES almacen(id_almacen),
    FOREIGN KEY (id_empleado_solicita) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_empleado_aprueba) REFERENCES empleado(id_empleado),
    CHECK (cantidad > 0),
    CHECK (id_almacen_origen != id_almacen_destino)
);

INSERT INTO transferencia (id_producto, id_almacen_origen, id_almacen_destino, cantidad, fecha_solicitud, fecha_completada, estado, id_empleado_solicita, id_empleado_aprueba) VALUES
(1, 1, 2, 5, '2026-03-01 08:00:00', '2026-03-01 09:30:00', 'completada', 4, 1),
(2, 2, 1, 10, '2026-03-02 10:00:00', '2026-03-02 11:15:00', 'completada', 5, 1),
(3, 1, 3, 8, '2026-03-03 14:00:00', NULL, 'solicitada', 4, NULL),
(4, 3, 2, 3, '2026-03-04 09:00:00', '2026-03-04 10:00:00', 'completada', 5, 1),
(5, 1, 2, 15, '2026-03-05 11:00:00', NULL, 'aprobada', 4, 1),
(6, 2, 3, 5, '2026-03-06 15:00:00', NULL, 'rechazada', 5, 1),
(7, 1, 3, 10, '2026-03-07 08:30:00', NULL, 'solicitada', 4, NULL),
(8, 2, 1, 12, '2026-03-08 12:00:00', NULL, 'cancelada', 5, 1);


-- VISTAS

-- Vista: Reporte de Inventario General
DROP VIEW IF EXISTS vw_reporte_inventario_general;
CREATE VIEW vw_reporte_inventario_general AS
SELECT 
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    COALESCE(SUM(i.stock), 0) AS stock_actual,
    p.precio AS precio_unitario,
    (COALESCE(SUM(i.stock), 0) * p.precio) AS valor_total
FROM producto p
LEFT JOIN inventario i ON p.id_producto = i.id_producto
GROUP BY p.id_producto, p.codigo_serie, p.nombre, p.precio;

-- Vista: Productos por Ubicacion
DROP VIEW IF EXISTS vw_productos_por_ubicacion;
CREATE VIEW vw_productos_por_ubicacion AS
SELECT 
    a.id_almacen,
    a.nombre_almacen,
    a.ubicacion_almacen,
    i.ubicacion_interna,
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    i.stock
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto
JOIN almacen a ON i.id_almacen = a.id_almacen;

-- Vista: Reporte de Ventas
DROP VIEW IF EXISTS vw_reporte_ventas;
CREATE VIEW vw_reporte_ventas AS
SELECT 
    v.id_venta,
    v.fecha,
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    dv.cantidad,
    dv.precio_unitario,
    (dv.cantidad * dv.precio_unitario) AS valor_total,
    e.nombre_empleado,
    a.nombre_almacen
FROM venta v
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto p ON dv.id_producto = p.id_producto
JOIN empleado e ON v.id_empleado = e.id_empleado
JOIN almacen a ON v.id_almacen = a.id_almacen
WHERE v.estado = 'completada';

-- Vista: Productos por Categoria
DROP VIEW IF EXISTS vw_productos_por_categoria;
CREATE VIEW vw_productos_por_categoria AS
SELECT 
    c.id_categoria,
    c.nombre AS nombre_categoria,
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    p.precio
FROM categoria c
JOIN producto p ON c.id_categoria = p.id_categoria
ORDER BY c.nombre, p.nombre;

-- Vista: Resumen de Transferencias
DROP VIEW IF EXISTS vw_resumen_transferencias;
CREATE VIEW vw_resumen_transferencias AS
SELECT 
    t.id_transferencia,
    p.nombre AS nombre_producto,
    ao.nombre_almacen AS almacen_origen,
    ad.nombre_almacen AS almacen_destino,
    t.cantidad,
    t.fecha_solicitud,
    t.estado,
    es.nombre_empleado AS empleado_solicita,
    ea.nombre_empleado AS empleado_aprueba
FROM transferencia t
JOIN producto p ON t.id_producto = p.id_producto
JOIN almacen ao ON t.id_almacen_origen = ao.id_almacen
JOIN almacen ad ON t.id_almacen_destino = ad.id_almacen
JOIN empleado es ON t.id_empleado_solicita = es.id_empleado
LEFT JOIN empleado ea ON t.id_empleado_aprueba = ea.id_empleado;


-- PARTE 3: PROCEDIMIENTOS ALMACENADOS


-- Productos por rango de precio
DROP PROCEDURE IF EXISTS sp_productos_por_rango_precio;
DELIMITER $$
CREATE PROCEDURE sp_productos_por_rango_precio(IN precio_min DECIMAL(10,2), IN precio_max DECIMAL(10,2))
BEGIN
    SELECT id_producto, codigo_serie, nombre, descripcion, precio
    FROM producto
    WHERE precio BETWEEN precio_min AND precio_max
    ORDER BY precio;
END $$
DELIMITER ;

-- SP: Stock minimo
DROP PROCEDURE IF EXISTS sp_stock_minimo;
DELIMITER $$
CREATE PROCEDURE sp_stock_minimo(IN limite INT)
BEGIN
    SELECT 
        p.id_producto,
        p.codigo_serie,
        p.nombre,
        i.id_almacen,
        a.nombre_almacen,
        i.stock
    FROM inventario i
    JOIN producto p ON i.id_producto = p.id_producto
    JOIN almacen a ON i.id_almacen = a.id_almacen
    WHERE i.stock <= limite
    ORDER BY i.stock ASC;
END $$
DELIMITER ;

-- SP: Reporte de ventas por periodo
DROP PROCEDURE IF EXISTS sp_reporte_ventas_periodo;
DELIMITER $$
CREATE PROCEDURE sp_reporte_ventas_periodo(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT 
        v.id_venta,
        v.fecha,
        v.total,
        e.nombre_empleado,
        a.nombre_almacen,
        v.estado
    FROM venta v
    JOIN empleado e ON v.id_empleado = e.id_empleado
    JOIN almacen a ON v.id_almacen = a.id_almacen
    WHERE DATE(v.fecha) BETWEEN fecha_inicio AND fecha_fin
    ORDER BY v.fecha DESC;
END $$
DELIMITER ;

-- SP: Productos mas vendidos
DROP PROCEDURE IF EXISTS sp_mas_vendidos;
DELIMITER $$
CREATE PROCEDURE sp_mas_vendidos(IN limite INT)
BEGIN
    SELECT 
        p.id_producto,
        p.codigo_serie,
        p.nombre,
        SUM(dv.cantidad) AS cantidad_vendida,
        SUM(dv.cantidad * dv.precio_unitario) AS total_vendido
    FROM detalle_venta dv
    JOIN producto p ON dv.id_producto = p.id_producto
    JOIN venta v ON dv.id_venta = v.id_venta
    WHERE v.estado = 'completada'
    GROUP BY p.id_producto, p.codigo_serie, p.nombre
    ORDER BY cantidad_vendida DESC
    LIMIT limite;
END $$
DELIMITER ;


-- PARTE 4: TRIGGERS


-- Trigger: Actualizar stock al registrar venta
DROP TRIGGER IF EXISTS trigger_actualizar_stock_venta;
DELIMITER $$
CREATE TRIGGER trigger_actualizar_stock_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE inventario 
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto AND id_almacen = NEW.id_almacen;
END $$
DELIMITER ;


-- Trigger: Validar stock disponible antes de venta
DROP TRIGGER IF EXISTS trigger_validar_stock;
DELIMITER $$
CREATE TRIGGER trigger_validar_stock
BEFORE INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT stock INTO stock_actual 
    FROM inventario 
    WHERE id_producto = NEW.id_producto AND id_almacen = NEW.id_almacen;
    
    IF stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Stock insuficiente para esta venta';
    END IF;
END $$
DELIMITER ;


-- Trigger: Actualizar inventario al completar transferencia
DROP TRIGGER IF EXISTS trigger_inventario_transferencia;
DELIMITER $$
CREATE TRIGGER trigger_inventario_transferencia
AFTER UPDATE ON transferencia
FOR EACH ROW
BEGIN
    IF NEW.estado = 'completada' AND OLD.estado != 'completada' THEN
        UPDATE inventario 
        SET stock = stock - NEW.cantidad
        WHERE id_producto = NEW.id_producto AND id_almacen = NEW.id_almacen_origen;
        
        UPDATE inventario 
        SET stock = stock + NEW.cantidad
        WHERE id_producto = NEW.id_producto AND id_almacen = NEW.id_almacen_destino;
    END IF;
END $$
DELIMITER ;


-- PARTE 5: ROLES Y PERMISOS


-- Crear roles
DROP ROLE IF EXISTS sys_admin;
DROP ROLE IF EXISTS sys_operador;

CREATE ROLE sys_admin;
CREATE ROLE sys_operador;

-- Permisos para Administrador (todos los permisos)
GRANT ALL ON sistema_inventario.* TO sys_admin;

-- Permisos para Operador (ventas y consultas)
GRANT SELECT ON sistema_inventario.* TO sys_operador;
GRANT INSERT ON sistema_inventario.venta TO sys_operador;
GRANT INSERT ON sistema_inventario.detalle_venta TO sys_operador;
GRANT UPDATE ON sistema_inventario.inventario TO sys_operador;
-- Ejecuciones para usar procedimientos
GRANT EXECUTE ON PROCEDURE sp_productos_por_rango_precio TO sys_operador;
GRANT EXECUTE ON PROCEDURE sp_mas_vendidos TO sys_operador;

-- Crear usuarios y asignar roles
DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'operador'@'localhost';

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'operador'@'localhost' IDENTIFIED BY 'operador123';

SET DEFAULT ROLE sys_admin TO 'admin'@'localhost';
SET DEFAULT ROLE sys_operador TO 'operador'@'localhost';


-- Particiones
-- Horizontal
-- inventario por id_almacen - Divide la tabla inventario en particiones separadas por almacen. - Cada almacen tiene su propia particion fisica.

ALTER TABLE inventario
PARTITION BY LIST (id_almacen) (
    PARTITION p_almacen_1 VALUES IN (1),
    PARTITION p_almacen_2 VALUES IN (2),
    PARTITION p_almacen_3 VALUES IN (3),
    PARTITION p_almacen_general VALUES IN (4, 5, 6, 7, 8, 9, 10)
);


-- Vertical
-- Empleado - Se separan datos de autenticacion de datos de operaciones por empleado. - Mejora rendimiento y seguridad

DROP TABLE IF EXISTS empleado_auth;
CREATE TABLE empleado_auth (
    id_empleado INT PRIMARY KEY,
    password_empleado VARCHAR(255) NOT NULL,
    ultimo_login DATETIME NULL,
    intentos_fallidos INT DEFAULT 0,
    bloqueado_hasta DATETIME NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Trigger: Hash automático de contraseña al insertar en empleado_auth
DROP TRIGGER IF EXISTS trg_empleado_auth_hash;
DELIMITER $$
CREATE TRIGGER trg_empleado_auth_hash
BEFORE INSERT ON empleado_auth
FOR EACH ROW
BEGIN
    SET NEW.password_empleado = SHA2(CONCAT(NEW.password_empleado, 'S1st3m4_L4g4l1'), 256);
END $$
DELIMITER ;


-- Datos de autenticacion (SHA2-256 con salt para hashes distintos)
-- El trigger maneja el hash automáticamente al insertar
INSERT INTO empleado_auth (id_empleado, password_empleado) VALUES
(1, 'admin123'),
(2, 'vendedor123'),
(3, 'vendedor123'),
(4, 'operador123'),
(5, 'operador123');
