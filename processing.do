clear

use "all year industry.dta"

levelsof industry_code, clean local (ic)

foreach ndx of local ic{
	preserve
	keep if industry_code == `ndx'
	reg oty_annual_avg_emplvl_pct_chg oty_total_annual_wages_pct_chg
	restore
}