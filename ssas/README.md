# Modelo tabular en SSAS · ModeloBI_Rentabilidad

`ModeloBI_Rentabilidad.xmla` es la definición completa del modelo en TMSL (nivel de compatibilidad 1700, SQL Server 2025):

- 7 tablas del DataMart y la tabla calculada **Tope Descuento** (0 % a 85 %, pasos de 5 %).
- 6 relaciones de muchos a uno hacia `Fact_Ventas`.
- 4 jerarquías: Tiempo, Producto, Geografía y Cliente.
- 20 medidas DAX: 15 base (ventas, ganancia, margen, pedidos, ticket, YoY, pérdidas…) y 5 del escenario del tope (`Ganancia Simulada`, `Ganancia Recuperada`, etc.), con formato en dólares.

## Cómo implementarlo

1. Dar permiso de lectura a la cuenta del servicio: [`../sql/05_permiso_servicio_ssas.sql`](../sql/05_permiso_servicio_ssas.sql).
2. En SSMS, conectarse a **Analysis Services** (`localhost`) → Nueva consulta → **XMLA**.
3. Abrir `ModeloBI_Rentabilidad.xmla` y ejecutarlo: crea la base (`createOrReplace`) y carga los datos (`refresh`).
4. Comprobar con [`verificacion.dax`](verificacion.dax).

> En los equipos donde Visual Studio sí conecta con el servidor de área de trabajo, el mismo modelo se implementa con clic derecho en el proyecto → **Implementar**.

### Escenario del tope

```dax
Ganancia Simulada :=
[Ventas Simuladas] - SUMX ( Fact_Ventas, Fact_Ventas[Ventas] - Fact_Ventas[Ganancia] )

Ventas Simuladas :=
SUMX ( Fact_Ventas,
    DIVIDE ( Fact_Ventas[Ventas], 1 - Fact_Ventas[Descuento] )
        * ( 1 - MIN ( Fact_Ventas[Descuento], [Tope Seleccionado] ) ) )
```
