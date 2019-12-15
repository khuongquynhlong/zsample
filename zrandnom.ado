program zrandnom, rclass byable(recall) 
	version 7, missing
	syntax name  if [, FREQ(integer 10)  cut(numlist)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	numlist "`cut'"
	display "`r(numlist)'"
	di `cut'
	qui replace `varlist'=-uniform() `if'
	sort `varlist'
	qui replace `varlist'=1 `if'  & _n<=`freq'
	qui replace `varlist'=0 `if' &  _n>`freq' 
end
