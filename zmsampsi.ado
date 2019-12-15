*! version 4.1.0  16mar2007
program zmsampsi, rclass 
// zssampsi, proportion(0.5) error(0.05) design(1)
// zblockrand thuoc, n(100) b(8)
// zblockrand thuoc, n(100) 
// zblockrand thuoc, n(100)  b(100)
	version 7, missing
	syntax  [, SD (real 1) Error(real 0.1) Level(real 95) Designeffect(real 1)]
local alpha=1-`level'/100
di in green "Estimated sample size for estimating mean from a descriptive study"
di 
di in green "Assumptions:"
di in green "                    SD = " in ye _col(20) %6.4g `sd'
di in green "        Marginal Error = " in ye _col(20) %6.4g `error'
di in green "                 Alpha = " in ye  _col(20) %6.4g `alpha'
di in green "   Level of confidence = " in ye  _col(20) %6.1g `level' "%"
di 
di in green "Estimated required sample size:"
di
di in green "                     n = " in ye  _col(20) %6.0f int(`designeffect' * (invnorm(1-`alpha'/2) * `sd'/`error')^2 + 0.99)
end
