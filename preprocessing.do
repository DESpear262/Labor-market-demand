clear

cd "C:\path\to\data\files\"

local filelist : dir . files "*.annual US000 U.S. TOTAL.csv"

foreach f of local filelist {
	display "`f'"
	import delimited "`f'"
	
	keep if own_code == 5

	keep industry_code year industry_title oty_annual_avg_emplvl_pct_chg oty_total_annual_wages_pct_chg

	drop if length(industry_code) != 4
	
	destring industry_code, replace

	save "`f'.dta", replace

	clear
}
