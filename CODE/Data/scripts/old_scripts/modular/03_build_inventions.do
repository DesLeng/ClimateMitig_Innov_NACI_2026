/********************************************************************
* Invention construction (DOCDB family level)
********************************************************************/

*--- CCMT inventions
use "$datapath/Patstat_mitigation2026.dta", clear

bysort docdb technology: gen nb_invt = _N
gen inv_weight = 1/nb_invt

bysort docdb technology: egen granted_any = max(granted)

gen byte HVI = (famsize_offices_EPCgrants_docdb >= 2)

bysort docdb: egen publn_year = min(earliest_publn_year)
drop if missing(publn_year)

keep docdb technology publn_year inv_weight granted_any HVI
save "$datapath/CCMT_inventions.dta", replace

use "$datapath/Complete_IPC3_benchmark_CCMT.dta", clear
merge m:1 appln_id using "$patstpath/general/patstat_core.dta", keep(match)
drop _merge

bysort docdb technology: gen nb_invt = _N
gen inv_weight = 1/nb_invt

bysort docdb technology: egen granted_any = max(granted)
gen byte HVI = (famsize_offices_EPCgrants_docdb >= 2)

bysort docdb: egen publn_year = min(earliest_publn_year)
drop if missing(publn_year)

keep docdb technology publn_year inv_weight granted_any HVI
save "$datapath/BENCH_inventions_IPC3.dta", replace
