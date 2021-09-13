test_that("vic works", {
  #Sample data, with 16 gridcells and 10 day hourly meteorological forcing inputs
  skip_on_os("solaris")
  
  data(STEHE)
  forcing <- STEHE$forcing
  soil <- STEHE$soil
  veg <- STEHE$veg
  
  # vic_param("start_year", 1949)
  # vic_param("start_month", 1)
  # vic_param("start_day", 1)
  # vic_param("end_year", 1949)
  # vic_param("end_month", 1)
  # vic_param("end_day", 10)
  # vic_param("step_per_day", 24)
  # vic_param("snow_step_per_day", 24)
  # vic_param("runoff_step_per_day", 24)
  
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
    wb = list(
      timescale = "hour", aggpar = 6,
      outvars = c("OUT_RUNOFF", "OUT_BASEFLOW", "OUT_SOIL_MOIST"),
      aggtypes = c("sum", "sum", "end")
    ),
    eb = list(
      timescale = "day", aggpar = 1,
      outvars = c("OUT_SWE", "OUT_SOIL_TEMP"),
      aggtypes = c("avg", "min")
    )
  )
  # Run the VIC model
  # same warning as VICmodel
  outputs <- vic(forcing, soil, veg, output_info = out_info)
  # print(outputs$eb)

  y = round(outputs$eb$OUT_SOIL_TEMP_3[, "86800"], 4)
  y0 = c(-7.268, -13.1966, -13.7111, -13.5647, -12.6622, -9.4101, -9.3787, 
    -13.0782, -17.2095, -17.1139) # the OUTPUT from RuiDa version
  expect_true(max(abs((y - y0))) < 1e-4)
})
