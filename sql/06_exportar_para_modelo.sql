-- =============================================================
-- 06. Consulta plana para el modelo predictivo (exportar a CSV)
-- SSMS: clic derecho en DataMart_Rentabilidad > Tareas > Exportar datos
-- Destino: archivo plano, página de códigos 65001 (UTF-8), calificador "
-- Los CAST a NVARCHAR evitan el error de página de códigos 1252 con UTF-8.
-- =============================================================
USE DataMart_Rentabilidad;
SELECT
    f.VentaKey,
    CAST(f.CodigoPedido AS NVARCHAR(100))   AS CodigoPedido,
    t.Fecha, t.Anio, t.Trimestre, t.Mes,
    CAST(p.Categoria AS NVARCHAR(100))      AS Categoria,
    CAST(p.Subcategoria AS NVARCHAR(100))   AS Subcategoria,
    CAST(p.NombreProducto AS NVARCHAR(255)) AS NombreProducto,
    CAST(g.Mercado AS NVARCHAR(100))        AS Mercado,
    CAST(g.Region AS NVARCHAR(100))         AS Region,
    CAST(g.Pais AS NVARCHAR(100))           AS Pais,
    CAST(c.Segmento AS NVARCHAR(100))       AS Segmento,
    CAST(e.ModoEnvio AS NVARCHAR(100))      AS ModoEnvio,
    CAST(e.Prioridad AS NVARCHAR(100))      AS Prioridad,
    CAST(b.Banda AS NVARCHAR(50))           AS Banda,
    f.Cantidad, f.Ventas, f.Descuento, f.CostoEnvio, f.Ganancia,
    CASE WHEN f.Ganancia < 0 THEN 1 ELSE 0 END AS EsPerdida
FROM dbo.Fact_Ventas f
JOIN dbo.Dim_Tiempo           t ON f.TiempoKey    = t.TiempoKey
JOIN dbo.Dim_Producto         p ON f.ProductoKey  = p.ProductoKey
JOIN dbo.Dim_Geografia        g ON f.GeografiaKey = g.GeografiaKey
JOIN dbo.Dim_Cliente          c ON f.ClienteKey   = c.ClienteKey
JOIN dbo.Dim_Envio            e ON f.EnvioKey     = e.EnvioKey
JOIN dbo.Dim_Banda_Descuento  b ON f.BandaKey     = b.BandaKey;   -- 51,290 filas
