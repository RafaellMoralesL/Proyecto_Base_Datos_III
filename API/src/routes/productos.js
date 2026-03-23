const express = require('express');
const router = express.Router();
const { pool } = require('../db/mysql');
const { colecciones } = require('../db/mongodb');
const { parse } = require('node:path');


// Listar los productos

router.get('/', async (req, res) => {
    try {
        const [productos] = await pool.query('SELECT * FROM producto ORDER BY nombre');

        res.json({
            total: productos.length,
            productos
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Ver producto en especifico por ID

router.get('/:id', async (req, res) => {
    try {
        const [productos] = await pool.query(
            'SELECT * FROM producto WHERE id_producto = ?',
            [req.params.id]
        );

        if (productos.length === 0) {
            return res.status(404).json({ error: 'Producto no encontrado'});
        }
        
        res.json(productos[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Crear un producto

router.post('/', async (req, res) => {
    try {
        const { codigo_serie, nombre, descripcion, precio, usuario } = req.body;

        // Validar
        if (!codigo_serie || !nombre || !precio) {
            return res.status(400).json({ error: 'codigo_serie, nombre y precio son requeridos' });
        }

        // Verficar que el codigo sea unico
        const [existe] = await pool.query(
            'SELECT id_producto FROM producto WHERE codigo_serie = ?',
            [codigo_serie]
        );

        if (existe.length > 0) {
            return res.status(400).json({ error: 'Codigo de serie ya existe' });
        }

        // Insertar el producto si ya todo esta validado
        const [result] = await pool.query(
            'INSERT INTO producto (codigo_serie, nombre, descripcion, precio) VALUES (?, ?, ?, ?)',
            [codigo_serie, nombre, descripcion || null , precio]
        );

        const  id_producto = result.insertId;

        // Guardar en MongoDB el historial
        await colecciones.historial.insertOne({
            id_producto,
            codigo_producto: codigo_serie,
            campo_modificado: 'producto_nuevo',
            valor_anterior: null,
            valor_nuevo: { nombre, precio },
            fecha: new Date(),
            usuario: usuario || 'sistema',
            tipo_cambio: 'creacion'
        });

        res.status(201).json({
            mensaje: 'Producto creado',
            id_producto,
            producto: { codigo_serie, nombre, descripcion, precio }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Actualizar producto

router.put('/:id', async (req, res) => {
    try {
        const { nombre, descripcion, precio, usuario } = req.body;
        const id_producto = req.params.id;

        // Consultar valor actual
        const [actual] = await pool.query(
            'SELECT * FROM producto WHERE id_producto = ?',
            [id_producto]
        );

        if (actual.length === 0) {
            return res.status(404).json({ error: 'Producto no encontrado' });
        }

        const productoActual = actual[0];

        const cambios = [];
        if (nombre && nombre !== productoActual.nombre) cambios.push({ campo: 'nombre', anterior: productoActual.nombre, nuevo: nombre });
        if (descripcion && descripcion !== productoActual.descripcion) cambios.push({ campo: 'descripcion', anterior: productoActual.descripcion, nuevo: descripcion });
        if (precio && parseFloat(precio) !== parseFloat(productoActual.precio)) cambios.push({ campo: 'precio', anterior: productoActual.precio, nuevo: precio });

        const nuevosValores = {};
        if (nombre) nuevosValores.nombre = nombre;
        if (descripcion !== undefined) nuevosValores.descripcion = descripcion;
        if (precio) nuevosValores.precio = precio;

        if (Object.keys(nuevosValores).length > 0) {
            const campos = Object.keys(nuevosValores);
            const valores = Object.values(nuevosValores);

            await pool.query(
                `UPDATE producto SET ${campos.map(c => `${c} = ?`).joun(', ')} WHERE id_producto = ?`,
                [...valores, id_producto]
            );
        }

        // Guardar en MongoDB
        for (const cambio of cambios) {
            await colecciones.historial.insertOne({
                id_producto,
                codigo_producto: productoActual.codigo_serie,
                campo_modificado: cambio.campo,
                valor_anterior: cambio.anterior,
                valor_nuevo: cambio.nuevo,
                fecha: new Date(),
                usuario: usuario || 'sistema',
                tipo_cambio: 'actualizacion'
            });
        }

        res.json({
            mensaje: 'Producto actualizado',
            cambios: cambios.length > 0 ? cambios : 'Sin cambios'
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Eliminar un producto

router.delete('/:id', async (req, res) => {
    try {
        const [result] = await pool.query(
            'DELETE FROM producto WHERE id_producto = ?',
            [req.params.id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Producto no encontrado' });
        }

        res.json({ mensaje: 'Producto eliminado' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;