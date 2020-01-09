test_that("donlp2 requires argument \"fn\"", {
  expect_error(donlp2(), "argument \"fn\" is missing, with no default")
})

test_that("simple", {
  p <- c(-10,10)
  par.l <- c(0,0); par.u <- c(100,100)
  lin.u <- 1; lin.l <- 1
  A <- t(c(1,1))
  fn <- function(x){
    x[1]^2+x[2]^2
  }
  ret <- donlp2(p, fn, par.lower=par.l, par.upper=par.u,A=A,lin.u=lin.u,lin.l=lin.l,name="simple")
  expect_match(ret$message, "KT-conditions satisfied, no further correction computed")
})


test_that("simple2", {
  p <- c(10,10)
  par.l <- c(-100,-100); par.u <- c(100,100)
  nlin.l <- nlin.u <- 2
  A <- t(c(1,1))
  fn <- function(x){
    x[1]^2+x[2]^2
  }
  dfn <- function(x){
    c(2*x[1], 2*x[2])
  }
  nlcon <- function(x){
    x[1]*x[2]
  }
  dnlcon <- function(x){
    c(x[2], x[1])
  }
  # without gr
  ret <- donlp2(p, fn, par.u=par.u, par.l=par.l,nlin=list(nlcon),nlin.u=nlin.u,nlin.l=nlin.l,name="simple2")
  expect_match(ret$message,"KT-conditions satisfied, no further correction computed")
  # with gr
  #attr(fn, "gr") <- dfn
  #attr(nlcon, "gr") <- dnlcon
  #ret <- donlp2(p, fn, par.u=par.u, par.l=par.l,nlin=list(nlcon),nlin.u=nlin.u,nlin.l=nlin.l,name="simple2")
})