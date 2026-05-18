const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
    user: process.env.DB_USER || 'postgres',
    host: process.env.DB_HOST || 'localhost',
    database: process.env.DB_NAME || 'motostock_db',
    password: process.env.DB_PASSWORD || '123456',
    port: process.env.DB_PORT || 5432,
    connectionTimeoutMillis: 2000, // Timeout rápido para detectar si no hay DB
});

let dbAvailable = true;

pool.on('error', (err) => {
    console.error('❌ Error inesperado en el pool de base de datos:', err.message);
    dbAvailable = false;
});

pool.on('connect', () => {
    console.log('✅ Conectado a la base de datos PostgreSQL');
    dbAvailable = true;
});

module.exports = {
    query: async (text, params) => {
        try {
            return await pool.query(text, params);
        } catch (err) {
            dbAvailable = false;
            throw err;
        }
    },
    isAvailable: () => dbAvailable
};
