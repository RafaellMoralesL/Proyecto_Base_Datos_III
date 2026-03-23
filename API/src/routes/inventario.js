const express = require('express');
const router = express.Router();
const { pool } = require('../db/mysql');


// Endpoint para ver el stock
router.get('/', async (req, res) => {
    try {
        const [inventario] = await pool.query(`
            SELECT
                p.id_producto,
                p.codigo_serie,
                p.nombre,
                p.precio,
                COALESCE(SUM(i.stock), 0) AS stock_total,
                COALESCE(SUM(i.stock), 0) * p.precio AS valor_total
            FROM producto p
            LEFT JOIN inventario i ON p.id_producto = i.id_producto
            GROUP BY p.id_producto, p.codigo_serie, p.nombre, p.precio
            ORDER BY p.nombre`
        );

        res.json({ total: inventario.length, inventario});
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// endpoint - ver stock de almacen especifico
router.get('/:almacenId', async (req, res) => {
    try {
        // se piden los parametros para definir id almacen
        const [almacen] = await pool.query(
            'SELECT * FROM almacen WHERE id_almacen = ?',
            [req.params.almacenId]
        );

        if (almacen.length === 0) {
            return res.status(404).json({ error: 'Almacen no encontrado' });
        }

        const [inventario] = await pool.query(`
            SELECT p.nombre, i.stock, i.ubicacion_interna
            FROM inventario i
            JOIN producto p ON i.id_producto = p.id_producto
            WHERE i.id_almacen = ?
            ORDER BY i.ubicacion_interna`, 
            [req.params.almacenId]);

        res.json({
            almacen: almacen[0],
            inventario
        });
    }   catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Actualizar/Update dentro de almacen para actualizar stock.
router.put('/:idProducto/:almacenId', async (req, res) => {
    try {
        const { stock, ubicacion_interna } = req.body;

        const [existe] = await pool.query(
            'SELECT * FROM inventario WHERE id_producto = ? AND id_almacen = ?',
            [req.params.idProducto, req.params.almacenId]
        );

        if (existe.length === 0) {
            return res.status(404).json({ erro: 'Registro de inventario no encontrado' });
        }

        const updates = [];
        const valores = [];

        if (stock !== undefined) {
            updates.push('stock = ?');
            valores.push(stock);
        }
        if (ubicacion_interna !== undefined) {
            updates.push('ubicacion_interna = ?');
            valores.push(ubicacion_interna);
        }

        //Se piden como requerimiento los 2 parametros para el update
        if (updates.length > 0) {
            valores.push(req.params.idProducto, req.params.almacenId);
            await pool.query(
                `UPDATE inventario SET ${updates.join(', ')} WHERE id_producto = ? AND id_almacen = ?`,
                valores
            );
        }

        res.json({ mensaje: 'Stock actualizado' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;