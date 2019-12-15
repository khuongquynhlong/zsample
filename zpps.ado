*! version 4.1.0  16mar2007
program zpps, rclass byable(recall) sortpreserve
/// use "C:\DATA\pps_Ninh Thuan.dta", replace
/// zpps tenthon sokhau tenxa if 1, c(3) r(1314)
///use "E:\CDMedStat\Statistic softwares\Stata data\pps_Bennette.dta", replace 
/// zpps community popsize, c(3) r(1816)
	version 7, missing
	syntax varlist(min=2 max=3) [if] [in] [fw] [, Cluster(integer 10) Random(real 0.0)]
	preserve
	marksample touse, strok
	tokenize `varlist'
	local psu `1'
	local pop  `2'
	if "`3'"=="" {
	tempvar stt
	qui gen `stt'=_n
	}
	else {
	local stt `3'
	}
	gsort -`touse'  `stt'
	tempvar id
	qui gen `id'=_n if `touse'
	qui count if `touse'
	local rN=r(N)
	tempvar cusum
	qui  gen `cusum'=`pop'[1] if `touse'
	qui replace `cusum'=`pop'[_n]+`cusum'[_n-1] if _n>=2 &  `touse'
	local samplinginterval=`cusum'[`rN']/`cluster'
	if `random'==0.0{
	local random=uniform()*`samplinginterval'
	} 
	else {
	local random=mod(`random',`samplinginterval')
	} 
	di `random'
	local i=1
	di "stt" _col(10)  "random No"  _col(24)  "_n"  _col(32) "PSU" _col(48)  "Population" _col(60)  "Cumulative"
	while `i'<=`cluster' {
	qui count if `random'>`cusum'
	di `i'  _col(10) %6.1f =`random'   _col(20) %6.0f =`stt'[r(N)+1]   _col(32) `psu'[r(N)+1] _col(48)  %6.0fc `pop'[r(N)+1]  _col(60)  %6.0fc `cusum'[r(N)+1]
	local random=`random'+`samplinginterval'
	local i=`i'+1
	}
	qui 	sum `cusum'
	qui sum `pop'
	restore
end

