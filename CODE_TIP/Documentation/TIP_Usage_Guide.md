# EPO TIP Platform: Usage & Visualization Guide (Updated)

This guide provides instructions for the NACI 2026 researchers on how to execute the migrated codebase on the EPO TIP platform.

## 1. Overview of the `CODE_TIP` Workflow

The migrated codebase follows a two-stage process:

1. **SQL Extraction**: Fast extraction and filtering of millions of patent records into project-specific tables.
2. **Jupyter Analysis**: Interactive Python notebooks for aggregation, filtering, and high-quality visualization.

---

## 2. Step-by-Step Execution Instructions

### Phase A: Data Selection (SQL)

Run these in the TIP SQL Editor:

- **Core Selection**: Run `01A_Mitigation_selection.sql` and `01A_Adaptation_selection.sql`.
- **Enrichment**: Run `02A_Mitigation_enrichment.sql` and `02A_Adaptation_enrichment.sql`.
- **Benchmarks**: Run `01B_Benchmark_construction.sql`.
- **Aggregations**: Run `02B_Technical_Aggregations.sql`.

### Phase B: Analysis (Jupyter Notebooks)

Open and run in order:

1. [03_Global_Trends.ipynb](file:///Users/iordn/Documents/GitHub/ClimateMitig_Innov_NACI_2026/CODE_TIP/Analysis/03_Global_Trends.ipynb)
2. [04_Tech_and_Geo_Analysis.ipynb](file:///Users/iordn/Documents/GitHub/ClimateMitig_Innov_NACI_2026/CODE_TIP/Analysis/04_Tech_and_Geo_Analysis.ipynb)
3. [05_DeepDive_EV_Hydrogen.ipynb](file:///Users/iordn/Documents/GitHub/ClimateMitig_Innov_NACI_2026/CODE_TIP/Analysis/05_DeepDive_EV_Hydrogen.ipynb)
4. [06_Adaptation_Trends.ipynb](file:///Users/iordn/Documents/GitHub/ClimateMitig_Innov_NACI_2026/CODE_TIP/Analysis/06_Adaptation_Trends.ipynb)

---

## 3. Handling External Data (FDI & R&D)

Original scripts `03_Construction_FDI` and `04_Public_R&D` rely on external datasets (**Zephyr, IEA, OECD**).

- **FDI Logic**: Since Zephyr data is not hosted on TIP, you must upload your formatted Zephyr CSV to the TIP workspace. Use the Pandas `merge` function inside a Jupyter notebook to join it with the SQL results.
- **R&D Data**: Similarly, upload the IEA/OECD budget CSVs and use the provided analysis notebooks to calculate R&D intensities.

---

## 4. Referencing EPO Documentation

- **ASEARCH Manual**: In the TIP sidebar.
- **PATSTAT Scheme**: Use the Data Catalog to explore new variables.
