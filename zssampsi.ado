*! version 4.1.0  16mar2007
program zssampsi, rclass 
// zssampsi, proportion(0.5) error(0.05) design(1)
// zblockrand thuoc, n(100) b(8)
// zblockrand thuoc, n(100) 
// zblockrand thuoc, n(100)  b(100)
	version 7, missing
	syntax  [, Proportion(real 0.5)  Error(real 0.05) Designeffect(real 1)]
di in green "Estimated sample size for estimating proportion from a descriptive study"
di 
di in green "Assumptions:"
di in green "                     p = " in ye _col(20) %6.4f `proportion'
di in green"        Marginal error = " in ye _col(20) %6.4f `error'
di in green"         Design effect = " in ye  _col(20) %6.4f `designeffect'
di 
di in green "Estimated required sample size:"
di
di in green "                     n = " in ye  _col(20) %6.0f int(`designeffect' * 1.96^2*`proportion'*(1-`proportion')/`error'^2 + 0.99)
end
