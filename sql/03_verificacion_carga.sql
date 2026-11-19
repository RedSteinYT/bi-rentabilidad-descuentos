-- =============================================================
-- 03. Verificación de la carga (después de ejecutar los paquetes SSIS)
-- =============================================================
USE DataMart_Rentabilidad;
SELECT 'Dim_Producto' t, COUNT(*) n FROM dbo.Dim_Producto  UNION ALL   -- 10,768
SELECT 'Dim_Cliente',    COUNT(*)   FROM dbo.Dim_Cliente   UNION ALL   -- 1,590
SELECT 'Dim_Geografia',  COUNT(*)   FROM dbo.Dim_Geografia UNION ALL   -- 3,847
SELECT 'Dim_Envio',      COUNT(*)   FROM dbo.Dim_Envio     UNION ALL   -- 16
SELECT 'Fact_Ventas',    COUNT(*)   FROM dbo.Fact_Ventas;              -- 51,290

SELECT COUNT(DISTINCT CodigoPedido) AS Pedidos,                         -- 25,035
       SUM(Ventas)   AS Ventas,                                         -- 12,642,500.86
       SUM(Ganancia) AS Ganancia,                                       -- 1,467,456.70
       SUM(CASE WHEN Ganancia < 0 THEN 1.0 ELSE 0 END) / COUNT(*) AS PctPerdida  -- 24.46 %
FROM dbo.Fact_Ventas;

SELECT SUM(Ganancia) AS GananciaDescuentoAlto                           -- -814,681.77
FROM dbo.Fact_Ventas WHERE Descuento > 0.20;
