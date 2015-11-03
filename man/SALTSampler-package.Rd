\name{SALTSampler-package}
\alias{SALTSampler-package}
\alias{SALTSampler}
\docType{package}
\title{Efficient Sampling on the Simplex}

\description{The SALTSampler package facilitates Monte Carlo Markov Chain (MCMC) sampling of random variables on a simplex. A Self-Adjusting Logit Transform (SALT) proposal is used so that sampling is still efficient even in difficult cases, such as those in high dimensions or with parameters that differ by orders of magnitude. Special care is also taken to maintain accuracy even when some coordinates approach 0 or 1 numerically. Diagnostic and graphic functions are included in the package, enabling easy assessment of the convergence and mixing of the chain within the constrained space. }

\details{
\tabular{ll}{
Package: \tab SALTSampler\cr
Type: \tab Package\cr
Version: \tab 0.1\cr
Date: \tab 2015-08-15\cr
License: \tab BSD_3_clause + file LICENSE
}

The main function for this package is \code{runMh}. Using user-defined information, \code{runMh} conducts MCMC on a simplex and outputs an object of class \code{mhRun}. The function can be used with any target distribution on the simplex defined by the user.  Alternatively, two common posteriors types are built into the function and can be specifed by the user. For type \code{'dirichlet'}, \code{mhRun} produces MCMC samples from a specified dirichlet distribution and for type \code{'multinomial'}, \code{mhRun} uses data to sample the distributional parameters of a multinomial distribution. Additionally, the functions \code{Diagnostics} and \code{TriPlot} can be used to analyze the output of \code{mhRun}.
}

\author{Hannah Director, Scott Vander Wiel, Jim Gattiker}


\examples{
###Dirichlet sampling in 3-simplex 
dir <- RunMh(center = c(0.7, 0.2, 0.1), B = 2e3, concentration = 10,
                        h = c(2, 2, 2), type = 'dirichlet', dat = NULL)
Diagnostics(mhOut = dir)
TriPlot(mhOut = dir)

####Multinomial sampling                  
\dontrun{
sampData <- GenData(center = c(0.2, 0.3, 0.5), n = 100, size = 10)
multinom <- RunMh(center = c(0.2, 0.3, 0.5), B = 1e4, h = c(2,2,2), 
                  type = 'multinom', dat = sampData)
Diagnostics(mhOut = multinom)
TriPlot(mhOut = multinom)
}

####User-defined target distribution for a calibration problem 
\dontrun{
#Known function which we want to calibrate
CalibFn <- function(y, logit = FALSE) {
  if (logit == TRUE) {
    y <- exp(LogPq(y)$logp)
  }
  out <- 1e3*y[1]^3*y[2]^3/sqrt(20 + y[3])
  return(out)
}

#Generated data 
z <- rnorm(n = 1000, mean = CalibFn(c(1/3, 1/3, 1/3), 2))

#User defined target distribution
Target <- function(ycand, ycurrent, a, dat, pars = NULL) {
  out <- sum(dnorm(z, CalibFn(ycand, logit = TRUE), 2, log = TRUE)) - 
    sum(dnorm(z, CalibFn(ycurrent, logit = TRUE), 2, log = TRUE)) + 
    sum((a - 1)*(LogPq(ycand)$logp - LogPq(ycurrent)$logp))
  return(out)
} 

#Run sampler
inputDist <- RunMh(center = c(1/3, 1/3, 1/3), B = 3e4, concentration = 3, 
                   h = c(0.2, 0.2, 0.2), type = 'user', dat = z)
Diagnostics(mhOut = inputDist)
TriPlot(mhOut = inputDist)
}
}
