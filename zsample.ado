*! version 4.1.0  16mar2007
program zsample, rclass 
// zssampsi, proportion(0.5) error(0.05) design(1)
	version 7, missing
	syntax  [, P(integer 50)  N(integer 10) 
	preserve
	clear
	set obs `N'
	gen id=_n
	sample `n',count
	list id
	restore
end
