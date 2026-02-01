-- =========================================================================
-- NACI 2026: Adaptation Patent Enrichment
-- Ported from: CODE/Data_building/02A_patent_adaptation_patstatCAT_2026.do (Logic)
-- =========================================================================

-- Join selected Adaptation IDs with Application Info
CREATE TABLE IF NOT EXISTS project_adaptation_enriched AS
SELECT 
    s.appln_id,
    s.technology,
    a.appln_auth,
    a.appln_filing_year,
    a.earliest_filing_year,
    a.docdb_family_id,
    a.docdb_family_size,
    a.granted,
    CASE WHEN a.docdb_family_size > 1 THEN 1 ELSE 0 END AS HVI
FROM 
    project_adaptation_selection s
JOIN 
    patstat.tls201_appln a ON s.appln_id = a.appln_id
WHERE 
    a.ipr_type = 'PI';
