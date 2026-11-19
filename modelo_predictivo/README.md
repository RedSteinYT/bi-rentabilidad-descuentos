# Modelo predictivo de riesgo de pérdida

**Pregunta:** ¿qué líneas de venta terminan en pérdida y qué combinación de descuento, producto y mercado lo anticipa?

- **Datos:** consulta plana del DataMart ([`../sql/06_exportar_para_modelo.sql`](../sql/06_exportar_para_modelo.sql)), 51,290 líneas.
- **Validación honesta por tiempo:** entrenamiento con 2011–2013 y prueba con 2014, un año que el modelo no usó para aprender. La ganancia nunca entra como dato de entrada.
- **Modelos:** regla base (descuento > 20 %), árbol de decisión, regresión logística, gradient boosting monótono en el descuento y un modelo ampliado con precio de lista y margen base del producto; además, una regresión del margen de cada venta.

| Modelo (prueba 2014) | Exactitud | Recall | AUC |
|---|---:|---:|---:|
| Regla: descuento > 20 % | 93.2 % | 81.8 % | 0.971 |
| Gradient boosting (3 variables) | 93.2 % | 81.1 % | 0.980 |
| **Gradient boosting ampliado** | **95.1 %** | **88.9 %** | **0.990** |

El modelo de margen estimó la ganancia de 2014 en USD 499,944 frente a USD 504,166 reales (−0.8 %). Aplicado al pronóstico de ventas 2015 de Excel, proyecta USD 592 mil sin política y USD 1.01 M con el tope de 20 %, a menos de 1.3 % de la estimación hecha en Excel con otro método.

## Archivos

- `Modelo_Riesgo_Perdida.ipynb`: cuaderno reproducible (Google Colab o Jupyter). Sube el CSV exportado y ejecuta las celdas en orden.
- `web/index.html`: la página publicada con los resultados, la proyección 2015 y el simulador de riesgo. Funciona sin servidor; ábrela con doble clic.

Página publicada: https://claude.ai/artifact/R6rWUSvcHPMc2h8EcgG2Jr
