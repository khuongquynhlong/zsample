*! version 4.1.0  16mar2007
program zrandomize, rclass 
// Permuted block randomization
// zrandomize thuoc, n(100) b(0) 'single
// zrandomize thuoc, n(100) b(8) 'fixed block
// zrandomize thuoc, n(100) b(-1) 'random block
// zrandomize thuoc, n(100)  b(100)
	version 7, missing
	syntax namelist(min=2 max=2) [, Nsubject(integer 30)  Block(integer 0)]
	tokenize `namelist'
	local NEWDRUG `1'
	local PLACEBO `2'
	
	local i =1
	if `block'==0 {
	local A=0
	local B=0
		while `i'<=`nsubject' {
		if (uniform()>=0.5) {
		di in blue `i' _col(10) "`NEWDRUG'" 
		local A=`A'+1
		}
		else {
		di in yel `i' _col(10) "`PLACEBO'"
		local B=`B'+1
		}
		local i=`i'+1
		}
		di in white "==========================="
		di in white "Total" _col(10) `A' "  `NEWDRUG'"
	}
	else {
	while `i'<=`nsubject' {
		local j=1 
		if `block'==-1 {
		local blocksize=2+int(uniform()*5)*2
		}
		else {
			local blocksize=`block'		
		}
		if `blocksize'+`i'> `nsubject' {
		local blocksize=`nsubject'-`i'+1
		}
		di in white _col(5) "blocksize: " `blocksize'
		local A=0
		local B=0
		while `j' <=`blocksize' {
		if (`B'>=`blocksize'/2) | (`A'<`blocksize'/2 & uniform()>=0.5) {
		local A=`A'+1
		di in blue `i' _col(10) "`NEWDRUG'" 
		}
		else {
		local B=`B'+1
		di in yel `i' _col(10) "`PLACEBO'"
		}
		local i=`i'+1
		local j=`j'+1
		}
	}	
	}
end
