\name{GenData}
\alias{GenData}

\title{Synthetic Data From a Multinomial Distribution}

\description{This function generates a synthetic data set representing multiple draws from a multinomial distribution with user-specified parameters. A matrix of \eqn{n} rows corresponding to each draw is outputted where the entry in the ith column and the jth row gives the number of the items that were in the ith bin on the jth trial.}

\usage{
GenData(center, n, size)
}
\arguments{
  \item{center}{Vector of numeric values defining the parameters of a multinomial distribution. The ith value corresponds to the likelihood of a random variable being drawn from the ith bin}
  \item{n}{The \code{n} argument for the \code{rmultinom} function in base R which is defined to be the "number of random vectors to draw"}
  \item{size}{The \code{Size} argument for the \code{rmultinom} function in base R which is defined to be an "integer, say \eqn{N}, specifying the total number of objects that are put into \eqn{K} boxes in the typical multinomial experiment." }
}


\examples{
#Generate sample data from a multinomial distribution
GenData(center = c(0.2, 0.3, 0.5), n = 10, size = 20)
}

\references{
R Core Team (2015). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. \url{https://www.R-project.org/}.

\code{rmultinom}: \url{https://stat.ethz.ch/R-manual/R-patched/library/stats/html/Multinom.html}

}
