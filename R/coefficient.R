#' @title Several metrics to evaluate the accuracy of hydrological modeling
#' @description Calculate several metrics for the evaluating of hydrological
#' modeling accuracy, including the Nash-Sutcliffe coefficient of efficiency
#' (NSE), Logarithmic NSE (log-NSE), relative NSE (rNSE), and relative bias
#' (RB).
#'
#' @param sim Data series to be evaluated, usually are the simulated
#' streamflow of hydrological model.
#' @param obs Data series as benchmark to evaluate `sim`, usually
#' are the observed streamflow.
#'
#' @details
#' The Nash-Sutcliffe coefficient of efficiency (NSE) (Nash and Sutcliffe, 1970)
#' is a widely used indicator of the accuracy of model simulations, or other
#' estimation method with reference to a benchmark series (usually the
#' observations), especially the hydrological modeling.
#'
#' NSE is equal to one minus the normalized mean square error (ratio between
#' the mean square error and the variation of observations):
#'
#' \deqn{NSE=1-\sum(sim-obs)**2/\sum(obs-mean(obs))**2}
#'
#' 1 is the perfect value of NSE, and NSE < 0 indicates that the simulation
#' results are unusable.
#'
#' The conventional NSE is ususlly affected by the accuracy of high values, and
#' would impact the low flow simulation when be taken as the objective function
#' in hydrological model calibration. Therefore, some revised NSE were proposed.
#'
#' Oudin et al. (2006) proposed the log-NSE to increase the sensitivity to the
#' accuracy of low flow simulations:
#'
#' \deqn{log-NSE=1-\sum(log(sim)-log(obs))**2/\sum(log(obs)-log(mean(obs)))**2}
#'
#' Krause et al. (2005) proposed the relative NSE to reduce the impact of the
#' magnitude of data:
#'
#' \deqn{rNSE=1-\sum((sim-obs)obs)**2/\sum((obs-mean(obs))/mean(obs))**2}
#'
#' Relative bias (RB) is used to quantify the relative systematic bias of the
#' simulation results:
#'
#' \deqn{RB=sum(sim)/sum(obs)-1}
#'
#' Positive or negative value of RB indicate the positive or negative bias of
#' simulations respectively. Perfect value of RB is 0.
#'
#' @return The value of NSE, log-NSE, rNSE and RB.
#'
#' @seealso `[Lohmann_UH()]`, `[Lohmann_conv()]`
#'
#' @references
#' Krause, P., Boyle, D. P., and Base, F., 2005, Comparison of different efficiency
#' criteria for hydrological model assessment, Advances in Geoscience, 5, 89-97.
#' doi: 10.5194/adgeo-5-89-2005
#'
#' Nash, J. E., Sutcliffe, J. V., 1970. River flow forecasting through conceptual
#' models part I - A discussion of principles. Journal of Hydrology. 10(3): 282-290.
#' doi:10.1016/0022-1694(70)90255-6
#'
#' Oudin, L., Andreassian, V., Mathevet, T., Perrin, C., Michel, C., 2006. Dynamic
#' averaging of rainfall-runoff model simulations from complementary model
#' parameterizations. Water Resources Research, 42(7). doi: 10.1029/2005WR004636
#'
#' @export
NSE <- function(sim, obs) {
  if(length(sim) != length(obs)) {
    warning("Length of `sim` and `obs` differ.")
    comlen <- min(length(sim), length(obs))
    sim <- sim[comlen]
    obs <- obs[comlen]
  }
  nna <- !is.na(sim) & !is.na(obs)
  if(sum(nna) <= 2) {
    warning("Effective length of `sim` and `obs` is too short.")
    return(NA)
  }
  sim <- sim[nna]
  obs <- obs[nna]
  1 - (sum((obs - sim)**2)/sum((obs - mean(obs))**2))
}


#' @rdname NSE
#' @export
logNSE <- function(sim, obs) {
  if(any(sim <= 0)) {
    warning("Values <= 0 exist in `sim`.")
    return(NA)
  }
  if(any(obs <= 0, na.rm = TRUE)) {
    warning("Values <= 0 exist in `obs`.")
    return(NA)
  }
  NSE(log(sim), log(obs))
}

#' @rdname NSE
#' @export
rNSE <- function(sim, obs) {
  if(length(sim) != length(obs)) {
    warning("Length of `sim` and `obs` differ.")
    comlen <- min(length(sim), length(obs))
    sim <- sim[comlen]
    obs <- obs[comlen]
  }
  nna <- !is.na(sim) & !is.na(obs)
  if(sum(nna) <= 2) {
    warning("Effective length of `sim` and `obs` is too short.")
    return(NA)
  }
  sim <- sim[nna]
  obs <- obs[nna]

  if(any(obs <= 0)) {
    warning("Values <= 0 exist in `obs`.")
    return(NA)
  }
  1 - (sum((sim/obs-1)**2)/sum((obs/mean(obs)-1)**2))
}

#' @rdname NSE
#' @export
RB <- function(sim, obs) {
  if(length(sim) != length(obs)) {
    warning("Length of `sim` and `obs` differ.")
    comlen <- min(length(sim), length(obs))
    sim <- sim[comlen]
    obs <- obs[comlen]
  }
  nna <- !is.na(sim) & !is.na(obs)
  if(sum(nna) < 1) {
    warning("Effective length of `sim` and `obs` is too short.")
    return(NA)
  }

  sum(sim)/sum(obs) - 1
}
