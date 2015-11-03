\name{Diagnostics}
\alias{Diagnostics}

\title{Plots and Summaries of RunMh Output}

\description{Taking in a \code{mhOut} object, this function outputs graphs and summaries to evaluate the performance of an MCMC run on a simplex. In particular, the acceptance rate is outputted for each dimension along with a trace plot. For type \code{'dirichlet'}, qqplots of the theoretical versus empirical marginal distributions are also provided for each dimension.}

\usage{
Diagnostics(mhOut)
}

\arguments{
  \item{mhOut}{Object outputted by the function \code{RunMH} which summarizes a Metropolis Hasting run on a simplex}
}

\examples{
#Dirichlet run and diagnostic plots
dir <- RunMh(center = c(0.7, 0.2, 0.1), B = 2e3, concentration = 10,
                        h = c(2, 2, 2), type = 'dirichlet', dat = NULL)
Diagnostics(mhOut = dir)
}

