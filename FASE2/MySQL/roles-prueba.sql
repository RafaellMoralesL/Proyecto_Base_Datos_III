-- DEMOSTRACIÓN DE ROLES Y PERMISOS
-- Sistema de Inventario 

USE sistema_inventario;


-- Verificar que los roles existen


-- Ver roles en mysql.user
SELECT 
    user AS usuario,
    host,
    account_locked AS bloqueada
FROM mysql.user 
WHERE user IN ('sys_admin', 'sys_operador');


-- Permisos de cada rol


-- Permisos del rol Administrador (sys_admin)
SHOW GRANTS FOR sys_admin;

-- Permisos del rol Operador (sys_operador)
SHOW GRANTS FOR sys_operador;


-- Permisos de cada usuario

-- Permisos efectivos del usuario admin
SHOW GRANTS FOR 'admin'@'localhost';

-- Permisos efectivos del usuario operador
SHOW GRANTS FOR 'operador'@'localhost';


-- Verificar rol default asignado


SELECT 
    user,
    host,
    default_role
FROM mysql.user 
WHERE user IN ('admin', 'operador');

-- Demostración de permisos ADMIN
-- El admin tiene ALL PRIVILEGES


-- Puede hacer DELETE en cualquier tabla
-- DELETE FROM venta WHERE id_venta = 1;  

-- Puede hacer DROP tables
-- DROP TABLE IF EXISTS prueba_admin;

-- Puede crear usuarios
-- CREATE USER 'test_admin'@'localhost' IDENTIFIED BY 'test123';
-- GRANT ALL ON sistema_inventario.* TO 'test_admin'@'localhost';



-- Demostración de permisos OPERADOR

-- El operador tiene permisos LIMITADOS:

-- PUEDE hacer SELECT en todas las tablas
SELECT 'OPERADOR: Puede hacer SELECT en producto' AS permiso;
SELECT COUNT(*) AS total_productos FROM producto;

-- PUEDE hacer INSERT en venta
SELECT 'OPERADOR: Puede hacer INSERT en venta' AS permiso;

-- PUEDE hacer INSERT en detalle_venta
SELECT 'OPERADOR: Puede hacer INSERT en detalle_venta' AS permiso;

-- PUEDE hacer UPDATE en inventario (para descontar stock)
SELECT 'OPERADOR: Puede hacer UPDATE en inventario' AS permiso;

-- PUEDE ejecutar procedimientos almacenados
SELECT 'OPERADOR: Puede ejecutar sp_productos_por_rango_precio' AS permiso;
CALL sp_productos_por_rango_precio(100, 500);

SELECT 'OPERADOR: Puede ejecutar sp_mas_vendidos' AS permiso;
CALL sp_mas_vendidos(5);

-- NO puede hacer DELETE en venta
-- DELETE FROM venta WHERE id_venta = 1;


-- NO puede DROP tables
-- DROP TABLE producto;

-- NO puede crear usuarios
-- CREATE USER 'prueba'@'localhost' IDENTIFIED BY 'pass';
