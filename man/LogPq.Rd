\name{LogPq}
\alias{LogPq}
\title{Computes \eqn{log(p)} and \eqn{log(1-p)}}

\description{For \eqn{x = logit(p)}, this function returns \eqn{log(p)} and \eqn{log(1-p)}. Special care is taken to ensure accuracy when coordinates are numerically close to \eqn{0} or \eqn{1}.}

\usage{
LogPq(x)
}
\arguments{
  \item{x}{\eqn{Logit(p)} where \eqn{p} is a vector of probabilites}
}

\examples{
#Find log(p) and log(q) for x = logit(0.2)
a <- log(0.2/(1 - 0.2))
LogPq(x = a)

#Find log(p) and log(q) for x = logit(1e-4)
b <- log(1e-4/(1 - 1e-4))
LogPq(x = b)
}


