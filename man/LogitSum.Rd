\name{LogitSum}
\alias{LogitSum}

\title{Log of the Sum of Probabilities}

\description{
For \eqn{x=logit(p)}, this function returns \eqn{s = log(\sum p)} where the sum of \eqn{p} is less than or equal to 1. Calculations are designed to preserve accuracy even for values numerically near 0 or 1.}

\usage{
LogitSum(x)
}

\arguments{
  \item{x}{A vector of probabilites whose sum is less than or equal to 1
}
}

\examples{
#Find logit sum for a single value
LogitSum(x = 0.1)

#Find logit sum for a vector of values
LogitSum(x = c(0.1, 0.4, 0.2))
}
