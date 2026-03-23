# Estructura de Sistema Inventario para utilizar POSTMAN

## Dependencias

`Carpeta API`
``npm install``

### Iniciar
```
npm start
```
Se configura las credenciales MySQL y MongoDB.

### Despues de la primera vez.
```
npm start
```
Sin configuracion

### Crear .exe
```
npm run build:win
```

```
npm run build:linux
```


```
npm run build:macos
```

## RUTAS POSTMANT

### Base
GET | `/prueba` | Verificar que esté conectado

### Productos
GET |`/productos`| Lista Productos
GET |`/productos/:id`| Ver producto en especifico
POST| `/productos`| Crear producto
PUT |`/productos/:id`| Modificar producto 
DELETE |`/productos/:id`| Borrar producto

### Categorias
GET |`/categorias`| Lista categorias con cantidad de productos
GET |`/categorias/:id`| Ver una categoria con productos
POST| `/categorias`| Crear categoria
PUT |`/caegorias/:id`| Modificar categoria 
DELETE |`/categorias/:id`| Borrar categoria

### Ventas
GET |`/ventas`| Lista Ventas
GET |`/ventas/:id`| Ver venta en especifico
POST| `/ventas`| Crear venta
PUT |`/ventas/:id`| Cancelar venta 

### Inventario
GET |`/inventario`| Lista Ventas
GET |`/inventario/:almacenId`| Ver venta en especifico
PUT |`/inventario/:id/:almacenId`| Cancelar venta 

### Reportes 
GET |`/reportes/inventario`| Reporte general (vista sql)
GET |`/reportes/ventas`| Reporte ventas (vista sql)
GET | `/reportes/ubicacion`| Por ubicacion (vista sql)
GET |`/reportes/mas-vendidos`| Ranking productos
GET |`/reportes/bajo-stock?nivel=20`| Stock bajo 

### MongoDB
GET |`/mongo/transacciones`| Historial de ventas
GET |`/mongo/historial/:codigo`| Historial de cambios de producto
GET |`/mongo/comentarios`| Lista de comentarios
POST| `/mongo/comentarios`| Agregar comentario
DELETE |`/mongo/comentarios/:id`| Eliminar comentario


## RUTAS EJEMPLO DE POSTMAN

POST http://localhost:3000/
GET http://localhost:3000/
PUT http://localhost:3000/
DELETE http://localhost:3000/

Seguido de la ruta requerida Ej. /inventario