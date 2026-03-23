// Seleccionar la base de datos
use sistema_inventario;

db.historial_modificaciones.drop();
db.createCollection("historial_modificaciones");

// Crear colecciones
db.createCollection("transacciones_historicas")
db.createCollection("historial_modificaciones")
db.createCollection("comentarios_operadores")
//

// Crear coleccion transacciones_historicas con índices
db.transacciones_historicas.drop();
db.createCollection("transacciones_historicas");

db.transacciones_historicas.createIndex({ fecha: -1 });
db.transacciones_historicas.createIndex({ codigo_producto: 1 });
db.transacciones_historicas.createIndex({ tipo_operacion: 1 });

// Insertar documentos en transacciones_historicas
db.transacciones_historicas.insertMany([
  {
        codigo_producto: "PL-001",
        nombre_producto: "Laptop HP Pavilion",
        cantidad: 1,
        fecha: new Date("2026-03-01T10:30:00"),
        valor_total: 1500.00,
        id_venta: 1,
        id_almacen: 1,
        tipo_operacion: "venta"
  },
  {
        codigo_producto: "PM-002",
        nombre_producto: "Mouse Inalambrico",
        cantidad: 1,
        fecha: new Date("2026-03-01T10:30:00"),
        valor_total: 25.00,
        id_venta: 1,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PMO-004",
        nombre_producto: "Monitor 24\"",
        cantidad: 1,
        fecha: new Date("2026-03-02T14:15:00"),
        valor_total: 900.00,
        id_venta: 2,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PTM-003",
        nombre_producto: "Teclado Mecanico",
        cantidad: 1,
        fecha: new Date("2026-03-02T14:15:00"),
        valor_total: 225.00,
        id_venta: 2,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PA-005",
        nombre_producto: "Auriculares USB",
        cantidad: 1,
        fecha: new Date("2026-03-02T14:15:00"),
        valor_total: 350.00,
        id_venta: 2,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PW-006",
        nombre_producto: "Webcam HD",
        cantidad: 1,
        fecha: new Date("2026-03-03T09:45:00"),
        valor_total: 850.00,
        id_venta: 3,
        id_almacen: 2,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PMH-009",
        nombre_producto: "Cable HDMI 2m",
        cantidad: 3,
        fecha: new Date("2026-03-03T09:45:00"),
        valor_total: 225.00,
        id_venta: 3,
        id_almacen: 2,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PAH-010",
        nombre_producto: "Hub USB 4 puertos",
        cantidad: 1,
        fecha: new Date("2026-03-03T09:45:00"),
        valor_total: 125.00,
        id_venta: 3,
        id_almacen: 2,
        tipo_operacion: "venta"
    },
    // Venta 4: Monitor
    {
        codigo_producto: "PMO-004",
        nombre_producto: "Monitor 24\"",
        cantidad: 1,
        fecha: new Date("2026-03-04T16:20:00"),
        valor_total: 900.00,
        id_venta: 4,
        id_almacen: 3,
        tipo_operacion: "venta"
    },
    // Venta 5: Teclado + Auriculares
    {
        codigo_producto: "PTM-003",
        nombre_producto: "Teclado Mecanico",
        cantidad: 1,
        fecha: new Date("2026-03-05T11:00:00"),
        valor_total: 225.00,
        id_venta: 5,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PA-005",
        nombre_producto: "Auriculares USB",
        cantidad: 1,
        fecha: new Date("2026-03-05T11:00:00"),
        valor_total: 350.00,
        id_venta: 5,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    // Venta 6: Laptop + RAM
    {
        codigo_producto: "PL-001",
        nombre_producto: "Laptop HP Pavilion",
        cantidad: 1,
        fecha: new Date("2026-03-06T13:30:00"),
        valor_total: 1500.00,
        id_venta: 6,
        id_almacen: 2,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PMR-008",
        nombre_producto: "Memoria RAM 8GB",
        cantidad: 2,
        fecha: new Date("2026-03-06T13:30:00"),
        valor_total: 1050.00,
        id_venta: 6,
        id_almacen: 2,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PM-002",
        nombre_producto: "Mouse Inalambrico",
        cantidad: 1,
        fecha: new Date("2026-03-07T15:45:00"),
        valor_total: 25.00,
        id_venta: 7,
        id_almacen: 3,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PTM-003",
        nombre_producto: "Teclado Mecanico",
        cantidad: 1,
        fecha: new Date("2026-03-07T15:45:00"),
        valor_total: 225.00,
        id_venta: 7,
        id_almacen: 3,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PD-007",
        nombre_producto: "Disco SSD 500GB",
        cantidad: 2,
        fecha: new Date("2026-03-08T10:15:00"),
        valor_total: 1500.00,
        id_venta: 8,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PMH-009",
        nombre_producto: "Cable HDMI 2m",
        cantidad: 1,
        fecha: new Date("2026-03-08T10:15:00"),
        valor_total: 75.00,
        id_venta: 8,
        id_almacen: 1,
        tipo_operacion: "venta"
    },
    {
        codigo_producto: "PAH-010",
        nombre_producto: "Hub USB 4 puertos",
        cantidad: 1,
        fecha: new Date("2026-03-08T10:15:00"),
        valor_total: 125.00,
        id_venta: 8,
        id_almacen: 1,
        tipo_operacion: "venta"
    }
]);


// Imprimir documentos insertados
print("Coleccion transacciones_historicas creada con " + db.transacciones_historicas.countDocuments() + " documentos");


// Crear coleccion historial_modificaciones con índices
db.historial_modificaciones.drop();
db.createCollection("historial_modificaciones");

db.historial_modificaciones.createIndex({ id_producto: 1 });
db.historial_modificaciones.createIndex({ codigo_producto: 1 });
db.historial_modificaciones.createIndex({ fecha: -1 });
db.historial_modificaciones.createIndex({ tipo_cambio: 1 });

// Insertar documentos en historial_modificaciones
db.historial_modificaciones.insertMany([
{
        id_producto: 1,
        codigo_producto: "PL-001",
        nombre_producto: "Laptop HP Pavilion",
        campo_modificado: "precio",
        valor_anterior: 1400.00,
        valor_nuevo: 1500.00,
        fecha: new Date("2026-02-15T09:00:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "actualizacion"
    },
    {
        id_producto: 1,
        codigo_producto: "PL-001",
        nombre_producto: "Laptop HP Pavilion",
        campo_modificado: "producto_nuevo",
        valor_anterior: null,
        valor_nuevo: "Creado en el sistema",
        fecha: new Date("2026-01-10T08:30:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "creacion"
    },
    {
        id_producto: 4,
        codigo_producto: "PMO-004",
        nombre_producto: "Monitor 24\"",
        campo_modificado: "precio",
        valor_anterior: 850.00,
        valor_nuevo: 900.00,
        fecha: new Date("2026-02-20T14:15:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "actualizacion"
    },
    {
        id_producto: 4,
        codigo_producto: "PMO-004",
        nombre_producto: "Monitor 24\"",
        campo_modificado: "producto_nuevo",
        valor_anterior: null,
        valor_nuevo: "Creado en el sistema",
        fecha: new Date("2026-01-10T08:35:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "creacion"
    },
    {
        id_producto: 6,
        codigo_producto: "PW-006",
        nombre_producto: "Webcam HD",
        campo_modificado: "descripcion",
        valor_anterior: "Camara web 1080p",
        valor_nuevo: "Camara web 1080p con microfono",
        fecha: new Date("2026-02-25T11:00:00"),
        usuario: "Ana Lopez",
        tipo_cambio: "actualizacion"
    },
    {
        id_producto: 7,
        codigo_producto: "PD-007",
        nombre_producto: "Disco SSD 500GB",
        campo_modificado: "precio",
        valor_anterior: 700.00,
        valor_nuevo: 750.00,
        fecha: new Date("2026-03-01T10:00:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "actualizacion"
    },
    {
        id_producto: 8,
        codigo_producto: "PMR-008",
        nombre_producto: "Memoria RAM 8GB",
        campo_modificado: "precio",
        valor_anterior: 500.00,
        valor_nuevo: 525.00,
        fecha: new Date("2026-03-05T16:30:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "actualizacion"
    },
    {
        id_producto: 10,
        codigo_producto: "PAH-010",
        nombre_producto: "Hub USB 4 puertos",
        campo_modificado: "producto_nuevo",
        valor_anterior: null,
        valor_nuevo: "Creado en el sistema",
        fecha: new Date("2026-01-10T08:45:00"),
        usuario: "Carlos Rodriguez",
        tipo_cambio: "creacion"
    }
]);

// Imprimir documentos insertados en historial_modificaciones
print("Coleccion historial_modificaciones creada con " + db.historial_modificaciones.countDocuments() + " documentos");


// Crear coleccion comentarios_operadores con índices
db.comentarios_operadores.drop();
db.createCollection("comentarios_operadores");

db.comentarios_operadores.createIndex({ id_producto: 1 });
db.comentarios_operadores.createIndex({ codigo_producto: 1 });
db.comentarios_operadores.createIndex({ operador: 1 });
db.comentarios_operadores.createIndex({ fecha: -1 });
db.comentarios_operadores.createIndex({ prioridad: 1 });

// Insertar comentarios de operadores a la coleccion
db.comentarios_operadores.insertMany([
  {
        id_producto: 1,
        codigo_producto: "PL-001",
        operador: "Maria Garcia",
        comentario: "Producto con muy alta demanda. Stock se agota rapidamente. Sugiero aumentar reposicion.",
        fecha: new Date("2026-03-05T09:30:00"),
        prioridad: "alta"
    },
    {
        id_producto: 4,
        codigo_producto: "PMO-004",
        operador: "Luis Martinez",
        comentario: "Los clientes preguntan mucho por este modelo. Considerar tener mas stock en almacen norte.",
        fecha: new Date("2026-03-06T14:20:00"),
        prioridad: "media"
    },
    {
        id_producto: 7,
        codigo_producto: "PD-007",
        operador: "Ana Lopez",
        comentario: "SSD de 500GB muy pedido para upgrades de PC. Proveedor tiene demora de 3 dias.",
        fecha: new Date("2026-03-07T11:15:00"),
        prioridad: "alta"
    },
    {
        id_producto: 8,
        codigo_producto: "PMR-008",
        operador: "Pedro Sanchez",
        comentario: "Memoria RAM DDR4 3200 muy compatible con laptops HP y Lenovo.",
        fecha: new Date("2026-03-08T08:45:00"),
        prioridad: "baja"
    },
    {
        id_producto: 3,
        codigo_producto: "PTM-003",
        operador: "Maria Garcia",
        comment: "Teclado mecanico muy popular para gaming. RGB llama mucho la atencion.",
        fecha: new Date("2026-03-04T16:00:00"),
        prioridad: "media"
    },
    {
        id_producto: 2,
        codigo_producto: "PM-002",
        operador: "Luis Martinez",
        comentario: "Mouse recargable tiene buena aceptaicon. La bateria dura aproximadamente 2 semanas.",
        fecha: new Date("2026-03-03T13:30:00"),
        prioridad: "baja"
    },
    {
        id_producto: 6,
        codigo_producto: "PW-006",
        operador: "Ana Lopez",
        comentario: "Webcam HD muy solicitada para reuniones virtuales. Incluir en promo de combo con auriculares.",
        fecha: new Date("2026-03-07T10:20:00"),
        prioridad: "media"
    },
    {
        id_producto: 9,
        codigo_producto: "PMH-009",
        operador: "Pedro Sanchez",
        comentario: "Cable HDMI 4K muy vendido. Buena utilidad como accesorio para cualquier venta de monitor.",
        fecha: new Date("2026-03-08T15:10:00"),
        prioridad: "baja"
    }
]);

// Imprimir documentos insertados en comentarios_operadores
print("Coleccion comentarios_operadores creada con " + db.comentarios_operadores.countDocuments() + " documentos");



// Consultas básicas (querys) 

print("");
print("1. Ventas totales por producto:");
db.transacciones_historicas.aggregate([
    { $group: {
        _id: "$codigo_producto",
        nombre_producto: { $first: "$nombre_producto" },
        total_vendido: { $sum: "$cantidad" },
        valor_total: { $sum: "$valor_total" }
    }},
    { $sort: { total_vendido: -1 } }
]).forEach(doc => print("   " + doc._id + ": " + doc.total_vendido + " unidades - $" + doc.valor_total));


print("");
print("2. Historial de modificaciones del producto PL-001:");
db.historial_modificaciones.find({ codigo_producto: "PL-001" }).forEach(doc => 
    print("   [" + doc.fecha.toISOString().split('T')[0] + "] " + doc.campo_modificado + ": " + doc.valor_anterior + " -> " + doc.valor_nuevo + " (" + doc.usuario + ")"));

print("");
print("3. Comentarios con prioridad alta:");
db.comentarios_operadores.find({ prioridad: "alta" }).forEach(doc => 
    print("   [" + doc.codigo_producto + "] " + doc.operador + ": " + doc.comentario.substring(0, 50) + "..."));

print("");
    print("4. Transacciones por almacen:");
db.transacciones_historicas.aggregate([
    { $group: {
        _id: "$id_almacen",
        total_transacciones: { $sum: 1 },
        valor_total: { $sum: "$valor_total" }
    }},
    { $sort: { _id: 1 } }
]).forEach(doc => 
    print("   Almacen " + doc._id + ": " + doc.total_transacciones + " ventas - $" + doc.valor_total));


print("");
db.transacciones_historicas.find({})   // Ver todas las transacciones

db.transacciones_historicas.aggregate([
  { $group: {
      _id: "$codigo_producto",
      total_vendido: { $sum: "$cantidad" },
      valor_total: { $sum: "$valor_total" }
  }}
])   // Agrupar ventas por producto

db.comentarios_operadores.find({ operador: "María" })   // Ver comentarios de un operador específico
