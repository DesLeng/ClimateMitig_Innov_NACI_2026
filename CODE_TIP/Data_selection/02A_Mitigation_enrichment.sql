-- =========================================================================
-- NACI 2026: Mitigation Patent Enrichment & HVI Identification
-- Ported from: CODE/Data_building/02A_patent_mitigation_patstatCAT_2026.do
-- =========================================================================

-- Join selected IDs with Application Info and Family tables
CREATE TABLE IF NOT EXISTS project_mitigation_enriched AS
SELECT 
    s.appln_id,
    s.tech_3_digit,
    s.tech_4_digit,
    a.appln_auth,
    a.appln_filing_year,
    a.earliest_filing_year,
    a.docdb_family_id,
    a.docdb_family_size,
    a.granted,
    -- HVI: High Value Inventions (filed in >= 2 offices)
    CASE WHEN a.docdb_family_size > 1 THEN 1 ELSE 0 END AS HVI
FROM 
    project_mitigation_selection s
JOIN 
    patstat.tls201_appln a ON s.appln_id = a.appln_id
WHERE 
    a.ipr_type = 'PI'; -- Equivalent to ipr_type==2 in original Stata (Patents of Invention)
