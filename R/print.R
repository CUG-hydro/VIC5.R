#' @rdname vic
#' @export
print.vic_output <- function(x, ...) {
  sedate <- x$global_options[
    c("start_year", "start_month", "start_day", "end_year", "end_month", "end_day")
  ]
  stpd <- x$global_options$step_per_day
  stpd <- ifelse(stpd == 1, "daily", sprintf("%d hourly", 24 / stpd))
  cat(sprintf(
    "VIC model run from %d-%d-%d to %d-%d-%d at %s timescale.\n",
    sedate[[1]], sedate[[2]], sedate[[3]],
    sedate[[4]], sedate[[5]], sedate[[6]], stpd
  ))

  c1 <- "Number of soil layers: "
  c2 <- x$global_options$nlayers

  c1 <- c(c1, "Number of elevation bands: ")
  c2 <- c(c2, x$global_options$nbands)

  c1 <- c(c1, "Use lake mode: ")
  c2 <- c(c2, c("False", "True")[x$global_options$lakes + 1])

  c1 <- c(c1, "Use full energy balance mode: ")
  c2 <- c(c2, c("False", "True")[x$global_options$full_energy + 1])

  c1 <- c(c1, "Use frozen soil mode: ")
  c2 <- c(c2, c("False", "True")[x$global_options$frozen_soil + 1])

  c1 <- c(c1, "Baseflow mode: ")
  c2 <- c(c2, c("ARNO", "NIJSSEN2001")[x$global_options$baseflow + 1])

  c1 <- c(c1, "Snow density mode: ")
  c2 <- c(c2, c("SNTHRM", "DENS_BRAS")[x$global_options$snow_den + 1])

  pt <- cbind(c1, c2)
  dimnames(pt) <- list(rep("", dim(pt)[1]), rep("", dim(pt)[2]))
  print(pt, quote = F)

  cat("----------------------------------------------------------------\n")

  otables <- names(x)
  otables <- otables[1:(length(otables) - 3)]

  cat(sprintf("%d output tables: ", length(otables)))
  cat(paste(sprintf("\"%s\"", otables), collapse = ", "))
  cat(".\n")

  for (i in 1:length(otables)) {
    name <- otables[i]
    if (x$output_info[[name]]$timescale == "never") {
      ots <- "is set to never output"
    } else if (x$output_info[[name]]$timescale == "step") {
      ots <- paste("outputs", stpd)
    } else if (x$output_info[[name]]$timescale == "date") {
      ots <- format(x$output_info[[name]]$aggpar, "outputs at %Y-%m-%d")
    } else {
      ots <- sprintf(
        "outputs per %d %s",
        x$output_info[[name]]$aggpar,
        x$output_info[[name]]$timescale
      )
    }

    cat(sprintf("- Table \"%s\":\n", name))
    cat(sprintf(
      "  %s, has %d output variables:\n    ",
      ots, length(x[[name]])
    ))
    cat(sprintf("%s\n", paste(names(x[[name]]), collapse = ", ")))
  }
  cat("\n----------------------------------------------------------------\n")
  cat("Time table:\n")
  print(x$timetable, quote = F)
}
