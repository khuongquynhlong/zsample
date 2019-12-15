*! version 4.1.0  16mar2007
program zesampsi, rclass 
	version 7, missing
	gettoken m2 0 : 0, parse(" ,")
	confirm number `m2'
	syntax  [, OR(real 3)  RR(real -1) POWER(real 0.90) ALPHA(real 0.05) Ratio(real 1) noCONTInuity ]
	di 
	if `rr'>0 {
	local m1=`m2'*`rr'
	} 
	else {
	local m1=(`m2'*`or')/(1+`m2'*(`or'-1))
	}

	if "`continuity'"==""{
	qui sampsi `m1' `m2' , power(`power') alpha(`alpha') ratio(`ratio')
	}
	else{
	qui sampsi `m1' `m2' , power(`power') alpha(`alpha') ratio(`ratio') noconti
	}
	di in green "Assumptions:"
	di in green "                                 alpha =     "  in yel `alpha'
	di in green "                                 power =     "  in yel `power'
	if `rr'>0 {
	di in green "                 Risk among non-expose =     ", in yel `m2'
	di 
	di in green "Estimated required samples size for cohort study with RR=",`rr'
	di in green "            Number of exposed =     "  in yel r(N_1)
	di in green "          Number of unexposed =     "  in yel r(N_2)
	} 
	else {
	di in green "  Proportion of exposed among controls =     "  in yel `m2'
	di 
	di in green "Estimated required sample sizes for case-control study with OR=",`or'
	di in green "              Number of cases =     "  in yel r(N_1)
	di in green "           Number of controls =     "  in yel r(N_2)
	}
									
end
