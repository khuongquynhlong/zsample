*! version 4.1.0  16mar2007
program zpblockrand, rclass 
// Permuted block randomization
// zpblockrand thuoc, n(100) b(0) 'single
// zpblockrand thuoc, n(100) b(8) 'fixed block
// zpblockrand thuoc, n(100) b(-1) 'random block
// zpblockrand thuoc, n(100)  b(100)
	version 7, missing
	syntax [name] [, Nsubject(integer 30)  Block(integer 0)]
	if "`namelist'" =="" {
	local namelist="active"
	} 
	local i =1
	if `block'==0 {
	local A=0
	local B=0
		while `i'<=`nsubject' {
		if (uniform()>=0.5) {
		di `i' _col(10) "`namelist'" 
		local A=`A'+1
		}
		else {
		di `i' _col(10) "Placebo"
		local B=`B'+1
		}
		local i=`i'+1
		}
		di "Total" _col(10) `A' "  `namelist'"
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
		di _col(5) "blocksize: " `blocksize'
		local A=0
		local B=0
		while `j' <=`blocksize' {
		if (`B'>=`blocksize'/2) | (`A'<`blocksize'/2 & uniform()>=0.5) {
		local A=`A'+1
		di `i' _col(10) "`namelist'" 
		}
		else {
		local B=`B'+1
		di `i' _col(10) "Placebo"
		}
		local i=`i'+1
		local j=`j'+1
		}
	}	
	}
end
