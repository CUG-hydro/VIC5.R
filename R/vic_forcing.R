
get_J <- function() {
  st <- c(
    getOption('VIC_global_params')[['start_year']],
    getOption('VIC_global_params')[['start_month']],
    getOption('VIC_global_params')[['start_day']]
  )
  ed <- c(
    getOption('VIC_global_params')[['end_year']],
    getOption('VIC_global_params')[['end_month']],
    getOption('VIC_global_params')[['end_day']]
  )
  t1 <- strptime(sprintf("%04d-%02d-%02d", st[1],st[2],st[3]),
                           '%Y-%m-%d')
  t2 <- strptime(sprintf("%04d-%02d-%02d", ed[1],ed[2],ed[3]),
                           '%Y-%m-%d')

  J <- as.double(format(seq(t1, t2, "day"), "%j"))
  J <- rep(J, each = getOption('VIC_global_params')[['snow_step_per_day']])
  J
}

cal_lw <- function(temp, vp, rsds, lat, J) {
  # Calc s
  lat <- lat * pi/360
  dr <- 1 + 0.033 * cos(pi * J/182.5)
  delta <- 0.408 * sin(pi * J/182.5 - 1.39)
  ws <- acos(-tan(lat) * tan(delta))
  Ra <- 0.75 * 435.023 * dr * (ws * sin(lat) * sin(delta) + cos(lat) *
                            cos(delta) * sin(ws))

  nstep <- getOption('VIC_global_params')[['snow_step_per_day']]
  if(nstep > 1) {
    dim(rsds) <- c(length(rsds)/nstep, nstep)
    rsds <- rep(rowMeans(rsds), nstep)
  }
  s <- rsds / Ra

  # Calc emissivity
  ec <- 0.23 + 0.848* (vp/10/(temp + 273.15))**0.14286 # Konzelmann et al.
  e <- 1-s + s*ec

  # Calc longwave radiation

  e*5.6696e-8* (temp + 273.15) ** 4
}

get_forclen <- function() {
  st <- c(
    getOption('VIC_global_params')[['start_year']],
    getOption('VIC_global_params')[['start_month']],
    getOption('VIC_global_params')[['start_day']]
  )
  ed <- c(
    getOption('VIC_global_params')[['end_year']],
    getOption('VIC_global_params')[['end_month']],
    getOption('VIC_global_params')[['end_day']]
  )
  t1 <- as.double(strptime(sprintf("%04d-%02d-%02d", st[1],st[2],st[3]),
                           '%Y-%m-%d'))
  t2 <- as.double(strptime(sprintf("%04d-%02d-%02d", ed[1],ed[2],ed[3]),
                           '%Y-%m-%d'))
  ((t2 - t1)/86400 + 1) *
    getOption('VIC_global_params')[['snow_step_per_day']]
}

get_out_nrec <- function(st, ed, freq, aggstep = 1) {
  nrec <- -1
  if(freq == "year") {
    nrec <- ed[1] - st[1] + 1
  }else if(freq == "month"){
    nrec <- (ed[1] - st[1])*12 + ed[2]-st[2] + 1
  }else if(freq == "step"){
    return(-1)
  }else if(freq %in% c("date", "end")) {
    return(1)
  } else {
    t1 <- as.double(strptime(sprintf("%04d-%02d-%02d", st[1],st[2],st[3]),
                             '%Y-%m-%d') + st[4])
    t2 <- as.double(strptime(sprintf("%04d-%02d-%02d", ed[1],ed[2],ed[3]),
                             '%Y-%m-%d') + 86400)
    td <- t2 - t1
    if(freq == "second") {
      nrec <- td
    }else if(freq == "minute") {
      nrec <- td / 60
    }else if(freq == "hour") {
      nrec <- td / 3600
    }else if(freq == "day") {
      nrec <- td / 86400
    }
  }
  nrec = nrec %/% aggstep
  return(nrec)
}

deal_output_info <- function(output) {
  st <- c(
    getOption('VIC_global_params')[['start_year']],
    getOption('VIC_global_params')[['start_month']],
    getOption('VIC_global_params')[['start_day']],
    getOption('VIC_global_params')[['start_sec']]
  )
  ed <- c(
    getOption('VIC_global_params')[['end_year']],
    getOption('VIC_global_params')[['end_month']],
    getOption('VIC_global_params')[['end_day']]
  )
  for(i in 1:length(output)) {
    if(is.null(output[[i]]$aggtypes))
      output[[i]]$aggtypes <- -1

    if(is.null(output[[i]]$aggpar) & output[[i]]$timescale == 'date')
      stop('"aggpar" must be set to date type when "timescale" is set to "date".')

    if(is.null(output[[i]]$aggpar))
      output[[i]]$aggpar <- 1
    output[[i]]$nrow <- get_out_nrec(st, ed, output[[i]]$timescale,
                                     output[[i]]$aggpar)

  }
  return(output)
}
