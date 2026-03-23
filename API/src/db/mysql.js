require('dotenv').config();
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'sistema_inventario',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});


async function testMYSQL() {
    try {
        const [rows] = await pool.query('SELECT 1');
        console.log('MySQL: Conexion exitosa');
        return true;
    } catch (error) {
        console.error('MySQL: Error de conexion', error.message);
        return false;
    }
}

module.exports = { pool, testMYSQL };