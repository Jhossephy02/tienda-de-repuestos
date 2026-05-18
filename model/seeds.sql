-- Semillas de prueba para MotoStock Pro 2026
-- 40+ Productos Reales

INSERT INTO categorias (nombre) VALUES 
('Motor'), ('Frenos'), ('Transmisión'), ('Suspensión'), ('Eléctrico'), ('Lubricantes'), ('Llantas'), ('Accesorios');

-- Insertar Marcas
INSERT INTO marcas (nombre) VALUES 
('Honda'), ('Yamaha'), ('Bajaj'), ('Suzuki'), ('TVS'), ('Castrol'), ('Motul'), ('NGK'), ('Pirelli'), ('LS2');

-- Insertar Productos (Ampliación)
INSERT INTO productos (codigo, nombre, categoria_id, marca_id, precio_costo, precio_venta, stock, stock_minimo, imagen_url) VALUES
-- Motor
('MOT-001', 'Pistón Estándar Honda CB190R', 1, 1, 120.00, 180.00, 15, 5, 'https://m.media-amazon.com/images/I/51V66Z4C6RL._AC_SL1000_.jpg'),
('MOT-002', 'Válvulas de Admisión Yamaha FZ25', 1, 2, 45.00, 75.00, 20, 4, 'https://m.media-amazon.com/images/I/61K8P1XN1DL._AC_SL1500_.jpg'),
('MOT-003', 'Empaque de Culata Pulsar NS200', 1, 3, 15.00, 35.00, 40, 10, 'https://m.media-amazon.com/images/I/71Nn0O1WpDL._AC_SL1500_.jpg'),

-- Frenos
('FRE-001', 'Pastillas de Freno Delanteras NS200', 2, 3, 25.00, 45.00, 50, 10, 'https://m.media-amazon.com/images/I/71H5zN0vP9L._AC_SL1500_.jpg'),
('FRE-002', 'Disco de Freno Delantero Yamaha R3', 2, 2, 85.00, 150.00, 12, 3, 'https://m.media-amazon.com/images/I/71Y+S0D0uYL._AC_SL1500_.jpg'),
('FRE-003', 'Zapatas de Freno Trasero Torito Bajaj', 2, 3, 18.00, 32.00, 60, 15, 'https://m.media-amazon.com/images/I/61Z6v+I+KGL._AC_SL1200_.jpg'),

-- Transmisión
('TRA-001', 'Kit de Arrastre Honda CB190R', 3, 1, 110.00, 180.00, 15, 5, 'https://m.media-amazon.com/images/I/81hU1-0mOLL._AC_SL1500_.jpg'),
('TRA-002', 'Cadena de Tracción 428H-132L', 3, 3, 45.00, 75.00, 25, 8, 'https://m.media-amazon.com/images/I/71hO0K0vP9L._AC_SL1500_.jpg'),

-- Eléctrico
('ELE-001', 'Batería Gel 12V 7Ah Bosch', 5, 8, 85.00, 145.00, 20, 5, 'https://m.media-amazon.com/images/I/61Y0+S0D0uL._AC_SL1500_.jpg'),
('ELE-002', 'Foco LED H4 Alta Potencia', 5, 10, 25.00, 55.00, 40, 10, 'https://m.media-amazon.com/images/I/61I0+S0D0uL._AC_SL1500_.jpg'),
('ELE-003', 'Bujía Iridium NGK CPR8EAIX-9', 5, 8, 30.00, 55.00, 100, 20, 'https://m.media-amazon.com/images/I/61mD+I2U0sL._AC_SL1000_.jpg'),

-- Suspensión
('SUS-001', 'Amortiguador Trasero Pulsar 180', 4, 3, 120.00, 210.00, 10, 3, 'https://m.media-amazon.com/images/I/61W0+S0D0uL._AC_SL1500_.jpg'),
('SUS-002', 'Retenes de Telescópica Yamaha FZ', 4, 2, 15.00, 35.00, 30, 8, 'https://m.media-amazon.com/images/I/51I0+S0D0uL._AC_SL1000_.jpg'),

-- Accesorios
('ACC-001', 'Casco Integral LS2 Rapid', 8, 10, 180.00, 280.00, 8, 2, 'https://m.media-amazon.com/images/I/61S0+S0D0uL._AC_SL1500_.jpg'),
('ACC-002', 'Guantes de Protección Fox Racing', 8, 10, 35.00, 65.00, 25, 5, 'https://m.media-amazon.com/images/I/71P0+S0D0uL._AC_SL1500_.jpg'),
('ACC-003', 'Espejos Deportivos Universales', 8, 1, 18.00, 45.00, 20, 5, 'https://m.media-amazon.com/images/I/61Q0+S0D0uL._AC_SL1500_.jpg'),

-- Lubricantes
('LUB-001', 'Aceite Castrol Power1 10W40 4T', 6, 6, 22.00, 38.00, 100, 20, 'https://m.media-amazon.com/images/I/61Y0+S0D0uL._AC_SL1500_.jpg'),
('LUB-002', 'Aceite Motul 7100 20W50 Sintético', 6, 7, 45.00, 75.00, 40, 10, 'https://m.media-amazon.com/images/I/61X0+S0D0uL._AC_SL1500_.jpg');

-- Insertar Proveedores Variados (Originales, Chinos y Personas Naturales)
INSERT INTO proveedores (nombre, ruc_dni, direccion, telefono, email) VALUES
-- Marcas Originales / Grandes Distribuidores
('Honda del Perú S.A.', '20100123456', 'Av. Javier Prado Este 1234, Lima', '01 4567890', 'ventas@honda.com.pe'),
('Yamaha Motor Selva', '20300456789', 'Jr. Próspero 456, Iquitos', '065 234567', 'repuestos@yamaha.com.pe'),
('Bajaj Autopartes SAC', '20500789012', 'Av. Industrial 789, Callao', '01 3456789', 'contacto@bajaj.pe'),

-- Proveedores de Marcas Chinas (Alternativos)
('China Parts Importaciones', '20600112233', 'Av. Abancay 1020, Lima', '01 5671234', 'import@chinaparts.com'),
('Todo Chinas Motos EIRL', '20400556677', 'Jr. Huánuco 345, Pucallpa', '061 456789', 'ventas@todochinas.com'),
('Asia Motor Repuestos', '20555666777', 'Av. Grau 890, Lima', '01 4445556', 'pedidos@asiamotor.pe'),

-- Personas Naturales (Proveedores locales o técnicos)
('Juan Carlos Rimachi', '10123456789', 'Calle Los Jazmines 123, Pucallpa', '987654321', 'juan.rimachi@gmail.com'),
('Maria Esperanza Lopez', '10445566778', 'Av. Centenario Km 4.5, Pucallpa', '944556677', 'marialopez@hotmail.com'),
('Ricardo "El Tigre" Mendoza', '10778899001', 'Jr. Tarapacá 678, Pucallpa', '911223344', 'tigremendoza@gmail.com');
