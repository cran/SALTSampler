   \name{Logit}
\alias{Logit}

\title{Logit of a Probability Vector}

\description{Returns the logit of a vector of probabilities, \eqn{p}. When \code{logp} is set to \code{TRUE}, the second argument contains natural logs of probabilities.}

\usage{
Logit(p, logp = FALSE)
}

\arguments{
  \item{p}{Vector of probabilities or log probabilities}
  \item{logp}{Boolean which is \code{FALSE} when the first argument contains probabilities and \code{TRUE} when the first argument contains log probabilities} 
}

\examples{
#Find logit on natural scale
a <- c(0.4, 0.4, 0.1, 0.1)
Logit(p = a)

#Find logit on log scale
b <- c(log(1e-4), log(1e-6), log(1 - 1e-6))
b <- b/sum(b)
Logit(p = b, logp = FALSE)
}
