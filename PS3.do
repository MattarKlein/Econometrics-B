capture log close
log using "PS3", smcl replace
//_1
clear all
use "nswre74.dta"
append using "cps1re74.dta", gen(obs)
//_2
quietly gen age_2 = age^2
local i = 1
foreach var in age age_2 ed black hisp married nodeg re74 re75 {
quietly regress `var' treat if obs == 0, r
eststo a_reg_`i'
local ++i
}
//_3
foreach var in age age_2 ed black hisp married nodeg re74 re75 {
quietly regress `var' treat if obs == 1, r
eststo a_reg_`i'
local ++i
}
//_4
forvalues j = 1/3{
local k = 3*(`j')-2
local r = 3*(`j')-1
local t = 3*(`j')
esttab a_reg_`k' a_reg_`r' a_reg_`t', se
}
//_5
forvalues j = 3/6{
local k = 3*(`j')-2
local r = 3*(`j')-1
local t = 3*(`j')
esttab a_reg_`k' a_reg_`r' a_reg_`t', se
}
//_6
quietly regress re78 treat if obs == 0, r
eststo b_reg_1
quietly regress re78 treat age age_2 ed nodeg married black hisp  if obs == 0, r
eststo b_reg_2
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75  if obs == 0, r
eststo b_reg_3
//_7
quietly regress re78 treat if obs == 1, r
eststo b_reg_4
quietly regress re78 treat age age_2 ed nodeg married black if obs == 1, r
eststo b_reg_5
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75 if obs == 1, r
eststo b_reg_6
//_8
esttab b_reg_1 b_reg_2 b_reg_3, se

//_9
esttab b_reg_4 b_reg_5 b_reg_6, se
//_10
quietly regress treat age age_2 ed nodeg married black re74 re75 if obs == 1, r
eststo c_reg_1
quietly predict lm_prop
quietly logit treat age age_2 ed nodeg married black re74 re75 if obs == 1, vce(robust)
eststo c_reg_2
quietly predict log_prop
quietly probit treat age age_2 ed nodeg married black re74 re75 if obs == 1, vce(robust)
eststo c_reg_3
quietly predict pro_prop
//_11
esttab c_reg_1 c_reg_2 c_reg_3, se
//_12
kdensity pro_prop, nograph generate(x fx)
kdensity pro_prop if obs == 1 & treat == 1, nograph generate(fx0) at (x)
kdensity pro_prop if obs == 1 & treat == 0, nograph generate(fx1) at (x)
label var fx0 "Treatment"
label var fx1 "Control"
line fx0 fx1 x, sort ytitle(Density)
graph export dens.pdf, replace
//_13
kdensity pro_prop, nograph generate(y gy)
kdensity pro_prop if obs == 1 & treat == 1 & pro_prop > 0.1, nograph generate(gy0) at (y)
kdensity pro_prop if obs == 1 & treat == 0 & pro_prop > 0.1, nograph generate(gy1) at (y)
label var gy0 "Treatment"
label var gy1 "Control"
line gy0 gy1 y, sort ytitle(Density >0.1)
graph export dens2.pdf, replace
//_14
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75  if obs == 0 & pro_prop > 0.1, r
eststo d_reg_1
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75  if obs == 1 & pro_prop > 0.1, r
eststo d_reg_2
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75  if obs == 0 & pro_prop > 0.2, r
eststo d_reg_3
quietly regress re78 treat age age_2 ed nodeg married black hisp re74 re75  if obs == 1 & pro_prop > 0.2, r
eststo d_reg_4
esttab d_reg_1 d_reg_2 d_reg_3 d_reg_4, se
//_15
*teffects psmatch (re78) (treat age age_2 ed nodeg married black hisp re74 re75, logit) if obs == 0 & log_prop > 0.1, vce(robust)
*eststo e_reg_1
teffects psmatch (re78) (treat age age_2 ed nodeg married black hisp re74 re75, probit) if obs == 0 & pro_prop > 0.2, vce(robust)
eststo e_reg_2
esttab e_reg_2, se
//_16
clear all
use "IPUMS.dta"

*clean data*
drop if (year == 1960 & hrswork2 <= 1) | (year != 1960 & uhrswork <= 14)
replace uhrswork = 22 if year == 1960 & hrswork2 == 2
replace uhrswork = 32 if year == 1960 & hrswork2 == 3
replace uhrswork = 37 if year == 1960 & hrswork2 == 4
replace uhrswork = 40 if year == 1960 & hrswork2 == 5
replace uhrswork = 44 if year == 1960 & hrswork2 == 6
replace uhrswork = 54 if year == 1960 & hrswork2 == 7
replace uhrswork = 60 if year == 1960 & hrswork2 == 8

drop if wkswork2 == 0
replace wkswork1 = 7 if year == 1960 & wkswork2 == 1
replace wkswork1 = 19 if year == 1960 & wkswork2 == 2
replace wkswork1 = 33 if year == 1960 & wkswork2 == 3
replace wkswork1 = 43.5 if year == 1960 & wkswork2 == 4
replace wkswork1 = 48.5 if year == 1960 & wkswork2 == 5
replace wkswork1 = 51.5 if year == 1960 & wkswork2 == 6

gen log_hr_wage = log(incwage+1/(wkswork1*uhrswork))

gen white = (race == 1)
replace white = . if (race != 1 & race != 2)
gen female = (sex == 2)
//_17
quietly regress log_hr_wage female [pweight = perwt] if year == 2019, r
eststo a_reg_1
quietly regress log_hr_wage female age i.educ [pweight = perwt] if year == 2019, r
eststo a_reg_2
quietly regress log_hr_wage white [pweight = perwt] if year == 2019, r
eststo a_reg_3
quietly regress log_hr_wage white age i.educ [pweight = perwt] if year == 2019, r
eststo a_reg_4

esttab a_reg_1 a_reg_2, label se 
esttab  a_reg_3 a_reg_4, label se
//_18
quietly regress log_hr_wage female age i.educ i.occ1990 [pweight = perwt] if year == 2019, r
eststo c_reg_1
quietly regress log_hr_wage white age i.educ i.occ1990 [pweight = perwt] if year == 2019, r
eststo c_reg_2
esttab c_reg_1 c_reg_2, keep(white female) se
//_19
quietly regress log_hr_wage female [pweight = perwt] if year == 1990, r
eststo d_reg_1
quietly regress log_hr_wage female age i.educ [pweight = perwt] if year == 1990, r
eststo d_reg_2
quietly regress log_hr_wage female age i.educ i.occ1990 [pweight = perwt] if year == 1990, r
eststo d_reg_3
quietly regress log_hr_wage white [pweight = perwt] if year == 1990, r
eststo d_reg_4
quietly regress log_hr_wage white age i.educ [pweight = perwt] if year == 1990, r
eststo d_reg_5
quietly regress log_hr_wage white age i.educ i.occ1990 [pweight = perwt] if year == 1990, r
eststo d_reg_6

esttab d_reg_1 d_reg_2 d_reg_3, label se keep(female)
esttab  d_reg_4 d_reg_5 d_reg_6, label se keep(white)
//_20
quietly regress log_hr_wage female [pweight = perwt] if year == 1960, r
eststo d_reg_7
quietly regress log_hr_wage female age i.educ [pweight = perwt] if year == 1960, r
eststo d_reg_8
quietly regress log_hr_wage female age i.educ i.occ1990 [pweight = perwt] if year == 1960, r
eststo d_reg_9
quietly regress log_hr_wage white [pweight = perwt] if year == 1960, r
eststo d_reg_10
quietly regress log_hr_wage white age i.educ [pweight = perwt] if year == 1960, r
eststo d_reg_11
quietly regress log_hr_wage white age i.educ i.occ1990 [pweight = perwt] if year == 1960, r
eststo d_reg_12

esttab d_reg_7 d_reg_8 d_reg_9, label se keep(female)
esttab  d_reg_12 d_reg_11 d_reg_12, label se keep(white)
//_^
log close
