*! version 4.1.0  16mar2007
program zrandnorm, rclass byable(recall) 
	version 6, missing
	syntax name [if]  [, Mean(real 0.0)  SD(real 1.0) Error(real 0.1) Step(real 1) MIN(real 0)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	qui sum `varlist' `if'
 	while (round( r(mean),`error')!=`mean') | (round( r(sd),`error')!=`sd') | r(min)<`min' | r(N)==0 {
	 	qui replace `varlist'=round(`mean'+`sd'* invnormal(uniform()),`step') `if'
	   	qui sum `varlist' `if'
	}
end
	