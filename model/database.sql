-- MotoStock Pro 2026 - Database Schema Completo
-- Version: 1.1.0

-- 1. Estructura Base de Organización
CREATE TABLE IF NOT EXISTS categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS marcas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- 2. Gestión de Productos (Almacén)
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    codigo_fabrica VARCHAR(50) UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    categoria_id INTEGER REFERENCES categorias(id),
    marca_id INTEGER REFERENCES marcas(id),
    precio_compra DECIMAL(10, 2) DEFAULT 0.00,
    precio_venta DECIMAL(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    stock_minimo INTEGER DEFAULT 5,
    ubicacion_almacen VARCHAR(100), -- Estante/Pasillo
    imagen_url TEXT,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Actores del Sistema
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    documento VARCHAR(20) UNIQUE, -- DNI o RUC
    nombre VARCHAR(200) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    puntos_lealtad INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS proveedores (
    id SERIAL PRIMARY KEY,
    ruc VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    contacto_nombre VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    nombre_completo VARCHAR(200),
    rol VARCHAR(20) CHECK (rol IN ('admin', 'vendedor', 'cliente')),
    ultimo_login TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- 4. Gestión de Ventas y Facturación
CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id),
    cliente_id INTEGER REFERENCES clientes(id),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    tipo_comprobante VARCHAR(20) DEFAULT 'Ticket', -- Boleta, Factura, Ticket
    serie_comprobante VARCHAR(10),
    numero_comprobante VARCHAR(20),
    metodo_pago VARCHAR(50), -- Efectivo, Yape, Plin, Tarjeta
    estado_pago VARCHAR(20) DEFAULT 'Pagado' -- Pagado, Pendiente, Anulado
);

CREATE TABLE IF NOT EXISTS detalle_ventas (
    id SERIAL PRIMARY KEY,
    venta_id INTEGER REFERENCES ventas(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);

-- 5. Gestión de Compras (Entrada de Mercadería)
CREATE TABLE IF NOT EXISTS compras (
    id SERIAL PRIMARY KEY,
    proveedor_id INTEGER REFERENCES proveedores(id),
    usuario_id INTEGER REFERENCES usuarios(id),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    numero_factura_proveedor VARCHAR(50),
    estado VARCHAR(20) DEFAULT 'Recibido'
);

CREATE TABLE IF NOT EXISTS detalle_compras (
    id SERIAL PRIMARY KEY,
    compra_id INTEGER REFERENCES compras(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL,
    costo_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);

-- 6. Finanzas y Caja
CREATE TABLE IF NOT EXISTS caja (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id),
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre TIMESTAMP,
    monto_inicial DECIMAL(10, 2) NOT NULL,
    monto_final DECIMAL(10, 2),
    total_ventas_efectivo DECIMAL(10, 2) DEFAULT 0.00,
    total_ventas_digital DECIMAL(10, 2) DEFAULT 0.00,
    estado VARCHAR(20) DEFAULT 'Abierta' -- Abierta, Cerrada
);

CREATE TABLE IF NOT EXISTS movimientos_caja (
    id SERIAL PRIMARY KEY,
    caja_id INTEGER REFERENCES caja(id),
    tipo VARCHAR(10) CHECK (tipo IN ('ingreso', 'egreso')),
    monto DECIMAL(10, 2) NOT NULL,
    descripcion TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Auditoría de Stock (Kardex)
CREATE TABLE IF NOT EXISTS kardex (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER REFERENCES productos(id),
    tipo_movimiento VARCHAR(20), -- Venta, Compra, Devolución, Ajuste
    cantidad INTEGER NOT NULL,
    stock_anterior INTEGER NOT NULL,
    stock_nuevo INTEGER NOT NULL,
    referencia_id INTEGER, -- ID de venta o compra
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
