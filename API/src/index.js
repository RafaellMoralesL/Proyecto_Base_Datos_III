const fs = require('fs');
const express = require('express');
const cors = require('cors');

const { setup, obtenerConexion } = require('./setup');
const { testMYSQL} = require('./db/mysql');
const { testMongo} = require('./db/mongodb');

const productosRoutes = require('./routes/productos');
const ventasRoutes = require('./routes/ventas');
const inventarioRoutes = require('./routes/inventario');
const reportesRoutes = require('./routes/reportes');
const categoriasRoutes = require('./routes/categorias');
const mongoRoutes = require('./routes/mongo');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Probar conexion a las DB
app.get('/prueba', async (req, res) => {
    try {
        await testMYSQL();
        await testMongo();
        res.json({
            mysql: 'OK',
            mongodb: 'OK',
            api: 'OK'
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.use('/productos', productosRoutes);
app.use('/ventas', ventasRoutes);
app.use('/inventario', inventarioRoutes);
app.use('/reportes', reportesRoutes);
app.use('/categorias', categoriasRoutes);
app.use('/mong', mongoRoutes);

//En caso de que la ruta no exista
app.use((req, res) => {
    res.status(404).json({
        error: 'Runta no encontrada',
        ruta: req.method + ' ' + req.path 
    });
});

app.use((err, req, res, next) => {
    console.error('Error:', err);
    res.status(500).json({ error: err.message });
});

async function iniciar() {
    try {

        if (!fs.existsSync('.env')) {
            console.log('Primera ejecución. Configuración requerida.\n');
            await setup();
        }

        require('dotenv').config();

        const mysqlOK = await testMYSQL();
        const mongoOK = await testMongo();

        if ( !mysqlOK || !mongoOK) {
            console.error('Error: No se pudo conectar a las bases de datos');
            console.log('Configura .env y reinicio.\n');
            process.exit(1);
        }

        app.listen(PORT, () => {
            console.log(`\n API corriendo en http://localhost:${PORT}`);
        });
        
    } catch (error) {
        console.error('Error al inicia:', error.message);
        process.exit(1);
    }
}

iniciar();