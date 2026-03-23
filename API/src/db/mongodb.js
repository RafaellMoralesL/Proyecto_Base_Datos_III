require('dotenv').config();
const { MongoClient } = require('mongodb');

const MONGO_URI = 'mongodb://localhost:27017';
const DB_NAME = 'sistema_inventario';

const client = new MongoClient(MONGO_URI);
const db = client.db(DB_NAME);

const colecciones = {
    transacciones: db.collection('transacciones_historicas'),
    historial: db.collection('historial_modificaciones'),
    comentarios: db.collection('comentarios_operadores')
};

async function testMongo() {
    try {
        await client.connect();
        await db.command({ ping: 1 });
        console.log('MongoDB: Conexion exitosa');
        return true;
    } catch (error) {
        console.error('MongoDB: Error de conexion', error.message);
        return false;
    }
}

module.exports = { client, db, colecciones, testMongo };