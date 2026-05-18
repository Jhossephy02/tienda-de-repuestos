const express = require('express');
const router = express.Router();
const db = require('../config/db');

// Registrar una venta completa
router.post('/', async (req, res) => {
    const { usuario_id, cliente_id, total, tipo_comprobante, productos } = req.body;
    
    try {
        // Iniciar transacción
        await db.query('BEGIN');

        // 1. Crear la cabecera de la venta
        const ventaResult = await db.query(
            'INSERT INTO ventas (usuario_id, cliente_id, total, tipo_comprobante) VALUES ($1, $2, $3, $4) RETURNING id',
            [usuario_id, cliente_id, total, tipo_comprobante]
        );
        const ventaId = ventaResult.rows[0].id;

        // 2. Insertar detalles y actualizar stock
        for (const prod of productos) {
            await db.query(
                'INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES ($1, $2, $3, $4, $5)',
                [ventaId, prod.id, prod.cantidad, prod.precio, prod.cantidad * prod.precio]
            );

            // Actualizar stock del producto
            await db.query(
                'UPDATE productos SET stock = stock - $1 WHERE id = $2',
                [prod.cantidad, prod.id]
            );
        }

        await db.query('COMMIT');
        res.status(201).json({ message: 'Venta registrada con éxito', ventaId });
    } catch (err) {
        await db.query('ROLLBACK');
        res.status(500).json({ error: 'Error al procesar la venta', details: err.message });
    }
});

module.exports = router;
