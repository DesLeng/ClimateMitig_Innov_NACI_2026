use "$patstpath/mitigation/ElecVehicles_ZOOM_inventor_ctry_year", clear
keep if publn_year >=2013 & publn_year <=2025
keep if inlist(invt_iso,"BRA","RUS","IND","CHN","ZAF")

egen EV_country = sum(world_hvi_EVall), by(invt_iso)
egen EV_BRICS_total = sum(world_hvi_EVall)

gen sh_BRICS_EV = 100 * EV_country / EV_BRICS_total

keep invt_iso invt_name EV_country sh_BRICS_EV
duplicates drop
gsort -EV_country

export excel "$droppath/Analysis/EV/Table_EV1_structure.xlsx", ///
replace firstrow(variables)
