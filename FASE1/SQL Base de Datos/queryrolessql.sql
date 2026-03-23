use sistema_inventario; 

create role administrador;
create role operador;

Grant all privileges
on sistema_inventario.* to administrador;

grant select on sistema_inventario.producto to operador;
grant select on sistema_inventario.inventario to operador;
grant select on sistema_inventario.inventario to operador;
grant insert on sistema_inventario.venta to operador;
grant insert on sistema_inventario.detalle_venta to operador;