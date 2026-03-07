// Seleccionar la base de datos
use sistema_inventario

// Crear colecciones
db.createCollection("transacciones_historicas")
db.createCollection("historial_modificaciones")
db.createCollection("comentarios_operadores")

// Insertar documentos de prueba en cada colección
db.transacciones_historicas.insertOne({
  codigo_producto: "P001",
  cantidad: 10,
  fecha: ISODate("2025-12-15"),
  valor_total: 500.00
})

db.historial_modificaciones.insertOne({
  codigo_producto: "P002",
  cambio: "Stock ajustado",
  fecha: ISODate("2026-01-10"),
  usuario: "operador1"
})

db.comentarios_operadores.insertOne({
  codigo_producto: "P003",
  comentario: "Producto con baja rotación",
  fecha: ISODate("2026-02-20"),
  operador: "María"
})

// Consultas básicas (querys)
db.transacciones_historicas.find({})   // Ver todas las transacciones

db.transacciones_historicas.aggregate([
  { $group: {
      _id: "$codigo_producto",
      total_vendido: { $sum: "$cantidad" },
      valor_total: { $sum: "$valor_total" }
  }}
])   // Agrupar ventas por producto

db.comentarios_operadores.find({ operador: "María" })   // Ver comentarios de un operador específico
