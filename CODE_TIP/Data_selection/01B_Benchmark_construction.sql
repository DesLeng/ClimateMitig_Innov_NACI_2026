-- =========================================================================
-- NACI 2026: Benchmark Construction (IPC-based)
-- Ported from: CODE/Data_building/01B_Benchmark_construction.do
-- =========================================================================

-- Step 1: Identify IPC 3-digit and 4-digit codes from our primary Mitigation/Adaptation sets
-- This helps build the "Benchmark" against which our target technologies are compared.

-- Note: In TIP SQL, we can calculate the 75% coverage logic using Window Functions
-- or simply extract the base IPC associations.

CREATE TABLE IF NOT EXISTS project_ipc_benchmark_selection AS
WITH TechIPC AS (
    SELECT 
        s.appln_id,
        'Mitigation' as tech_type,
        SUBSTR(i.ipc_class_symbol, 1, 3) as ipc3,
        SUBSTR(i.ipc_class_symbol, 1, 4) as ipc4
    FROM 
        project_mitigation_selection s
    JOIN 
        patstat.tls209_appln_ipc i ON s.appln_id = i.appln_id
)
SELECT DISTINCT 
    ipc3,
    ipc4
FROM 
    TechIPC;

-- Step 2: Extract all patents belonging to these IPC classes to form the Benchmark
CREATE TABLE IF NOT EXISTS project_benchmark_base AS
SELECT DISTINCT 
    i.appln_id,
    b.ipc3,
    b.ipc4
FROM 
    patstat.tls209_appln_ipc i
JOIN 
    project_ipc_benchmark_selection b ON SUBSTR(i.ipc_class_symbol, 1, 4) = b.ipc4;
