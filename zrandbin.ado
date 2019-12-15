program zrandbin, rclass byable(recall) 
	version 7, missing
	syntax name  if [, FREQ(integer 10)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	qui replace `varlist'=-uniform() `if'
	sort `varlist'
	qui replace `varlist'=1 `if'  & _n<=`freq'
	qui replace `varlist'=0 `if' &  _n>`freq' 
end
