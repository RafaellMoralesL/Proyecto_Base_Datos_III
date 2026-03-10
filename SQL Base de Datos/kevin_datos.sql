USE sistema_inventario;

-- =========================
-- CARGAR ROLES, EMPLEADOS Y 100 USUARIOS
-- =========================
DROP PROCEDURE IF EXISTS sp_cargar_usuarios_empleados;

DELIMITER $$

CREATE PROCEDURE sp_cargar_usuarios_empleados()
BEGIN
    DECLARE i INT DEFAULT 1;

    IF (SELECT COUNT(*) FROM rol) = 0 THEN
        INSERT INTO rol (nombre_rol, descripcion_rol)
        VALUES
            ('Administrador', 'Control total del sistema'),
            ('Bodega', 'Gestion de inventario'),
            ('Ventas', 'Registro de ventas');
    END IF;

    IF (SELECT COUNT(*) FROM empleado) = 0 THEN
        SET i = 1;
        WHILE i <= 10 DO
            INSERT INTO empleado (
                nombre_empleado,
                correo_empleado,
                password_empleado,
                id_rol
            )
            VALUES (
                CONCAT('Empleado ', i),
                CONCAT('empleado', i, '@correo.com'),
                CONCAT('emp', LPAD(i, 4, '0')),
                FLOOR(1 + RAND() * 3)
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    IF (SELECT COUNT(*) FROM usuario) = 0 THEN
        SET i = 1;
        WHILE i <= 100 DO
            INSERT INTO usuario (
                nombre_usuario,
                correo_usuario,
                password_usuario,
                telefono_usuario,
                direccion_usuario
            )
            VALUES (
                CONCAT('Usuario ', i),
                CONCAT('usuario', i, '@correo.com'),
                CONCAT('user', LPAD(i, 4, '0')),
                CONCAT('55', LPAD(i, 6, '0')),
                CONCAT('Direccion ', i)
            );

            SET i = i + 1;
        END WHILE;
    END IF;
END $$

DELIMITER ;

CALL sp_cargar_usuarios_empleados();

-- =========================
-- PRODUCTOS / ALMACENES / INVENTARIO SI HACE FALTA
-- =========================
DROP PROCEDURE IF EXISTS sp_cargar_catalogos_base;

DELIMITER $$

CREATE PROCEDURE sp_cargar_catalogos_base()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;

    IF (SELECT COUNT(*) FROM producto) = 0 THEN
        SET i = 1;
        WHILE i <= 30 DO
            INSERT INTO producto (
                codigo_serie,
                nombre,
                descripcion,
                precio
            )
            VALUES (
                CONCAT('P', LPAD(i, 4, '0')),
                CONCAT('Producto ', i),
                CONCAT('Descripcion del producto ', i),
                ROUND(25 + RAND() * 975, 2)
            );

            SET i = i + 1;
        END WHILE;
    END IF;

    IF (SELECT COUNT(*) FROM almacen) = 0 THEN
        INSERT INTO almacen (nombre_almacen, ubicacion_almacen)
        VALUES
            ('Almacen Central', 'Zona 1'),
            ('Almacen Norte', 'Zona 18'),
            ('Almacen Sur', 'Villa Nueva'),
            ('Almacen Oriente', 'Zona 5'),
            ('Almacen Occidente', 'Mixco');
    END IF;

    IF (SELECT COUNT(*) FROM inventario) = 0 THEN
        SET i = 1;
        WHILE i <= 30 DO
            SET j = 1;
            WHILE j <= 5 DO
                INSERT INTO inventario (
                    id_producto,
                    id_almacen,
                    stock,
                    ubicacion_interna
                )
                VALUES (
                    i,
                    j,
                    FLOOR(20 + RAND() * 81),
                    CONCAT('Pasillo ', j, ' - Estante ', FLOOR(1 + RAND() * 10))
                );

                SET j = j + 1;
            END WHILE;

            SET i = i + 1;
        END WHILE;
    END IF;
END $$

DELIMITER ;

CALL sp_cargar_catalogos_base();

-- =========================
-- GENERAR VENTAS RANDOM
-- =========================
DROP PROCEDURE IF EXISTS sp_generar_ventas_random;

DELIMITER $$

CREATE PROCEDURE sp_generar_ventas_random()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE v_venta INT;
    DECLARE v_lineas INT;
    DECLARE v_empleado INT;
    DECLARE v_usuario INT;
    DECLARE v_producto INT;
    DECLARE v_fecha DATETIME;

    WHILE i <= 300 DO
        SET v_empleado = FLOOR(1 + RAND() * 10);
        SET v_usuario = FLOOR(1 + RAND() * 100);

        SET v_fecha = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY);
        SET v_fecha = DATE_ADD(v_fecha, INTERVAL FLOOR(RAND() * 24) HOUR);
        SET v_fecha = DATE_ADD(v_fecha, INTERVAL FLOOR(RAND() * 60) MINUTE);

        INSERT INTO venta (fecha, total, id_empleado, id_usuario)
        VALUES (v_fecha, 0, v_empleado, v_usuario);

        SET v_venta = LAST_INSERT_ID();
        SET v_lineas = FLOOR(1 + RAND() * 5);

        SET j = 1;
        WHILE j <= v_lineas DO
            SET v_producto = FLOOR(1 + RAND() * 30);

            INSERT INTO detalle_venta (id_venta, id_producto)
            VALUES (v_venta, v_producto);

            SET j = j + 1;
        END WHILE;

        UPDATE venta v
        JOIN (
            SELECT dv.id_venta, SUM(p.precio) AS total_calculado
            FROM detalle_venta dv
            INNER JOIN producto p
                ON p.id_producto = dv.id_producto
            WHERE dv.id_venta = v_venta
            GROUP BY dv.id_venta
        ) x
            ON x.id_venta = v.id_venta
        SET v.total = x.total_calculado
        WHERE v.id_venta = v_venta;

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL sp_generar_ventas_random();