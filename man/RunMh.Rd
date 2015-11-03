\name{RunMh}
\alias{RunMh}
\title{Metropolis Hasting Algorithm Constrained on a Simplex}

\description{This function runs the Metropolis Hasting algorithm constrained on a simplex. The function can be used with any target distribution on the simplex defined by the user. Alternatively, two common target distributions are built into the function and can be specifed by the user. The function is designed to continue to perform well in difficult cases, such as those in high dimensions or with parameters that differ by orders of magnitude. Care is also taken to ensure accuracy even when some coordinates are numerically close to 0 or 1.}

\usage{RunMh(center, B, concentration = 1, h, type = 'user', dat = NULL, pars = NULL)
}

\arguments{
  \item{center}{Vector of numeric values summing to 1 that define the center of the distributional parameters of the posterior. For type \code{'dirichlet'}, the parameter \eqn{a} is defined such that  \eqn{a_{i}} is the ith element of \code{center} times \code{concentration}. For type \code{'multinom'}, the multinomial distribution parameter, \eqn{p_{i}}, is the ith value of \code{center}}
  \item{B}{Number of iterations to run the chain}
  \item{concentration}{This argument specifies the concentration parameter where  \eqn{a} is defined such that \eqn{a_{i}} is the ith element of \code{center} times \code{concentration}. This is typically used with type \code{'dirichlet'}, but can also be used in a user-defined function. This arguments defaults to 1, so has no effect if it is not specified.}
  \item{h}{Vector of step sizes. Length of vector must match length of \code{center}}
  \item{type}{Specifies the target distribution. Select  type \code{'user'} if a target distribution has already been defined (see details). Select type \code{'dirichlet'} for a Dirichlet distribution and type \code{'multinom'} for a multinomial distribution }
  \item{dat}{A matrix or vector passing data to the sampler. For type \code{'multinom'}, this is a matrix giving data from repeated multinomial draws where the data is formatted in the same way as data obtained via \code{GenData}. The number of the items in the ith bin on the jth multinomial trial should be in the ith column and the jth row of the matrix. For type \code{'user'}, any matrix or vector of data can be used to match the form specified in the user's target function. If unspecified, this argument defaults to \code{NULL}}
  \item{pars}{A list of additional parameters that can be passed to the user-specified target function for type \code{'user'} if desired. Argument defaults to \code{NULL}}
}

\details{Any target distribution on the simplex can be used with this function by defining a target distribution function in the environment prior to running \code{RunMh}. The function should be named \code{Target} and should take in parameters \code{ycand} and \code{ycurrent}, which are the current and proposed samples on the logit scale, and parameter \code{a}, which is \code{center} times \code{concentration}. Parameters \code{dat} and \code{pars} can be set to \code{NULL}. Alternatively, \code{dat} can be used to provide data to the target function and/or \code{pars} can be used to provide a list of additional parameters to the the target function.  The target function should output the ratio of the log-likelihood of the posterior distribution for the proposal, \eqn{\theta} = \code{ycand}, to the log-likelihood of the posterior for the current value, \eqn{\theta} = \code{ycurrent}. For simple cases, there are built-in target distributions. For type \code{'dirichlet'}, \code{RunMh} uses a Dirichlet distribution as a posterior distribution. For type \code{'multinomial'}, \code{RunMh} samples the distributional parameters of a multinomial distribution that would have generated the data inputted for \code{dat}. }

\value{
An object of class \code{mhOut}. \code{mhOut} has 12 attributes.

  \item{Y}{Matrix of MCMC samples on logit scale}
  \item{S}{Matrix of MCMC samples on true scale}
  \item{runTime}{Summary of the MCMC runtime. The first entry gives the total user CPU time, the second entry gives the system CPU time, and the third entry gives the true elapsed time}
  \item{moveCount}{Number of steps where the proposal value was accepted}
  \item{p}{Length of \code{center} vector}
  \item{center}{Vector of numeric values summing to \eqn{1} that help to define distributional parameters. For type \code{'dirichlet'}, the parameter \eqn{a} is defined such that  \eqn{a_{i}} is the ith element of \code{center} times \code{concentration}. For type \code{'multinom'}, the multinomial distribution parameter, \eqn{p_{i}}, is the ith value of \code{center}}
  \item{B}{Number of iterations to run the chain}
  \item{concentration}{For type \code{'dirichlet'}, this argument specifies the concentration parameter where  \eqn{a} is defined such that \eqn{a_{i}} is the ith element of \code{center} times \code{concentration}. Otherwise, this argument takes on its default value of 1 and has no effect}
  \item{h}{Vector of step sizes. Length of vector must match length of \code{center}}
  \item{type}{Specifies the target distribution. Select  type \code{'user'} if a target distribution has already been defined (see details). Select type \code{'dirichlet'} for a Dirichlet distribution and type \code{'multinom'} for a multinomial distribution}
  \item{dat}{A matrix or vector passing data to the sampler. For type \code{'multinom'}, a matrix giving data from repeated multinomial draws where the data is formatted in the same way as data obtained via \code{GenData}. The number of the items in the ith bin on the jth multinomial trial should be in the ith column and the jth row of the matrix. For type \code{'user'}, any matrix or vector of data can be used to match the form specified in the user's target function. If unspecified, this argument defaults to \code{NULL}}
  \item{a}{Dirichlet distribution parameters, \eqn{a}, where \eqn{a_{i}}, is the ith element of \code{center} times \code{concentration}}
}

\examples{
###Dirichlet sampling in 3-simplex
dir <- RunMh(center = c(0.7, 0.2, 0.1), B = 2e3, concentration = 10,
                        h = c(2, 2, 2), type = 'dirichlet', dat = NULL)
                        
####Multinomial sampling                  
\dontrun{
sampData <- GenData(center = c(0.2, 0.3, 0.5), n = 100, size = 10)
multinom <- RunMh(center = c(0.2, 0.3, 0.5), B = 1e4, h = c(2,2,2), 
                  type = 'multinom', dat = sampData)
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

#Generate data 
z <- rnorm(n = 1000, mean = CalibFn(c(1/3, 1/3, 1/3), 2))

#User defined target distribution
Target <- function(ycand, ycurrent, a, dat, pars = NULL) {
  out <- sum(dnorm(dat, CalibFn(ycand, logit = TRUE), 2, log = TRUE)) - 
    sum(dnorm(dat, CalibFn(ycurrent, logit = TRUE), 2, log = TRUE)) + 
    sum((a - 1)*(LogPq(ycand)$logp - LogPq(ycurrent)$logp))
  return(out)
} 

#Run sampler
inputDist <- RunMh(center = c(1/3, 1/3, 1/3), B = 3e4, concentration = 3, 
                   h = c(0.2, 0.2, 0.2), type = 'user', dat = z)
}
}