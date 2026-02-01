-- =========================================================================
-- NACI 2026: Advanced Technical Aggregations
-- Ported from: 02B, 02C (Mitigation & Adaptation)
-- =========================================================================

-- Aggregating at the 4-digit and Sub-category level for all project patents
CREATE TABLE IF NOT EXISTS project_technical_aggregates AS
SELECT 
    'Mitigation' as project_type,
    a.appln_id,
    c.cpc_class_symbol,
    SUBSTR(c.cpc_class_symbol, 1, 4) as tech_4_digit,
    SUBSTR(c.cpc_class_symbol, 1, 6) as sub_tech
FROM 
    project_mitigation_selection a
JOIN 
    patstat.tls224_appln_cpc c ON a.appln_id = c.appln_id
WHERE 
    c.cpc_class_symbol LIKE 'Y02%'

UNION ALL

SELECT 
    'Adaptation' as project_type,
    a.appln_id,
    c.cpc_class_symbol,
    SUBSTR(c.cpc_class_symbol, 1, 4) as tech_4_digit,
    SUBSTR(c.cpc_class_symbol, 1, 6) as sub_tech
FROM 
    project_adaptation_selection a
JOIN 
    patstat.tls224_appln_cpc c ON a.appln_id = c.appln_id
WHERE 
    c.cpc_class_symbol LIKE 'Y02A%';
