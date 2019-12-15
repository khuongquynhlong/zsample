*! version 4.1.0  16mar2007
program zrand, rclass byable(recall) 
	version 7, missing
	syntax name [if]  [, Mean(real 0.0)  SD(real 1.0) Error(real 0.1) Step(real 1) MIN(real 0) NOevent(integer 0)]
	local varlist `namelist'
	capture confirm numeric variable `varlist'
	if _rc{
	gen `varlist'=.
	}
	qui count `if'
	local total=r(N)	
	local N 	local freq r(N)
	if `noevent'==0 {
	local noevent `total'
	}
	local ratio2=(`noevent'/`total')
	local ratio1=(`total'/`noevent')^(0.9)
	qui sum `varlist' `if'
	qui count `if'
	local no=r(N)
 	while (round( r(mean),`error')!=`mean') | (round( r(sd),`error')!=`sd')  {
	 	qui replace `varlist'=round(`mean' * `ratio1'+`sd'* invnormal(uniform())*`ratio2',`step') `if'
		sort `varlist'
		qui replace `varlist'=0 `if' &  _n<(`total'-`noevent') 
	 	qui replace `varlist'=`min' `if' & `varlist'<`min'
 	   	 sum `varlist' `if'
	}
end
