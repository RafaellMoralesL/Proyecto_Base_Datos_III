const express = require('express');
const router = express.Router();
const { pool } = require('../db/mysql');
const { colecciones } = require('../db/mongodb');

//Mostrar todas las ventas

router.get('/', async (req, res) => {
    try {
        const [ventas] = await pool.query(`
            SELECT v.*, e.nombre_empleado, a.nombre_almacen
            FROM venta v
            JOIN empleado e ON v.id_empleado = e.id_empleado
            JOIN almacen a ON v.id_almacen = a.id_almacen
            ORDER BY v.fecha DESC`
        );
        // Detalles de las ventas
        for (let venta of ventas) {
            const [detalles] = await pool.query(`
                SELECT d.*, p.nombre, p.codigo_serie
                FROM detalle_venta d
                JOIN producto p ON d.id_producto = p.id_producto
                WHERE d.id_venta = ?`,
            [venta.id_venta]);
            venta.detalles = detalles;
        }

        res.json({ total: ventas.length, ventas });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Ver venta en especifico

router.get('/:id', async (req, res) => {
    try {
        const [ventas] = await pool.query(
            `SELECT v.*, e.nombre_empleado, a.nombre_almacen
            FROM venta v
            JOIN empleado e ON v.id_empleado = e.id_empleado
            JOIN almacen a ON v.id_almacen = a.id_almacen
            WHERE v.id_venta = ?`,
            [req.params.id]);

            if (ventas.length === 0) {
                return res.status(404).json({ error: 'Venta no encontrada' });
            }

            const venta = ventas[0];

            const [detalles] = await pool.query(
                `SELECT d.*, p.nombre, p.codigo_serie
                FROM detalle_venta d
                JOIN producto p ON d.id_producto = p.id_producto
                WHERE d.id_venta = ?`,
                [venta.id_venta]);
            
            venta.detalles = detalles;

            res.json(venta);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

// Crear una venta con Post

router.post('/', async (req, res) => {
    try {
        const { id_empleado, id_almacen, productos } = req.body;

        if (!id_empleado || !id_almacen || !productos || productos.length === 0) {
            return res.status(400).json({
                error: 'id_empleado, id_almacen y productos son requeridos'
            });
        }

        // Validar que existe el empleado y el almacen
        const [emp] = await pool.query(
            'SELECT id_empleado FROM empleado WHERE id_empleado = ?',
            [id_empleado]
        );
        if (emp.length === 0) {
            return res.status(400).json({ error: 'Empleado no existe' });
        }

            const [alm] = await pool.query(
            'SELECT id_almacen FROM almacen WHERE id_almacen = ?',
            [id_almacen]
        );
        if (alm.length === 0) {
            return res.status(400).json({ error: 'Almacen no existe' });
    }

    let total = 0;
    const productosValidados = [];

    for (let item of productos) {
        const [producto] = await pool.query(
            'SELECT id_producto, nombre, precio, codigo_serie FROM producto WHERE id_producto = ?',
            [item.id]
        );

        if (producto.length === 0) {
            return res.status(400).json({ error: `Producto ${item.id} no existe` });
        }

        const [stockR] = await pool.query(
            'SELECT stock FROM inventario WHERE id_producto = ? AND id_almacen = ?',
            [item.id, id_almacen]
        );

        const stock = stockR.length > 0 ? stockR[0].stock : 0;
        
        if (stock < item.cantidad) {
            return res.status(400).json({
                error: `Stock insuficiente para ${producto[0].nombre}`,
                disponible: stock,
                solicitado: item.cantidad
            });
        }

        productosValidados.push({
            ...producto[0],
            cantidad: item.cantidad,
            subtotal: producto[0].precio * item.cantidad
        });

        total += producto[0].precio * item.cantidad;
    }

    // Crear Nueva venta
    const [result] = await pool.query(
        'INSERT INTO venta (id_empleado, id_almacen, total, estado) VALUES (?, ?, ?, ?',
        [id_empleado, id_almacen, total, 'compleatada']
    );

    const id_venta = result.insertId;

    for (let item of productosValidados) {
        await pool.query(
            'INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, id_almacen) VALUES (?, ?, ?, ?, ?)',
            [id_venta, item.id_producto, item.cantidad, item.precio, id_almacen]
        );

        await pool.query(
            'UPDATE inventario SET stock = stock - ? WHERE id_producto = ? AND id_almacent = ?',
            [item.cantidad, item.id_producto, id_almacen]
        );

        await colecciones.transacciones.insertOnce({
            codigo_producto: item.codigo_serie,
            nombre_producto: item.nombre,
            cantidad: item.cantidad,
            fecha: new Date(),
            valor_total: item.subtotal,
            id_venta,
            id_almacen,
            tipo_operacion: 'vneta'
        });
    }

    res.status(201).json({
        mensaje: 'Venta creada',
        id_venta,
        total,
        productos : productosValidados
    });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Cancelar una venta

router.put('/:id/cancelar', async (req, res) => {
    try {
        const [venta] = await pool.query(
            'SELECT * FROM venta WHERE id_venta = ?',
            [req.params.id]
        );

        if (venta.length === 0) {
            return resizeTo.status(400).json({ error: 'Venta no encontrada' });
        }

        if (venta[0].estado === 'cancelada') {
            return res.status(400).json({ error: 'La venta ya esta cancelada' });
        }

        await pool.query(
            'UPDATE venta SET estado = ? WHERE id_venta = ?',
            ['cancelada', req.params.id]
        );

        await pool.query(
            `UPDATE inventario i
            INNER JOIN (
                SELECT id_producto, SUM(cantidad) AS cant
                FROM detalle_venta WHERE id_venta = ? GROUP BY  id_producto)
                d ON i.id_producto = d.id_producto
                SET i.stock = i.stock + d.cant`,
                [req.params.id]);

            res.json({ mensaje: 'Venta cancelada', id_venta: req.parans.id });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
});

module.exports = router;