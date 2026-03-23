create database sistema_inventario;
use sistema_inventario;

Create table rol
(
id_rol int auto_increment primary key,
nombre_rol varchar(50) not null,
descripcion_rol varchar(100)
);

Create table empleado
(
id_empleado int auto_increment primary key,
nombre_empleado varchar(60) not null,
correo_empleado varchar(60) not null unique,
password_empleado varchar(25),
id_rol int not null,
foreign key (id_rol) references rol(id_rol)
);

Create table producto
(
id_producto int auto_increment primary key,
codigo_serie varchar(50) not null unique,
nombre varchar(50) not null,
descripcion varchar(80),
precio decimal(10,2) not null
);

Create table almacen
(
id_almacen int auto_increment primary key,
nombre_almacen varchar(50) not null,
ubicacion_almacen varchar(80) not null
);

Create table inventario
(
id_inventario int auto_increment primary key,
id_producto int not null,
id_almacen int not null,
stock int not null,
ubicacion_interna varchar(80),
foreign key (id_producto) references producto(id_producto),
foreign key (id_almacen)  references almacen(id_almacen)
);

Create table venta
(
id_venta int auto_increment primary key,
fecha datetime not null,
total decimal(10,2) not null,
id_empleado int not null,
foreign key (id_empleado) references empleado(id_empleado)
);

Create table detalle_venta
(
id_detalle int auto_increment primary key,
id_venta int not null,
id_producto int not null,
foreign key (id_venta) references venta(id_venta),
foreign key (id_producto) references producto(id_producto)
);

describe rol;
describe venta;
describe empleado;
describe detalle_venta;
describe producto;
describe inventario;
describe almacen;







