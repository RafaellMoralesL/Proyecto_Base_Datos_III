USE sistema_inventario;




-- MODIFICACION TABLA VENTA

ALTER TABLE venta
ADD estado ENUM('pendiente','completada','cancelada')
DEFAULT 'pendiente';


-- VALIDAR REGISTRO DE PRODUCTO
DROP TRIGGER IF EXISTS validar_producto_registro;

DELIMITER $$

CREATE TRIGGER validar_producto_registro
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN

IF NEW.precio <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El precio debe ser mayor que cero';
END IF;

END$$

DELIMITER ;


-- VALIDAR ACTUALIZACION DE PRODUCTO

DROP TRIGGER IF EXISTS validar_producto_update;

DELIMITER $$

CREATE TRIGGER validar_producto_update
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN

IF NEW.precio <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El precio debe ser mayor que cero';
END IF;

END$$

DELIMITER ;





-- VALIDACION STOCK DISPONIBLE


DROP TRIGGER IF EXISTS validar_stock_venta;

DELIMITER $$

CREATE TRIGGER validar_stock_venta
BEFORE INSERT ON detalle_venta
FOR EACH ROW
BEGIN

DECLARE stock_actual INT;

SELECT stock
INTO stock_actual
FROM inventario
WHERE id_producto = NEW.id_producto
LIMIT 1;

IF stock_actual <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta';
END IF;

END$$

DELIMITER ;



-- DESCONTAR STOCK

DROP TRIGGER IF EXISTS actualizar_stock;

DELIMITER $$

CREATE TRIGGER actualizar_stock
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN

UPDATE inventario
SET stock = stock - 1
WHERE id_producto = NEW.id_producto
LIMIT 1;

END$$

DELIMITER ;



-- VALIDACION CAMBIO DE ESTADO


DROP TRIGGER IF EXISTS validar_estado;

DELIMITER $$

CREATE TRIGGER validar_estado
BEFORE UPDATE ON venta
FOR EACH ROW
BEGIN

IF OLD.estado = 'cancelada' AND NEW.estado = 'completada' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'No se puede completar una venta cancelada';
END IF;

END$$

DELIMITER ;


-- DEVOLVER STOCK SI SE CANCELA UNA VENTA


DROP TRIGGER IF EXISTS devolver_stock_cancelacion;

DELIMITER $$

CREATE TRIGGER devolver_stock_cancelacion
AFTER UPDATE ON venta
FOR EACH ROW
BEGIN

IF OLD.estado = 'completada' AND NEW.estado = 'cancelada' THEN

UPDATE inventario i
JOIN ( 
select id_producto, COUNT(*) cantidad
FROM detalle_venta
WHERE id_venta = new.id_venta
GROUP BY id_producto
) dv ON i.id_producto = dv.id_producto
SET i.stock = i.tock + dv.cantidad;

END IF;
END$$

DELIMITER ;



CREATE INDEX idx_detalle_venta_idventa ON detalle_venta(id_venta);

CREATE INDEX idx_detalle_venta_idproducto ON detalle_venta(id_producto);

CREATE INDEX idx_inventario_producto ON inventario(id_producto);

CREATE UNIQUE INDEX idx_producto_almacen ON inventario(id_producto,id_almacen);