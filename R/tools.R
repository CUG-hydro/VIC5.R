listk <- function(...) {
  cols <- as.list(substitute(list(...)))[-1]
  vars <- names(cols)
  Id_noname <- if (is.null(vars)) {
    seq_along(cols)
  } else {
    which(vars == "")
  }
  if (length(Id_noname) > 0) {
    vars[Id_noname] <- sapply(cols[Id_noname], deparse)
  }
  x <- setNames(list(...), vars)
  return(x)
}


`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

set_dimnames <- function(x, value) {
  dimnames(x) <- value
  x
}

check_matrix <- function(x) {
  if (is.vector(x)) {
    lake %<>% t()
  } else if (!is.null(x)) {
    x %<>% as.matrix()
  }
  x
}
