# Análisis de Rendimiento Empresarial y Rentabilidad

🌐 Idioma: [English](README.md) | **Español**

## Resumen Ejecutivo

El crecimiento de los ingresos no se está traduciendo en un crecimiento rentable.

De **enero-agosto de 2025 a enero-agosto de 2026**, los ingresos aumentaron un **13,66%**, mientras que el beneficio bruto cayó un **4,51%** y el margen bruto descendió del **31,32% al 26,32%**.

El análisis identificó dos principales áreas de preocupación:

- **Technology** muestra una presión más amplia sobre costes y márgenes en el conjunto del negocio.
- **East** experimentó el mayor deterioro de rentabilidad, especialmente dentro del canal **Partner**, donde el descuento medio aumentó aproximadamente del **6,4% al 16,7%** y el margen bruto cayó hasta aproximadamente el **17,8%**.

La empresa alcanzó el **104,27% de su objetivo de ingresos**, pero solo el **86,00% de su objetivo de beneficio bruto**, lo que muestra que el crecimiento de ingresos está ocultando una rentabilidad más débil.

---

## Problema de Negocio

La dirección está observando un crecimiento continuo de los ingresos, pero existe preocupación porque la rentabilidad no está mejorando al mismo ritmo.

El objetivo del análisis es responder:

> **¿Está creciendo el negocio de forma rentable y qué productos, clientes y regiones están impulsando o debilitando el rendimiento frente a los objetivos?**

---

## Periodo de Análisis

**Enero de 2024 – agosto de 2026**

Como 2026 solo contiene ocho meses de datos, las comparaciones interanuales utilizan periodos comparables de **enero-agosto**.

---

## Dataset

El dataset contiene cinco tablas principales:

- `customers`
- `products`
- `orders`
- `order_items`
- `targets`

Los datos incluyen segmentos de clientes, productos, transacciones, canales de venta, descuentos, costes de producto y objetivos regionales mensuales.

---

## Metodología

### Calidad y Preparación de los Datos

Se utilizó PostgreSQL para validar:

- Número de registros
- Valores ausentes
- Registros duplicados
- Cobertura temporal
- Unicidad de objetivos

La auditoría identificó **12 segmentos de cliente ausentes** y **50 registros duplicados en order_items**.

Los segmentos ausentes se clasificaron como `Unknown` y los registros duplicados se eliminaron antes del análisis.

### Capa Analítica

Se creó una capa analítica reutilizable en SQL combinando pedidos, clientes, productos y líneas de pedido.

Se calcularon las principales métricas de negocio:

- Revenue
- COGS
- Gross Profit
- Gross Margin

### Análisis de Negocio

La investigación siguió el problema de rentabilidad desde el rendimiento general de la empresa hacia niveles más específicos:

**Empresa → Región → Categoría → Canal de Venta → Cliente**

Posteriormente, el rendimiento real se comparó con los objetivos regionales de ingresos y beneficio bruto.

Excel y Power Query se utilizaron como capa independiente de validación antes de construir la capa final de reporting en Power BI.

---

## Principales Hallazgos

### 1. El crecimiento de ingresos no se está traduciendo en crecimiento del beneficio

Enero-agosto 2025 vs enero-agosto 2026:

- **Revenue:** +13,66%
- **Gross Profit:** -4,51%
- **Gross Margin:** 31,32% → 26,32%

El negocio está generando más ingresos, pero reteniendo menos beneficio bruto por cada unidad de ingreso.

---

### 2. Technology muestra una presión amplia sobre la rentabilidad

Technology registró un **margen bruto del 24,19%** en enero-agosto de 2026, el más bajo entre las principales categorías de producto.

El análisis también identificó un aumento de los costes de producto, lo que sugiere que parte del deterioro del margen va más allá de una única región.

---

### 3. East presenta el mayor deterioro regional

Los ingresos de East aumentaron aproximadamente un **17,4% interanual**, mientras que el beneficio bruto cayó aproximadamente un **14,6%**.

El margen bruto descendió de:

**31,25% → 22,71%**

Fue el mayor deterioro regional de rentabilidad.

---

### 4. El crecimiento de East Partner está asociado a márgenes significativamente más bajos

Dentro de East, el canal Partner creció rápidamente.

- **Descuento medio:** ~6,4% → 16,7%
- **Margen bruto 2026:** ~17,8%
- **Pedidos Partner:** más del doble

El canal está generando un crecimiento importante de ingresos, pero con una economía por unidad significativamente más débil.

---

### 5. El crecimiento de Partner es amplio y no está concentrado

Los clientes activos de East Partner aumentaron de:

**316 → 427**

Al mismo tiempo, la cuota de ingresos de los 10 principales clientes de Partner disminuyó de:

**11,59% → 7,61%**

Esto sugiere que el cambio no está siendo impulsado por un pequeño número de clientes excepcionalmente grandes, sino que refleja una expansión más amplia del canal Partner.

---

### 6. Se están alcanzando los objetivos de ingresos, pero no los de beneficio

Enero-agosto de 2026:

- **Cumplimiento del objetivo de ingresos:** 104,27%
- **Cumplimiento del objetivo de beneficio bruto:** 86,00%
- **Variación de ingresos:** +637,40K
- **Variación de beneficio bruto:** -666,67K

Tres de las cuatro regiones superaron sus objetivos de ingresos, mientras que **las cuatro regiones quedaron por debajo de sus objetivos de beneficio bruto**.

East mostró la mayor diferencia:

- **Cumplimiento del objetivo de ingresos:** 107,74%
- **Cumplimiento del objetivo de beneficio bruto:** 74,98%

---

## Recomendaciones de Negocio

- **Revisar la gobernanza de descuentos en East Partner** y determinar si los niveles actuales de descuento están económicamente justificados.
- **Evaluar conjuntamente ingresos y rentabilidad** al analizar el rendimiento de regiones y canales.
- **Investigar el aumento de costes en Technology** y su impacto sobre los márgenes a nivel de producto.
- **Introducir límites o guardrails de rentabilidad** junto a los objetivos de ingresos para evitar que un crecimiento con márgenes bajos parezca exitoso.
- **Continuar monitorizando la economía del canal Partner** a medida que crece, especialmente los niveles de descuento y el margen bruto.

---

## Limitaciones

- El dataset es simulado para fines de portfolio.
- El análisis identifica asociaciones, pero no establece causalidad.
- El beneficio bruto no incluye gastos operativos, costes de marketing ni otros costes necesarios para calcular la rentabilidad neta.
- No se dispone de contratos de clientes, precios de competidores ni elasticidad de precios.
- 2026 es un año parcial, por lo que las comparaciones interanuales utilizan periodos comparables de enero-agosto.

---

## Próximos Pasos

El análisis podría ampliarse con:

- Rentabilidad a nivel de cliente
- Variación de costes a nivel de producto
- Elasticidad de descuentos
- Margen de contribución
- Forecast de cierre anual frente a objetivos
- Análisis de escenarios de descuentos y costes

---

## Validación en Excel

Excel y Power Query se utilizaron para preparar y validar de forma independiente el dataset analítico.

Los resultados de SQL se contrastaron utilizando PivotTables y periodos comparables de enero-agosto antes de construir el informe de Power BI.

---

## Dashboard

### Rendimiento Ejecutivo

![Executive Performance](executive_performance.png)

Resumen de ingresos, beneficio bruto, margen y rendimiento interanual del negocio.

### Drivers de Rentabilidad

![Profitability Drivers](profitability_drivers.png)

Análisis de la rentabilidad por categoría y de los drivers regionales y de canal detrás del deterioro del margen.

### Objetivos y Rentabilidad

![Target & Profitability](target_profitability.png)

Comparación de ingresos y beneficio bruto reales frente a los objetivos de gestión por región.

---

## Herramientas y Habilidades

**PostgreSQL**
- Validación de calidad de datos
- Joins y CTEs
- Window functions
- Vistas analíticas
- Agregación y segmentación
- Análisis de variaciones

**Excel / Power Query**
- Preparación de datos
- Transformación de datos
- PivotTables
- Validación de KPIs
- Validación cruzada entre herramientas

**Power BI / DAX**
- Modelado de datos
- Medidas DAX
- Análisis YoY
- Cumplimiento de objetivos
- Análisis de variaciones
- Reporting de KPIs
- Diseño de dashboards

---

## Archivos del Repositorio

| Archivo | Descripción |
|---|---|
| `01_data_quality.sql` | Controles de calidad e integridad de datos |
| `02_analytics_layer.sql` | Capa analítica limpia y métricas de negocio |
| `03_business_performance_analysis.sql` | Análisis de rentabilidad, drivers y objetivos |
| `Business_Performance_Profitability_Analysis.xlsx` | Validación con Excel y Power Query |
| `Business_Performance_Profitability_Analysis.pbix` | Informe de Power BI |
| `executive_performance.png` | Dashboard de rendimiento ejecutivo |
| `profitability_drivers.png` | Dashboard de drivers de rentabilidad |
| `target_profitability.png` | Dashboard de objetivos y rentabilidad |
