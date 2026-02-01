-- =========================================================================
-- NACI 2026: Climate Mitigation Patent Selection
-- Ported from: CODE/Data_building/01A_Mitigation_patent_selection.do
-- =========================================================================

-- Step 1: Create a table of unique application IDs associated with CCMT codes
-- We select Y02* but strictly exclude Y02A* (Adaptation)
CREATE TABLE IF NOT EXISTS project_mitigation_selection AS
SELECT DISTINCT 
    appln_id,
    SUBSTR(cpc_class_symbol, 1, 3) as tech_3_digit,
    SUBSTR(cpc_class_symbol, 1, 4) as tech_4_digit
FROM 
    patstat.tls224_appln_cpc
WHERE 
    cpc_class_symbol LIKE 'Y02%'
    AND cpc_class_symbol NOT LIKE 'Y02A%';

-- Step 2: Validate counts (Optional diagnostic)
-- SELECT tech_4_digit, COUNT(*) as count 
-- FROM project_mitigation_selection 
-- GROUP BY tech_4_digit 
-- ORDER BY count DESC;
