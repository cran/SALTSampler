\name{TriPlot}
\alias{TriPlot}
\title{Plots MCMC Samples on a 3-Simplex}

\description{This function plots samples from a 3-simplex projected into two dimensions. If \code{sumStat} is true, numerical summaries are also plotted on the graph. In particular, the theoretical mean is calculated under the assumption that the initial values entered by the user for \code{center} in the \code{runMh} function are correct. For type \code{'dirichlet'} the theoretical mode is also calculated under the assumption that the initial values entered by the user for \code{center} in the \code{runMh} function are correct. These values are plotted along with the samples in the projected space. }

\usage{
TriPlot(mhOut, sumStat = FALSE)
}

\arguments{
  \item{mhOut}{Output of the \code{RunMh} function}
  \item{sumStat}{Boolean indicating whether or not summary statistics should be plotted on the graph}
}

\note{If two or more parameter values are near zero, this plot may not be useful.  In such cases, all samples may overlap in a single corner of the triangle, limiting the useful visual information provided by this plot.}

\examples{
#Dirichlet triangle plot
dir <- RunMh(center = c(0.7, 0.2, 0.1), B = 2e3, concentration = 10,
                        h = c(2, 2, 2), type = 'dirichlet', dat = NULL)
TriPlot(mhOut = dir, sumStat = TRUE)
}
