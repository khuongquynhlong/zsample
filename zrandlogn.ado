*! version 4.1.0  16mar2007
program zrandlogn, rclass byable(recall) 
	version 7, missing
	syntax name [if]  [, Mean(real 0.0)  SD(real 1.0) Error(real 0.1) Step(real 1) MIN(real 0)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	qui sum `varlist' `if'
	local lnsd ln((`mean'+`sd')/(`mean'-`sd'))/2
	local lnmean ln(sqrt((`mean'+`sd'/2)*(`mean'-`sd'/2)))
	di exp(`lnmean')
 	while (round( r(mean),`error')!=`mean') | (round( r(sd),`error')!=`sd') | r(min)<`min' |r(N)==0 {
	 	qui replace `varlist'=round(exp(`lnmean'+`lnsd'* invnormal(uniform())),`step') `if'
	   	qui sum `varlist' `if'
	}
end
