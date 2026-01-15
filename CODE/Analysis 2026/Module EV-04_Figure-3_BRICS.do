use "$patstpath/mitigation/ElecVehicles_ZOOM_inventor_ctry_year", clear
keep if publn_year >=2013 & publn_year <=2025

* Merge total CCMT inventions
mmerge invt_iso publn_year using ///
"$datapath/Final_database/mitigation_inv_tech_inventor_ctry_year", ///
keepusing(nb_hvi_CCMT world_hvi_CCMT) unmatched(none)

* EV specialisation (RTA-style)
gen spe_EV = (world_hvi_EVall / nb_hvi_CCMT)
egen world_EV = sum(world_hvi_EVall)
egen world_CCMT = sum(world_hvi_CCMT)
gen spe_world = world_EV / world_CCMT

gen RTA_EV = spe_EV / spe_world

keep if inlist(invt_iso,"BRA","RUS","IND","CHN","ZAF")
egen RTA_EV_1317 = mean(RTA_EV), by(invt_iso)

keep invt_iso invt_name RTA_EV_1317
duplicates drop

export excel "$droppath/Analysis/EV/Figure_EV3_RTA.xlsx", ///
replace firstrow(variables)
