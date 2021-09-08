# VIC5 0.2.2

- This package is the new generation of `VICmodel`, which is withdrawed from cran
  due to warnings in Linux system. This time, we solved those warnings.

- Routing function was removed from this package, as this package is mainly
  aimed to interface with the VIC hydrological model in C language.

- add the function `vic_params`, which makes VIC global parameter setting much easier.

- In Linux system, we get a warning that sub-directories of 1Mb or more: libs
  6.0Mb. This problem is unable to solve, because VIC is huge hydrological
  model and large lib is expected.

- This package has been reviewed by Julia Haider <julia.haider@wu.ac.at>. We have fixed all the issues raised by her: 

(1). Please write the title of the references in the description text in quotes: "Title"

Reply: The reference in the Description has been modified correspondingly.

(2). Please add \value to .Rd files regarding exported methods and explain the
functions results in the documentation. Please write about the structure of the
output (class) and also what the output means. (If a function does not return a
value, please document that too, e.g. \value{No return value, called for side
effects} or similar) Missing Rd-tags: vic_param.Rd: \value vic_version.Rd:
\value. Please fix and resubmit.

Reply: The return value of vic_param and vic_param has been documented this
time: "No return value. Set global options for VIC model".
