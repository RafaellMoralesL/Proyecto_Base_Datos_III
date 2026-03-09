USE sistema_inventario;

DROP PROCEDURE IF EXISTS sp_registrar_venta;
DROP VIEW IF EXISTS vw_reporte_inventario_general;
DROP VIEW IF EXISTS vw_productos_por_ubicacion;
DROP VIEW IF EXISTS vw_reporte_ventas_simuladas;

DELIMITER $$

CREATE PROCEDURE sp_registrar_venta(
    IN p_id_empleado INT,
    IN p_id_producto INT,
    IN p_id_almacen INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_precio DECIMAL(10,2) DEFAULT NULL;
    DECLARE v_stock INT DEFAULT NULL;
    DECLARE v_total DECIMAL(10,2) DEFAULT NULL;
    DECLARE v_id_venta INT DEFAULT NULL;
    DECLARE v_contador INT DEFAULT 1;
    DECLARE v_existe_empleado INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe ser mayor que cero';
    END IF;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_existe_empleado
    FROM empleado
    WHERE id_empleado = p_id_empleado;

    IF v_existe_empleado = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El empleado no existe';
    END IF;

    SELECT precio
    INTO v_precio
    FROM producto
    WHERE id_producto = p_id_producto
    LIMIT 1;

    IF v_precio IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe';
    END IF;

    SELECT stock
    INTO v_stock
    FROM inventario
    WHERE id_producto = p_id_producto
      AND id_almacen = p_id_almacen
    LIMIT 1
    FOR UPDATE;

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existe inventario para ese producto en ese almacen';
    END IF;

    IF v_stock < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;

    SET v_total = v_precio * p_cantidad;

    INSERT INTO venta (fecha, total, id_empleado)
    VALUES (NOW(), v_total, p_id_empleado);

    SET v_id_venta = LAST_INSERT_ID();

    WHILE v_contador <= p_cantidad DO
        INSERT INTO detalle_venta (id_venta, id_producto)
        VALUES (v_id_venta, p_id_producto);

        SET v_contador = v_contador + 1;
    END WHILE;

    UPDATE inventario
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto
      AND id_almacen = p_id_almacen;

    COMMIT;
END $$

DELIMITER ;



CREATE VIEW vw_reporte_inventario_general AS
SELECT
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    COALESCE(SUM(i.stock), 0) AS stock_actual,
    p.precio AS precio_unitario,
    COALESCE(SUM(i.stock), 0) * p.precio AS valor_total
FROM producto p
LEFT JOIN inventario i
    ON p.id_producto = i.id_producto
GROUP BY
    p.id_producto,
    p.codigo_serie,
    p.nombre,
    p.precio;



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
INNER JOIN producto p
    ON i.id_producto = p.id_producto
INNER JOIN almacen a
    ON i.id_almacen = a.id_almacen;



CREATE VIEW vw_reporte_ventas_simuladas AS
SELECT
    v.id_venta,
    v.fecha,
    p.id_producto,
    p.codigo_serie,
    p.nombre AS nombre_producto,
    COUNT(dv.id_detalle) AS cantidad,
    p.precio AS precio_unitario,
    COUNT(dv.id_detalle) * p.precio AS valor_total,
    e.nombre_empleado
FROM venta v
INNER JOIN detalle_venta dv
    ON v.id_venta = dv.id_venta
INNER JOIN producto p
    ON dv.id_producto = p.id_producto
INNER JOIN empleado e
    ON v.id_empleado = e.id_empleado
GROUP BY
    v.id_venta,
    v.fecha,
    p.id_producto,
    p.codigo_serie,
    p.nombre,
    p.precio,
    e.nombre_empleado;