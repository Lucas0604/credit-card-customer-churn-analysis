-- 1. Quantos clientes existem por Attrition_Flag?
SELECT 
	Attrition_Flag,
    COUNT(*) AS QTD
FROM bankchurners
GROUP BY Attrition_Flag;

-- 2. Qual a taxa de attrition em porcentagem (dica: COUNT com CASE WHEN ou duas subconsultas, 
-- combinado com uma divisão)?
SELECT 
    Attrition_Flag,
    (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM bankchurners) AS porcentagem
FROM bankchurners
GROUP BY Attrition_Flag;

-- 3. Qual a média de Total_Relationship_Count para clientes Existing vs. Attrited?
SELECT 
	Attrition_Flag,
    AVG(Total_Relationship_Count)
FROM bankchurners
GROUP BY Attrition_Flag;

-- 4. Qual a média de Months_Inactive_12_mon para cada grupo de Attrition_Flag?
SELECT 
	Attrition_Flag,
    AVG(Months_Inactive_12_mon)
FROM bankchurners
GROUP BY Attrition_Flag;

-- 5. Qual a média de Contacts_Count_12_mon para cada grupo de Attrition_Flag?
SELECT 
	Attrition_Flag,
    AVG(Contacts_Count_12_mon)
FROM bankchurners
GROUP BY Attrition_Flag;

-- 6. Liste a taxa de attrition por Card_Category (quantos de cada categoria saíram vs. total da categoria).
SELECT 
    Card_Category,
    COUNT(*) AS total_categoria,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS total_saidas,
    (SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS taxa_attrition_pct
FROM bankchurners
GROUP BY Card_Category;

-- 7. Quais os 10 clientes com maior Total_Trans_Amt entre os que ainda são Existing Customer?
SELECT 
	CLIENTNUM,
    Attrition_Flag,
    Total_Trans_Amt
FROM bankchurners
WHERE Attrition_Flag = 'Existing Customer'
ORDER BY Total_Trans_Amt DESC
LIMIT 10;

-- 8. Usando GROUP BY + HAVING, liste as faixas de renda (Income_Category) com mais de 100 clientes Attrited.
SELECT 
    Income_Category,
    COUNT(*) AS total
FROM bankchurners
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Income_Category
HAVING COUNT(*) > 100;

-- 9. Qual a média de Months_on_book por Attrition_Flag?
SELECT 
	Attrition_Flag,
    AVG(Months_on_book) AS media
FROM bankchurners
GROUP BY Attrition_Flag;

-- 10. Ordene as categorias de cartão pela taxa de attrition, da maior para a menor.
SELECT
	Card_Category,
    (SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) as taxa
FROM bankchurners
GROUP BY Card_Category
ORDER BY taxa DESC;


