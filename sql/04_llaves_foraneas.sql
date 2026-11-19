-- =============================================================
-- 04. Llaves foráneas de Fact_Ventas hacia sus dimensiones
-- =============================================================
USE DataMart_Rentabilidad;
GO
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Tiempo    FOREIGN KEY (TiempoKey)    REFERENCES dbo.Dim_Tiempo(TiempoKey);
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Producto  FOREIGN KEY (ProductoKey)  REFERENCES dbo.Dim_Producto(ProductoKey);
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Cliente   FOREIGN KEY (ClienteKey)   REFERENCES dbo.Dim_Cliente(ClienteKey);
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Geografia FOREIGN KEY (GeografiaKey) REFERENCES dbo.Dim_Geografia(GeografiaKey);
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Envio     FOREIGN KEY (EnvioKey)     REFERENCES dbo.Dim_Envio(EnvioKey);
ALTER TABLE dbo.Fact_Ventas ADD CONSTRAINT FK_Fact_Banda     FOREIGN KEY (BandaKey)     REFERENCES dbo.Dim_Banda_Descuento(BandaKey);
GO
-- Respaldo
BACKUP DATABASE DataMart_Rentabilidad
TO DISK = 'D:\Backups\DataMart_Rentabilidad.bak'
WITH INIT, NAME = 'DataMart_Rentabilidad listo para SSAS';
