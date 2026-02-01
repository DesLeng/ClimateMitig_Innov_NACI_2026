-- =========================================================================
-- NACI 2026: Climate Adaptation Patent Selection
-- Ported from: CODE/Data_building/01A_Adaptation_patent_selection.do
-- =========================================================================

-- Step 1: Create a table of unique application IDs associated with Adaptation codes (Y02A)
CREATE TABLE IF NOT EXISTS project_adaptation_selection AS
SELECT DISTINCT 
    appln_id,
    SUBSTR(cpc_class_symbol, 1, 4) as technology,
    SUBSTR(cpc_class_symbol, 1, 6) as sub_tech
FROM 
    patstat.tls224_appln_cpc
WHERE 
    cpc_class_symbol LIKE 'Y02A%';

-- Step 2: Create core adaptation summary table (technology = Y02A)
CREATE TABLE IF NOT EXISTS project_adaptation_base AS
SELECT DISTINCT 
    'Y02A' as technology,
    appln_id
FROM 
    project_adaptation_selection;
