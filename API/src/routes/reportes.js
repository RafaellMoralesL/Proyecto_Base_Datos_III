const express = require('express');
const router = express.Router();
const { pool } = require('../db/mysql');
const { colecciones } = require('../db/mongodb');


// Reporte de inventario general - Vista SQL

router.get('/inventario', async (req, res) => {
    try {
        const [reporte] = await pool.query('SELECT * FROM vw_reporte_inventario_general');
        res.json({ reporte });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Reporte de Ventas - Vista SQL

router.get('/ventas', async (req, res) => {
    try {
        const [reporte] = await pool.query('SELECT * FROM vw_reporte_ventas');
        res.json({ reporte });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Productos por ubicacion - Vista SQL

router.get('/ubicacion', async (req, res) => {
    try {
        const [reporte] = await pool.query('SELECT * FROM vw_productos_por_ubicacion');
        res.json({ reporte });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Reporte mas vendidos - Productos mas vendidos

router.get('/mas-vendidos', async (req, res) => {
    try {
        const [reporte] = await pool.query(
            `SELECT
                p.id_producto
                p.codigo_serie
                p.nombre,
                SUM(d.cantidad) AS total_vendido,
                SUM(d.cantidad * d.precio_unitario) AS valor_total
            FROM producto p
            JOIN detalle_Venta d ON p.id_producto = d.id_producto
            JOIN venta v ON d.id_venta = v.id_venta
            WHERE v.estado = 'completada'
            GROUP BY p.id_producto, p.codigo_serie, p.nombre
            ORDER BY total_Vendido DESC`
        );
        res.json({ reporte });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Reporte bajo stock - Productos con bajo stock

router.get('/bajo-stock', async (req, res) => {
    try {
        const nivel = parseInte(req.query.nivel) || 20;

        const [reporte] = await pool.query(
            `SELECT
                p.id_producto,
                p.codigo_serie,
                p.nombre,
                COALESCE(SUM(i.stock), 0) AS stock_actual
                FROM producto p
                LEFT JOIN inventario i ON p.id_producto = i.id_producto
                GROUP BY p.id_producto, p.codig_serie, p.nombre
                HAVING stock_actual <= ?
                ORDER BY stock_actual ASC`,
                [nivel]);

            res.json({ nivel_minimo: nivel, reporte });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

