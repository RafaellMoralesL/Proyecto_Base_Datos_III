const express = require('express');
const router = express.Router();
const { colecciones } = require('../db/mongodb');


// Transacciones Historicas

router.get('/transacciones', async (req, res) => {
    try {
        const limite = parseInt(req.query.limite) || 50;

        const transacciones = await colecciones.transacciones
            .find({})
            .sort({ fecha: -1 })
            .limit(limite)
            .toArray();
        res.json({ total: transacciones.length, transacciones });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Historial de un producto

router.get('/historial/:codigo', async (req, res) => {
    try {
        const historial = await colecciones.historial
            .find({ codigo_serie: req.params.codigo })
            .sort({ fecha: -1 })
            .toArray();

        res.json({ 
            codigo: req.params.codigo,
            total: historial.length,
            historial
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Listar comentarios

router.get('/comentarios', async (req, res) => {
    try {
        const operador = req.query;

        let consulta = {};
        if (operador) {
            consulta.operador = operador;
        }

        const comentarios = await colecciones.comentarios
            .find(consulta)
            .sort({ fecha: -1 })
            .toArray();

        res.json({ total: comentarios.length, comentarios });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Agregar comentario

router.post('/comentarios', async (req, res) => {
    try {
        const { id_producto, codigo_serie, operador, comentario, prioridad } =  req.body;

        if (!comentario || !operador) {
            return res.status(400).json({ error: 'Comentario y operador son requeridos' });
        }

        const result = await colecciones.comentarios.insertOne({
            id_producto: id_producto || null,
            codigo_serie: codigo_serie || null,
            operador: operador,
            comentario: comentario,
            prioridad: prioridad || 'baja',
            fecha: new Date()
        });

        res.status(201).json({ message: 'Comentario agregado',
            id: result.insertedId
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Eliminar comentario

router.delete('/comentarios/:id', async (req, res) => {
    try {
        const { ObjectId } = require('mongodb');
        
        const result = await colecciones.comentarios.deleteOne({
            _id: new ObjectId(req.params.id)
        });

        if (result.deletedCount === 0) {
            return res.status(404).json({ error: 'Comentario no encontrado' });
        }

        res.json({ message: 'Comentario eliminado' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Resumen de ventas por producto - MongoDB

router.get('/ventas-resumen', async (req, res) => {
    try {
        const resumen = await colecciones.transacciones.aggregate([
            {
                $group: {
                    _id: '$codigo_serie',
                    total_vendido: { $sum: '$cantidad' },
                    valor_total: { $sum: '$valor_total' },
                    num_ventas: { $sum: 1 }
            }
        },
        { $sort: { valor_total: -1 } }
        ]).toArray();

        res.json({ resumen });
    } catch (error) {
        res.status(500).json({ error: error.message });
    } 
});

module.exports = router;