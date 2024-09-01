-- Data Descriptive Analysis

-- query01: 1. Measures of Center:

-- Mean
SELECT AVG("Year") AS mean_value_01 FROM public."Algeriadata";
SELECT AVG("Electric power consumption (kWh per capita)") AS mean_value_02 FROM public."Algeriadata";

-- Median
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") AS median_value_02 FROM public."Algeriadata";

-- Mode
SELECT "Electric power consumption (kWh per capita)", COUNT(*) AS frequency_1 
FROM public."Algeriadata"
GROUP BY "Electric power consumption (kWh per capita)"
ORDER BY frequency_1 DESC
LIMIT 1;

-- query02: 2. Measures of Spread:

-- Range
SELECT MAX("Electric power consumption (kWh per capita)") - MIN("Electric power consumption (kWh per capita)") AS range_value_power 
FROM public."Algeriadata";

-- IQR
SELECT 
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") AS Q3,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") AS Q1,
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)")) AS IQR
FROM public."Algeriadata";

-- query03: 3. Visualizing Data:

-- Outliers
WITH iqr_data AS (
    SELECT 
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") AS Q3,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") AS Q1,
        (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)") - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Electric power consumption (kWh per capita)")) AS IQR
    FROM public."Algeriadata"
)
SELECT *
FROM public."Algeriadata", iqr_data
WHERE "Electric power consumption (kWh per capita)" < Q1 - 1.5 * IQR OR "Electric power consumption (kWh per capita)" > Q3 + 1.5 * IQR;

-- query04: 4. Check null values:
SELECT *
FROM public."Algeriadata"
WHERE "Year" IS NULL OR "Electric power consumption (kWh per capita)" IS NULL;

-- query05: 5. Check duplicated values:
SELECT "Year", "Electric power consumption (kWh per capita)", COUNT(*)
FROM public."Algeriadata"
GROUP BY "Year", "Electric power consumption (kWh per capita)"
HAVING COUNT(*) > 1;
