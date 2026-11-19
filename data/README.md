# Datos

El proyecto usa el dataset público **Global Superstore** de Kaggle: https://www.kaggle.com/datasets/shekpaul/global-superstore

A partir de él se creó la base relacional `Superstore_Normalizado` (15 tablas), que es el origen del ETL. El CSV del modelo predictivo se genera desde el DataMart con [`../sql/06_exportar_para_modelo.sql`](../sql/06_exportar_para_modelo.sql); no se incluye en el repositorio para respetar la licencia del dataset original.
