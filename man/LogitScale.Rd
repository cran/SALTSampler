\name{LogitScale}
\alias{LogitScale}

\title{Finds logit(sp) }

\description{For \eqn{x=logit(p)} and \eqn{l=log(s)}, this function returns \eqn{logit(sp)}.}

\usage{
LogitScale(x, l)
}

\arguments{
  \item{x}{\eqn{Logit(p)} where \eqn{p} is a vector of probabilities
  }
  \item{l}{\eqn{Exp(s)} where \eqn{0 \leq s \leq 1/\sum p_i} to produce a well-defined return value.
  }
}

\examples{
#Calculates logit(xl) for p = (0.4, 0.3):
#x = (Logit(0.4), Logit(0.3)) and l = 0.7
LogitScale(x = Logit(c(0.4, 0.3)), l = 0.7)
}

