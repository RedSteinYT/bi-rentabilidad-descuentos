-- =============================================================
-- 02. Carga de Dim_Tiempo (2011-2014) y Dim_Banda_Descuento
-- Dim_Tiempo se genera con un ciclo, como en el laboratorio del curso
-- =============================================================
USE DataMart_Rentabilidad;
GO
SET LANGUAGE Spanish;

DECLARE @f DATE = '2011-01-01';
WHILE @f <= '2014-12-31'
BEGIN
    INSERT INTO dbo.Dim_Tiempo (TiempoKey, Fecha, Dia, Mes, NombreMes, Trimestre, Anio)
    VALUES (CONVERT(INT, CONVERT(CHAR(8), @f, 112)),
            @f, DAY(@f), MONTH(@f),
            UPPER(LEFT(DATENAME(MONTH, @f), 1)) + SUBSTRING(DATENAME(MONTH, @f), 2, 20),
            DATEPART(QUARTER, @f), YEAR(@f));
    SET @f = DATEADD(DAY, 1, @f);
END;

INSERT INTO dbo.Dim_Banda_Descuento (BandaKey, Banda, Orden) VALUES
(1, 'Sin descuento', 1),
(2, '1-20%',         2),
(3, '21-40%',        3),
(4, '41-60%',        4),
(5, 'Más de 60%',    5);

SELECT COUNT(*) AS Dias FROM dbo.Dim_Tiempo;          -- 1,461
SELECT * FROM dbo.Dim_Banda_Descuento;                 -- 5 filas
