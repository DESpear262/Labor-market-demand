clear

cd "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\raw data"

local filelist : dir . files "*.q1-q4 US000 U.S. TOTAL"

foreach f of local filelist {
	import delimited "`f'"
	
	keep if own_code == 5

	keep if length(industry_code) == 3
	
	destring industry_code, replace

	keep industry_code year industry_title qtr oty_month1_emplvl_pct oty_avg_wkly_wage_pct

	save "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\ `f'.dta", replace

	clear
}



clear

cd "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\"

local filelist : dir . files " *.q1-q4 us000 u.s. total.csv.dta"

use " 1990.q1-q4 us000 u.s. total.csv.dta"

foreach f of local filelist {

	append using "`f'"
	
}

drop if year == 1990

tostring industry_code, replace

gen industry_code_2d = substr(industry_code, 1, 2)

destring industry_code, replace

destring industry_code_2d, replace

levelsof industry_code_2d,local (codelist)

foreach c of local codelist{
	gen code2D`c' = (industry_code_2d == `c')
}

levelsof year,local (yearlist)

foreach y of local yearlist{
	gen dYear`y' = (year == `y')
}

drop if industry_code_2d==10

save "all year industry.dta", replace

gen Lag1Emp=.

gen Lag2Emp=.

gen Lag1Wage=.

gen Lag2Wage=.

sort industry_code, stable

replace Lag1Emp = oty_month1_emplvl_pct[_n-4] if year >= 1992

replace Lag2Emp = oty_month1_emplvl_pct[_n-8] if year > 1992

replace Lag1Wage = oty_avg_wkly_wage_pct[_n-4] if year >= 1992

replace Lag2Wage = oty_avg_wkly_wage_pct[_n-8] if year > 1992

gen recession = 0

replace recession = 1 if (year==1990 & qtr>=3)
replace recession = 1 if (year==1991 & qtr==1)
replace recession = 1 if (year==2001 & qtr>=2)
replace recession = 1 if (year==2008)
replace recession = 1 if (year==2009 & qtr<=2)

levelsof industry_code_2d,local (codelist)

foreach c of local codelist{
	gen WageChgxcode2D`c' = (code2D`c'*oty_avg_wkly_wage_pct)
}

save "all year industry.dta", replace

eststo: reg oty_month1_emplvl_pct oty_avg_wkly_wage_pct
esttab using "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\MainResults.tex", title("Change in Employment Predicted by Change in Wages With No Lag") replace
est clear

eststo: reg oty_month1_emplvl_pct Lag1Wage
eststo: reg oty_month1_emplvl_pct Lag2Wage
esttab using "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\MainResults.tex", title("Change in Employment Predicted by Change in Wages With One and Two Year Lag In Wage Changes") append
est clear

eststo: reg oty_avg_wkly_wage_pct Lag1Emp
eststo: reg oty_avg_wkly_wage_pct Lag2Emp
esttab using "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\MainResults.tex", title("Change in Wages Predicted by Change in Employment With One and Two Year Lag In Employment Changes") append
est clear

eststo: reg oty_month1_emplvl_pct oty_avg_wkly_wage_pct WageChgxcode2D11 WageChgxcode2D21 WageChgxcode2D22 WageChgxcode2D23 WageChgxcode2D31 WageChgxcode2D32 WageChgxcode2D33 WageChgxcode2D42 WageChgxcode2D44 WageChgxcode2D45 WageChgxcode2D48 WageChgxcode2D49 WageChgxcode2D51 WageChgxcode2D52 WageChgxcode2D53 WageChgxcode2D54 WageChgxcode2D55 WageChgxcode2D56 WageChgxcode2D61 WageChgxcode2D62 WageChgxcode2D71 WageChgxcode2D72 WageChgxcode2D81
esttab using "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\IndustryResults.tex", title(`c') replace
est clear

eststo: reg oty_month1_emplvl_pct oty_avg_wkly_wage_pct RecessionXWageChg
esttab using "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\RecessionResults.tex", title("Change in Wages Predicted by Change in Employment Controlled for Recession") replace
est clear


*************
*Legacy code*
*************
/*
levelsof industry_code, clean local (ic)

levelsof industry_code, clean local (ic)


foreach ndx of local ic{
	preserve
	keep if industry_code == `ndx'
	levelsof industry_title, clean local (it)
	eststo: quietly reg oty_avg_annual_pay_pct_chg oty_annual_avg_emplvl_pct_chg
	esttab using "RegTables0.tex", title(`it') append nonotes nocons
	est clear
	eststo: quietly reg oty_avg_annual_pay_pct_chg Lag1Emp
	esttab using "RegTables1.tex", title(`it') append nonotes nocons
	est clear
	eststo: quietly reg oty_avg_annual_pay_pct_chg Lag2Emp
	esttab using "RegTables2.tex", title(`it') append nonotes nocons
	est clear
	est clear
	restore
}


levelsof industry_code, clean local (ic)

foreach ndx of local ic{
	preserve
	keep if industry_code == `ndx'
	levelsof industry_title, clean local (it)
	graph twoway (lfit oty_avg_annual_pay_pct_chg oty_annual_avg_emplvl_pct_chg) (scatter oty_avg_annual_pay_pct_chg oty_annual_avg_emplvl_pct_chg)  
	graph export "C:\Users\s94da\Desktop\Data and Do-files for papers and homework\Papers\IO1 Labor demand or supply\scatterplots\ `it' Scatter.png", replace
	restore
}*/