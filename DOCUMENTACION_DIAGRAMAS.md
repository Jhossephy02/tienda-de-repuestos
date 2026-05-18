# DOCUMENTACIÓN TÉCNICA Y DIAGRAMAS - MOTOSTOCK PRO 2026

Este documento contiene los requerimientos funcionales y la estructura técnica del sistema **MotoStock Pro 2026** utilizando notación Mermaid para la generación automática de diagramas.

---

## 1. REQUERIMIENTOS FUNCIONALES

- **RF1: Gestión de Inventario**: Registro, edición y control de stock de repuestos con alertas de stock mínimo.
- **RF2: Punto de Venta (POS)**: Interfaz para ventas rápidas con carrito, búsqueda por DNI/RUC y generación de boletas.
- **RF3: Catálogo Virtual**: Tienda pública para clientes con filtros por categorías y marcas.
- **RF4: Control de Caja**: Apertura, cierre y registro de movimientos (ingresos/egresos).
- **RF5: Gestión de Usuarios**: Sistema de roles (Administrador y Cliente) con autenticación segura.
- **RF6: Gestión de Proveedores**: Directorio de proveedores originales, chinos y locales.

---

## 2. CASOS DE USO DEL SISTEMA (UML)

```mermaid
useCaseDiagram
    actor "Administrador" as Admin
    actor "Vendedor" as Vend
    actor "Cliente" as Cli

    package "MotoStock Pro 2026" {
        usecase "Control Total del Negocio" as UC1
        usecase "Gestión de Inventario" as UC2
        usecase "Reportes de Ventas" as UC3
        usecase "Apertura/Cierre de Caja" as UC4
        
        usecase "Proceso de Venta Mostrador" as UC5
        usecase "Buscar Cliente DNI" as UC6
        usecase "Emitir Boleta" as UC7
        
        usecase "Consultar Catálogo Virtual" as UC8
        usecase "Registro de Cuenta" as UC9
    }

    Admin --> UC1
    Admin --> UC2
    Admin --> UC3
    Admin --> UC4
    
    Vend --> UC5
    Vend --> UC6
    Vend --> UC7
    
    Cli --> UC8
    Cli --> UC9
```

---

## 3. DIAGRAMA DE ACTIVIDAD — FLUJO DE VENTA

```mermaid
activityDiagram
    start
    :Vendedor busca productos;
    :Agregar al Carrito;
    if (¿Cliente registrado?) then (Sí)
        :Autocompletar Datos;
    else (No)
        :Ingresar DNI/RUC Manual;
    endif
    :Ver Vista Previa Boleta;
    :Confirmar Pago;
    fork
        :Registrar Venta en BD;
        :Descontar Stock;
        :Generar Movimiento de Caja;
    end fork
    :Imprimir Ticket/Boleta;
    :Limpiar Carrito;
    stop
```

---

## 4. DIAGRAMA DE SECUENCIA

### 4.1 Registro de Venta en POS
```mermaid
sequenceDiagram
    participant V as Vendedor
    participant POS as Interfaz POS
    participant DB as Base de Datos
    participant PR as Impresora

    V->>POS: Agrega productos al carrito
    V->>POS: Ingresa DNI del cliente
    POS->>DB: Valida stock y cliente
    DB-->>POS: OK
    V->>POS: Clic en PAGAR
    POS->>DB: Registra Venta y Transacción
    DB-->>POS: Confirmación ID-Venta
    POS->>PR: Envía comando de impresión
    PR-->>V: Entrega Boleta Física
```

### 4.2 Recepción de Mercadería (Actualización de Stock)
```mermaid
sequenceDiagram
    participant A as Administrador
    participant C as Módulo Compras
    participant DB as Base de Datos

    A->>C: Ingresa Factura de Proveedor
    A->>C: Selecciona productos recibidos
    C->>DB: UPDATE productos SET stock = stock + cant
    C->>DB: INSERT INTO kardex (entrada)
    DB-->>A: Stock actualizado con éxito
```

---

## 5. DIAGRAMAS DE BASE DE DATOS

### 5.1 Diagrama Entidad-Relación (ER)
```mermaid
erDiagram
    CATEGORIAS ||--o{ PRODUCTOS : contiene
    MARCAS ||--o{ PRODUCTOS : fabrica
    PROVEEDORES ||--o{ COMPRAS : suministra
    PRODUCTOS ||--o{ DETALLE_VENTA : se_vende_en
    VENTAS ||--o{ DETALLE_VENTA : tiene
    CLIENTES ||--o{ VENTAS : realiza
    USUARIOS ||--o{ VENTAS : procesa
```

### 5.2 Diagrama Físico de Base de Datos
```mermaid
classDiagram
    class PRODUCTOS {
        int id PK
        string codigo
        string nombre
        int categoria_id FK
        int marca_id FK
        decimal precio_venta
        int stock
    }
    class VENTAS {
        int id PK
        timestamp fecha
        int cliente_id FK
        int usuario_id FK
        decimal total
    }
    class CAJA {
        int id PK
        timestamp apertura
        timestamp cierre
        decimal monto_inicial
        decimal saldo_final
    }
    class CLIENTES {
        int id PK
        string dni_ruc
        string nombre
        string telefono
    }
```
