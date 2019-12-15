program zrobust, byable(recall) 
                syntax [varlist] [if] [in] [,detail]
                marksample touse
	parse "`varlist'", parse(" ")

	di in gr ///
"Variable |    Obs    Mean     S.D.   Mean*    S.D.*    S.E.     C.V."  ///
	_n "---------+" _dup(61) "-" 
{
	while "`1'"~="" {
	quietly summ `1'  `in' if `touse', detail
	local mean=r(mean)
	local sd=r(sd)
	local robmean=r(p50)
	tempvar tempv1
	qui gen `tempv1'=abs(`1'-`robmean')
	qui sum `tempv1'  `in' if `touse', detail
	local robsd=r(p50)*1.483
	local oldsd=`sd'
	local delta=abs(`robsd'-`oldsd')
	while `delta'>0.003 {					
	if "`detail'"~="" {
		
		di in yel "`1'" in gr _col(10) "|"  ///
		in yel %7s string(r(N),"%7.0f") ///
	 	_col(19) %7s string(`mean',"%8.0g")  ///
	 	_col(28) %7s string(`sd',"%8.0g")  ///
	 	_col(36) %7s string(`robmean',"%8.0g") ///
	 	_col(45) %7s string(`robsd',"%8.0g") ///
		_col(54) %7s string(`robsd'/sqrt(r(N)),"%8.0g") ///
	 	_col(63) %7s string(`robsd'/`robmean',"%8.0g") 
	local mean=r(mean)
	local sd=r(sd)
	}
	local oldsd=`robsd'
	local out=`robsd'*1.5
	qui replace `tempv1'=`1'
	qui replace `tempv1'=`robmean'-`out' if `tempv1'<`robmean'-`out'
	qui replace `tempv1'=`robmean'+`out' if `tempv1'>`robmean'+`out'
	quietly summ `tempv1'  `in' if `touse'
	local robmean=r(mean)
	local robsd=r(sd)*1.134
	local delta=abs(`robsd'-`oldsd')
	}

		di in yel "`1'" in gr _col(10) "|"  ///
		in yel %7s string(r(N),"%7.0f") ///
	 	_col(19) %7s string(`mean',"%8.0g")  ///
	 	_col(28) %7s string(`sd',"%8.0g")  ///
	 	_col(36) %7s string(`robmean',"%8.0g") ///
	 	_col(45) %7s string(`robsd',"%8.0g") ///
		_col(54) %7s string(`robsd'/sqrt(r(N)),"%8.0g") ///
	 	_col(63) %7s string(`robsd'/`robmean',"%8.0g") 

	mac shift
	}
di
di "Do Van Dung"
}
end


