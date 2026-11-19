-- =============================================================
-- 05. Permiso de lectura para la cuenta del servicio de Analysis Services
-- Necesario para que SSAS procese el modelo leyendo el DataMart.
-- =============================================================
USE [master];
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'NT Service\MSSQLServerOLAPService')
    CREATE LOGIN [NT Service\MSSQLServerOLAPService] FROM WINDOWS;
GO
USE [DataMart_Rentabilidad];
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'NT Service\MSSQLServerOLAPService')
    CREATE USER [NT Service\MSSQLServerOLAPService] FOR LOGIN [NT Service\MSSQLServerOLAPService];
ALTER ROLE [db_datareader] ADD MEMBER [NT Service\MSSQLServerOLAPService];
GO
