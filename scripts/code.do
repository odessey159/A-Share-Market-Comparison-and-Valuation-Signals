cd "D:/Google Download"
use "FS_Combas.dta",clear
gen date=date(Accper, "YMD")
format date %td
gen dateq=qofd(date)
format dateq %tq
drop Accper
drop date
rename dateq Accper
duplicates drop Stkcd Accper, force
save "processed_FS_Combas.dta", replace

use "FS_Comins.dta",clear
gen date=date(Accper, "YMD")
format date %td
gen dateq=qofd(date)
format dateq %tq
drop Accper
drop date
rename dateq Accper
duplicates drop Stkcd Accper, force
save "processed_FS_Comins.dta", replace

use "FI_T5.dta",clear
gen date=date(Accper, "YMD")
format date %td
gen dateq=qofd(date)
format dateq %tq
drop Accper
drop date
rename dateq Accper
duplicates drop Stkcd Accper, force
save "processed_FI_T5.dta", replace

use "TRD_Mnth.dta",clear
gen date=monthly(Trdmnt, "YM")
format date %tm
gen Accper=qofd(dofm(date))
format Accper %tq
drop Trdmnt
rename date Trdmnt
save "processed_TRD_Mnth.dta", replace

use "TRD_Co.dta",clear
gen date=date(Listdt, "YMD")
format date %td
drop Listdt
rename date Listdt
gen date=date(Estbdt, "YMD")
format date %td
drop Estbdt
rename date Estbdt
save "processed_TRD_Co.dta", replace

use "processed_TRD_Mnth.dta",clear
merge m:1 Stkcd Accper using "processed_FS_Combas.dta"
drop _merge
merge m:1 Stkcd Accper using "processed_FS_Comins.dta"
drop _merge
merge m:1 Stkcd Accper using "processed_FI_T5.dta"
drop _merge
merge m:1 Stkcd using "processed_TRD_Co.dta"
drop _merge
gen PE_ratios=Mclsprc/B003000000
gen Outstanding_Shares=Msmvosd/Mclsprc
gen Book_Value_per_Share=(A001000000-A002000000)/Outstanding_Shares
gen PB_ratios=Mclsprc/Book_Value_per_Share
gen RD_expense_total_asset_ratios =B001216000/A001000000
gen current_date=c(current_date)
gen currentdate=date(current_date,"DMY")
gen firmages = (currentdate - Estbdt)/365
drop current_date
drop currentdate

bysort Markettype: summarize Mretwd PE_ratios PB_ratios F050201B F050501B RD_expense_total_asset_ratios firmages, detail
bysort Markettype Accper: egen median_PE_ratios=median(PE_ratios)
twoway (line median_PE_ratios Accper if inlist(Markettype, 1, 2, 4, 8, 64), mcolor(blue) msize(medium) ytitle("P/E Ratio") xtitle("Time (Accper)") title("main board--Median P/E Ratio vs. Time") xlabel(, grid) ylabel(, grid))
twoway (line median_PE_ratios Accper if inlist(Markettype, 16, 32), mcolor(blue) msize(medium) ytitle("P/E Ratio") xtitle("Time (Accper)") title("GEM board--Median P/E Ratio vs. Time") xlabel(, grid) ylabel(, grid))
save "processed_Final.dta", replace


import delimited "problem 3_data.csv", clear
gen date=date(enddate,"YMD")
gen year = real(substr(enddate, 1, 4))
format date %td
drop enddate
rename date enddate
egen annual_median_value_ROE=median(roec), by (year)
xtset ïsymbol year
gen total_revenue_growth_rate=(totalrevenue-L.totalrevenue)/L.totalrevenue
egen median_revenue_growth_rate=median(total_revenue_growth_rate), by (year)
gen label1=roec>annual_median_value_ROE
replace label1=0 if L.label1==0 
bysort year:egen total_lable1=total(label1 )if ïsymbol!=.
bysort year:egen num_companies=total(ïsymbol!=.)
gen rate1=total_lable1/num_companies

xtset ïsymbol year
gen label2=total_revenue_growth_rate>median_revenue_growth_rate
replace label2=0 if L.label2==0
bysort year:egen total_lable2=total(label2 )if ïsymbol!=.
gen rate2=total_lable2/num_companies
twoway(line rate1 year), title("percentages of companies that consistently maintain above-median ROE(2011-2020)")ytitle("Percentage") xtitle("year")
twoway(line rate2 year), title("percentages of companies that consistently maintain above-median total revenue growth rate(2011-2020)")ytitle("Percentage") xtitle("year")






