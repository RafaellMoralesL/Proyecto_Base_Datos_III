const express = require('express');
const router = express.Router();
const { pool } = require('../db/mysql');


// Listar las categorias

router.get('/', async (req, res) => {
    try {
        const [categorias] = await pool.query(
            `SELECT c.*, COUNT(pc.id_producto) AS num_productos
            FROM categoria c
            LEFT JOIN producto_categoria p ON c.id_categoria = p.id_categoria
            GROUP BY c.id_categoria, c.nombre, c.descripcion
            ORDER BY c.nombre`
        );

        res.json({ total: categorias.length, categorias });
    } catch (error) {
        res.status(500).json({ error: error.message });
    } 
});

// Ver categoria en especifico por ID

router.get('/:id', async (req, res) => {
    try {
        const [categorias] = await pool.query(
            'SELECT * FROM categoria WHERE id_categoria = ?',
            [req.params.id]
        );

        if (categorias.length === 0) {
            return res.status(404).json({ error: 'Categoria no encontrada' });
        }

        const [productos] = await pool.query(
            `SELECT id_producto, codigo_serie, nombre, descripcion, precio
            FROM producto
            WHERE id_categoria = ?
            ORDER BY nombre`,
            [req.params.id]);

            res.json({
                categoria: categorias[0],
                productos
            });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Crear una categoria

router.post('/', async (req, res) => {
    try {
        const { nombre, descripcion } = req.body;

        if (!nombre) {
            return res.status(400).json({ error: 'El Nombre es requerido' });
        }

        const [existe] = await pool.query(
            'SELECT id_categoria FROM categoria WHERE nombre = ?',
            [nombre]
        );

        if (existe.length > 0) {
            return res.status(400).json({ error: 'Categoria ya existe' });
        }

        const [result] = await pool.query(
            'INSERT INTO categoria (nombre, descripcion) VALUES (?, ?)',
            [nombre, descripcion || null]
        );

        res.status(201).json({
            mensaje: 'Categoria creada',
            id_categoria: result.insertId,
            categoria: { nombre, descripcion }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Actualizar una categoria

router.put('/:id', async (req, res) => {
    try {
        const { nombre, descripcion } = req.body;

        const [existe] = await pool.query(
            'SELECT * FROM categoria WHERE id_categoria = ?',
            [req.params.id]
        );

        if (existe.length === 0) {
            return res.status(404).json({ error: 'Categoria no encontrada' });
        }

        const updates = [];
        const valores = [];

        if (nombre !== undefined) {
            updates.push('nombre = ?');
            valores.push(nombre);
        }

        if (descripcion !== undefined) {
            updates.push('descripcion = ?');
            valores.push(descripcion);
        }

        if (updates.length > 0) {
            valores.push(req.params.id);
            await pool.query(
                `UPDATE categoria SET ${updates.join(', ')} WHERE id_categoria = ?`,
                valores
            );
        }

        res.json({ mensaje: 'Categoria actualizada' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Eliminar una categoria

router.delete('/:id', async (req, res) => {
    try {
        const [productos] = await pool.query(
            'SELECT COUNT(*) AS cant FROM producto_categoria WHERE id_categoria = ?',
            [req.params.id]
        );

        if (productos[0].cant > 0) {
            return res.status(400).json({
                error: 'No se puede eliminar la categoria porque tiene productos asociados',
                productos: productos
            });
        }

        const [result] = await pool.query(
            'DELETE FROM categoria WHERE id_categoria = ?',
            [req.params.id]
        ); 

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Categoria no encontrada' });
        }

        res.json({ mensaje: 'Categoria eliminada' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    } 
});

module.exports = router;