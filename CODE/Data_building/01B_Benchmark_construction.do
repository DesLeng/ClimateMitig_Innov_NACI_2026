*===============================================================================
* NACI Report 2026
* Chapter: Sustainability and Climate Change – Climate Change Mitigation Technologies
*
* Objective:
* - Construct IPC-based benchmark patent sets for each CCMT technology field
* - Benchmark defined as IPC classes covering 75% of mitigation patents
* - IPC 4-digit used as benchmark technology definition (EPO standard)
*===============================================================================

clear all
set more off

*===============================================================================
* 1. LINK MITIGATION PATENTS TO IPC CODES
*===============================================================================

use "$datapath/Patstat_mitigation2026.dta", clear
keep appln_id technology   // technology = IPC 4-digit benchmark
duplicates drop

merge 1:m appln_id using "$patstpath/general/ipc_codes.dta"
assert _merge == 3
drop _merge

save "$datapath/Merge_ipc_CCMT_mitigation_2026.dta", replace

*===============================================================================
* 2. BENCHMARK SELECTION – IPC 3-DIGIT LEVEL
*===============================================================================

use "$datapath/Merge_ipc_CCMT_mitigation_2026.dta", clear

* Exclude aggregate CCMT category (Y02)
drop if technology == "Y02"

gen ipc3 = substr(ipc_code,1,3)
label var ipc3 "IPC 3-digit benchmark class"

* Count patents by technology × IPC class
contract technology ipc3
rename _freq nb_bench_tech

* Total patents by technology
bysort technology: egen nb_technology = total(nb_bench_tech)

* Share and cumulative coverage
gen share = nb_bench_tech / nb_technology
gsort technology -share
by technology: gen cum_share = sum(share)

* Select IPC classes up to 75% coverage
keep if cum_share <= 0.75
keep technology ipc3
duplicates drop

save "$datapath/Selected_IPC3_benchmark_CCMT_2026.dta", replace

*===============================================================================
* 3. CONSTRUCT IPC 3-DIGIT BENCHMARK PATENT SETS
*===============================================================================

use "$patstpath/general/ipc_codes.dta", clear
gen ipc3 = substr(ipc_code,1,3)
keep appln_id ipc3
duplicates drop

merge m:1 ipc3 using "$datapath/Selected_IPC3_benchmark_CCMT_2026.dta"
assert _merge == 3 | _merge == 1
drop _merge

* Add full PATSTAT benchmark for aggregate CCMT (Y02)
gen technology = "Y02" if missing(technology)

duplicates drop technology appln_id
save "$datapath/Complete_IPC3_benchmark_CCMT_2026.dta", replace

*===============================================================================
* 4. BENCHMARK SELECTION – IPC 4-DIGIT LEVEL (REFERENCE CASE)
*===============================================================================

use "$datapath/Merge_ipc_CCMT_mitigation_2026.dta", clear
drop if technology == "Y02"

gen ipc4 = substr(ipc_code,1,4)
label var ipc4 "IPC 4-digit benchmark class"

contract technology ipc4
rename _freq nb_bench_tech

bysort technology: egen nb_technology = total(nb_bench_tech)

gen share = nb_bench_tech / nb_technology
gsort technology -share
by technology: gen cum_share = sum(share)

keep if cum_share <= 0.75
keep technology ipc4
duplicates drop

save "$datapath/Selected_IPC4_benchmark_CCMT_2026.dta", replace

*===============================================================================
* 5. CONSTRUCT IPC 4-DIGIT BENCHMARK PATENT SETS
*===============================================================================

use "$patstpath/general/ipc_codes.dta", clear
gen ipc4 = substr(ipc_code,1,4)
keep appln_id ipc4
duplicates drop

merge m:1 ipc4 using "$datapath/Selected_IPC4_benchmark_CCMT_2026.dta"
assert _merge == 3 | _merge == 1
drop _merge

gen technology = "Y02" if missing(technology)

duplicates drop technology appln_id
compress

save "$datapath/Complete_IPC4_benchmark_CCMT_2026.dta", replace

*===============================================================================
* End of benchmark construction script
*===============================================================================

