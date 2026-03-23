const { resolve } = require('dns');
const fs = require('fs');
const readline = require('readline');

function crearReadline() {
    return readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });
}

function pregunta(r1, texto) {
    return new Promise((resolve) => {
        rl.question(texto, (respuesta) => {
            resolve(respuesta);
        });
    });
}

async function setup() {
    const rl = crearReadline();

    console.log('Ingresa tus datos de conexión.\n');

    const dbHost = await pregunta(rl, 'Host MySQL (Enter = localhost): ') || 'localhost';
    const dbUser = await pregunta(rl, 'Usuario MySQL (Enter = root):') || 'root';
    const dbPassword = await pregunta(rl, 'Password de usuario MySQL: ');
    const dbName = await pregunta(rl, 'Nombre de Base de datos MySQL (Enter = sistema_inventario): ') || 'sistema_inventario';

    console.log ('');

    const mongoUri = await pregunta(rl, 'URI MongoDB (Enter = mongodb://localhost:27017): ') || 'mongodb://localhost:27017';
    const mongoDb = await pregunta(rl, 'Nombre Base de datos MongoDB (Enter = sistema_inventario): ') || 'sistema_inventario';
        
        console.log('\n Guardando configuracion');

        const contenido = `# CONFIGURACION API SISTEMA INVENTARIO
        
        # MySQL
        DB_HOST=${dbHost}
        DB_USER=${dbUser}
        DB_PASSWORD=${dbPassword}
        DB_NAME=${dbName}
        
        # MongoDB
        MONGO_URI=${mongoUri}
        MONGO_DB_NAME=${mongoDb}`;

        fs.writeFileSync('.env', contenido);

        console.log('Configuración guardada en .env\n');
        console.log('Estos datos ya no se pedirán la proxima vez que se inicie.\n');

        rl.close();
}

function obtenerCredenciales() {
    return new Promise((resolve) => {
        const rl = crearReadline();

        console.log('\n INICIO RAPIDO - SISTEMA INVENTARIO\n ');

        pregunta(rl, 'Ingresa su contraseña de MySQL: ').then((dbPassword) => {
            const contenido = fs.readFileSync('.env', 'utf8');
            const nuevoContenido = contenido.replace(/^DB_PASSWORD.*$/m, `DB_PASSWORD=${dbPassword}`);
            fs.writeFileSync('.env', nuevoContenido);
            console.log('\n Password actualizado\n');
            rl.close();
            resolve();
        });
    });
}

module.exports = { setup, obtenerCredenciales };