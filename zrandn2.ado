*! version 4.1.0  16mar2007
program zrandn2, rclass byable(recall) 
	version 7, missing
	syntax name [if]  [, Mean(real 0.0)  SD(real 1.0) Error(real 0.1) Step(real 1) MIN(real 0) MAX(real  10000) FREQ(integer 0)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	qui sum `varlist' `if'
	qui count `if'
	local no=r(N)
	local coef=1
	tempvar var1
	gen `var1'=.
	replace `varlist'=round(`mean'/`coef'+`coef'*`sd'* invnormal(uniform()),`step') `if'
	replace `varlist'=`min' `if' & `varlist'<`min'
 ///	while  ( round(r(mean),`error')!=`mean')  |  (round( r(sd),`error')!=`sd' )   {
	while  ( int( (r(mean)-`mean')  /`error' )!=0)  | ( int( (r(sd)-`sd')  /`error' )!=0)  {
		qui sum `varlist' `if'
		local D1=(`mean'-r(mean))*`no'
		local D2=(`sd'^2-r(sd)^2)*`no'
///		di `D1'
		if round(r(mean),`error') != `mean' {
		local where=`mean'- (`D2'/`D1')/2
		qui replace `var1'=(`varlist'-`where')^2 `if'
		sort `var1'
		replace `varlist'=`varlist'+sign(`D1')*`step' if _n<=abs(`D1'/`step')
		replace `varlist'=`min' `if' & `varlist'<`min'
		replace `varlist'=`max' `if' & `varlist'>`max'
		} else
		{
///		di `D2' "d2"
			local where=`varlist'[uniform()*`no']
			qui replace `var1'=-(`varlist'-`where')^2 `if'
			sort `var1'
			replace `varlist'=`varlist' + sign(`D2')*`step' *sign(`varlist'-`mean') if _n<=abs(`D2'*2/`where'/`step')
		}
 	   	qui sum `varlist' `if'
	}
end




