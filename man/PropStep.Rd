\name{PropStep}
\alias{PropStep}

\title{Draw a Proposal on a Simplex}

\description{Given a logit-scaled simplex point \eqn{y}, this function draws a new logit-scaled simplex point. For a specified element, \eqn{i}, a new point is drawn with Gaussian standard deviation \eqn{h}. Then all other elements are rescaled such that they remain on the simplex. The returned value also includes a detailed balance term, \code{dbt}, as an attribute. }

\usage{
PropStep(y, i, h)
}


\arguments{
  \item{y}{Vector of simplex points on the logit scale
}
  \item{i}{Index value for the coordinate in the simplex point vector that should be modified initially
}
  \item{h}{Gaussian standard deviation for the proposal distribution
}
}

\value{
\item{dbt}{Detailed balance term}
}

\examples{
  #Propose new step from y = c(0.2, 0.3, 0.5)
  y <- c(0.2, 0.3, 0.5)
  PropStep(y = Logit(y), i = 1, h = c(2, 2, 2))
}

