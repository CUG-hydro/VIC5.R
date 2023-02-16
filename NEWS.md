# 0.2.6

- change `sprintf` to `snprintf`

# 0.2.5

- suppress `-Wno-strict-prototypes` and `-Wno-deprecated-non-prototype` warnings

# 0.2.4

- add `XAJ` Hydrology model

# 0.2.1

- This package is the next generation of `VICmodel`, which is withdrawed from cran
  due to warnings in Linux system. This time, we solved those warnings.

- Routing function was removed from this package, as this package is mainly
  aimed to interface with the VIC hydrological model in C language.

- add the function `vic_params`, which makes VIC global parameter setting much easier.
