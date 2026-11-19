-- =============================================================
-- 01. Creación del DataMart_Rentabilidad (modelo estrella)
-- Motor: SQL Server 2025 · Ejecutar en SSMS
-- Las llaves foráneas se crean al final (05_llaves_foraneas.sql),
-- después de verificar la carga del ETL.
-- =============================================================
CREATE DATABASE DataMart_Rentabilidad;
GO
ALTER DATABASE DataMart_Rentabilidad SET RECOVERY SIMPLE;
GO
USE DataMart_Rentabilidad;
GO

-- Dimensión de tiempo: llave inteligente AAAAMMDD
CREATE TABLE dbo.Dim_Tiempo (
    TiempoKey   INT           NOT NULL PRIMARY KEY,   -- p. ej. 20140131
    Fecha       DATE          NOT NULL UNIQUE,
    Dia         INT           NOT NULL,
    Mes         INT           NOT NULL,
    NombreMes   NVARCHAR(20)  NOT NULL,
    Trimestre   INT           NOT NULL,
    Anio        INT           NOT NULL
);

CREATE TABLE dbo.Dim_Producto (
    ProductoKey     INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID      INT           NOT NULL,           -- id_producto del origen
    CodigoProducto  NVARCHAR(255) NOT NULL,
    NombreProducto  NVARCHAR(255) NOT NULL,
    Categoria       NVARCHAR(255) NOT NULL,
    Subcategoria    NVARCHAR(255) NOT NULL
);

CREATE TABLE dbo.Dim_Cliente (
    ClienteKey     INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID      INT           NOT NULL,            -- id_cliente del origen
    CodigoCliente  NVARCHAR(255) NOT NULL,
    NombreCliente  NVARCHAR(255) NOT NULL,
    Segmento       NVARCHAR(255) NOT NULL
);

CREATE TABLE dbo.Dim_Geografia (
    GeografiaKey  INT IDENTITY(1,1) PRIMARY KEY,
    UbicacionID   INT           NOT NULL,             -- id_ubicacion del origen
    Ciudad        NVARCHAR(255) NOT NULL,
    Estado        NVARCHAR(255) NOT NULL,
    Pais          NVARCHAR(255) NOT NULL,
    Region        NVARCHAR(255) NOT NULL,
    Mercado       NVARCHAR(255) NOT NULL
);

CREATE TABLE dbo.Dim_Envio (
    EnvioKey     INT IDENTITY(1,1) PRIMARY KEY,
    ModoEnvioID  INT           NOT NULL,
    PrioridadID  INT           NOT NULL,
    ModoEnvio    NVARCHAR(255) NOT NULL,
    Prioridad    NVARCHAR(255) NOT NULL
);

CREATE TABLE dbo.Dim_Banda_Descuento (
    BandaKey  TINYINT     NOT NULL PRIMARY KEY,       -- 1 a 5, la calcula el ETL
    Banda     VARCHAR(20) NOT NULL,
    Orden     INT         NOT NULL                    -- para ordenar las bandas en SSAS
);

-- Tabla de hechos: una fila por línea de detalle de pedido
CREATE TABLE dbo.Fact_Ventas (
    VentaKey         BIGINT IDENTITY(1,1) PRIMARY KEY,
    TiempoKey        INT            NOT NULL,
    ProductoKey      INT            NOT NULL,
    ClienteKey       INT            NOT NULL,
    GeografiaKey     INT            NOT NULL,
    EnvioKey         INT            NOT NULL,
    BandaKey         TINYINT        NOT NULL,
    DetallePedidoID  INT            NOT NULL,         -- id_detalle del origen
    CodigoPedido     NVARCHAR(255)  NOT NULL,         -- dimensión degenerada
    Ventas           DECIMAL(18,4)  NOT NULL,
    Cantidad         INT            NOT NULL,
    Descuento        DECIMAL(5,4)   NOT NULL,         -- fracción: 0.2 = 20 %
    Ganancia         DECIMAL(18,4)  NOT NULL,
    CostoEnvio       DECIMAL(18,4)  NOT NULL
);
GO
