# VIC5

<!-- badges: start -->
[![R-CMD-check](https://github.com/rpkgs/VIC5/workflows/R-CMD-check/badge.svg)](https://github.com/rpkgs/VIC5/actions)
[![codecov](https://codecov.io/gh/rpkgs/VIC5/branch/master/graph/badge.svg)](https://codecov.io/gh/rpkgs/VIC5)
[![CRAN](http://www.r-pkg.org/badges/version/VIC5)](https://cran.r-project.org/package=VIC5)
<!-- badges: end -->

## Overview

VIC5 is an R implementation of the Variable Infiltration Capacity (VIC) macroscale distributed hydrologic model (Liang et al., 1994) originally developed by Xu Liang at the University of Washington ([UW](http://www.washington.edu/)), USA, and currently the model is maintained by the Computational Hydrology group ([UW Hydro](http://uw-hydro.github.io/)) in the [Department of Civil and Environmental Engineering](https://www.ce.washington.edu/) at UW. This R package is developed by Ruida Zhong, Dongdong Kong, et al. at the Center for Water Resources and Environment, [Sun Yat-sen University](http://www.sysu.edu.cn/) (SYSU). This package is built based on the VIC source code V5.0.1 (Hamman et al., 2018), aim to for the more convinient use for the R users and other users or researchers using windows platform.

The VIC model can simulate several land surface processes physically based on both water balance and energy balance, e.g. Evapotranspiration (on vegetation canopy, vegetation transpiration and soil evaporation), runoff (surface and underground), changes of soil moisture, soil ice and soil temperature of each soil layer, accumulation and melt of snow, sensible and latent heat flux between atmosphere and land surface, streamflow of the basin outlet (needed to be coupled with a runoff routing model), and many other variables. The landsurface parameters (about vegetation, soil, topography) and the timeseries of meteorological data (meteorological forcing, including precipitation, air temperature, incomming shortwave and longwave radiation, wind speed, air pressure and vapor pressure) are necessary inputs to run the VIC model.

For more information about VIC please see the [official documentation website of VIC](http://vic.readthedocs.io/en/master/).

## Installation

You can install VIC5 from github with:

``` r
# Via github
remotes::install_github("rpkgs/VIC5")
```

Or get it from the CRAN repository:

```r
install.packages("VIC5")
```

## References

* Liang, X., D. P. Lettenmaier, E. F. Wood, and S. J. Burges (1994), A simple hydrologically based model of land surface water and energy fluxes for general circulation models, _J. Geophys. Res._, **99**(D7), 14415-14428, [doi:10.1029/94JD00483](http://dx.doi.org/10.1029/94JD00483).

* Hamman, J. J., Nijssen, B., Bohn, T. J., Gergel, D. R., and Mao, Y. (2018), The Variable Infiltration Capacity model version 5 (VIC-5): infrastructure improvements for new applications and reproducibility, _Geosci. Model Dev._, **11**, 3481-3496, [doi:10.5194/gmd-11-3481-2018](http://dx.doi.org/10.5194/gmd-11-3481-2018).

## Example

This is an example to run the VIC model using the sample inputs:

``` r
library(VIC5)
#Sample data, with 16 gridcells and 10 day hourly meteorological forcing inputs
data(STEHE)

forcing <- STEHE$forcing
soil <- STEHE$soil
veg <- STEHE$veg

# Options and settings of the VIC model
vic_params(list(
  date_start = "1949-01-01", 
  date_end = "1949-01-10", 
  step_per_day = 24, 
  snow_step_per_day = 24,
  runoff_step_per_day = 24
))

# Definition of model outputs (output variables, timescale, etc.)
out_info <- list(
  wb = list(timescale = 'hour', aggpar = 6,
            outvars = c('OUT_RUNOFF', 'OUT_BASEFLOW', 'OUT_SOIL_MOIST'),
            aggtypes = c('sum', 'sum', 'end')),
  eb = list(timescale = 'day', aggpar = 1,
            outvars = c('OUT_SWE', 'OUT_SOIL_TEMP'),
            aggtypes = c('avg', 'min'))
)

# Run the VIC model
outputs <- vic(forcing, soil, veg, output_info = out_info)

# Show information of model run and outputs.
print(outputs)
```
