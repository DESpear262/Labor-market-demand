clear

local filelist : dir . files "*.annual us000 u.s. total.csv.dta"

use "C:\path\to\data\files\1990.annual us000 u.s. total.csv.dta"

foreach f of local filelist {

	append using "`f'"
	
}

drop if year == 1990

save "all year industry.dta"
