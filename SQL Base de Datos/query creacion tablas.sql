create database inventario;
use inventario;

Create table roles
(
id_rol int auto_increment primary key,
nombre_rol varchar(50),
descripcion_rol varchar(100)
);

Create table empleados
(
id_empleado int auto_increment primary key,
nombre_empleado varchar(60),
correo_empleado varchar(60),
password_empleado varchar(25),
id_rol int,
foreign key (id_rol) references roles(id_rol)
);

Create table productos
(
id_producto int auto_increment primary key,
codigo_serie varchar(50) unique,
nombre varchar(50) not null,
descripcion varchar(80),
precio decimal(10,2) not null,
stock int not null,
ubicacion_almacen varchar(80)
);

Create table ventas
(
id_venta int auto_increment primary key,
fecha datetime not null,
total decimal(10,2),
id_empleado int,
foreign key (id_empleado) references empleados(id_empleado)
);

Create table detalle_venta
(
id_detalle int auto_increment primary key,
id_venta int,
id_producto int,
foreign key (id_venta) references ventas(id_venta),
foreign key (id_producto) references productos(id_producto)
);

describe roles;
describe ventas;
describe empleados;
describe detalle_venta;
describe productos;





