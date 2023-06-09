% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/label_switch_2stage.R
\name{label_switch_2stage}
\alias{label_switch_2stage}
\title{Fix Label Switching in MCMC Results from a Binary Outcome Misclassification Model}
\usage{
label_switch_2stage(chain_matrix, dim_x, dim_z, dim_v, n_cat)
}
\arguments{
\item{chain_matrix}{A numeric matrix containing the posterior samples for all
parameters in a given MCMC chain. \code{chain_matrix} must be a named
object (i.e. each parameter must be named as \code{beta[j, p]}, \code{gamma[k,j,p]},
or \code{delta[l,k,j,p]}).}

\item{dim_x}{An integer specifying the number of columns of the design matrix of the true outcome mechanism, \code{X}.}

\item{dim_z}{An integer specifying the number of columns of the design matrix of the first-stage observation mechanism, \code{Z}.}

\item{dim_v}{An integer specifying the number of columns of the design matrix of the second-stage observation mechanism, \code{V}.}

\item{n_cat}{An integer specifying the number of categorical values that the true outcome, \eqn{Y},
the first-stage observed outcome, \eqn{Y^*}, and the second-stage observed
outcome \eqn{\tilde{Y}} can take.}
}
\value{
\code{label_switch_2stage} returns a named matrix of MCMC posterior samples for
all parameters after performing label switching according the following pattern:
all \eqn{\beta} terms are multiplied by -1, all \eqn{\gamma} and \eqn{\delta} terms are "swapped"
with the opposite \code{j} index.
}
\description{
Fix Label Switching in MCMC Results from a Binary Outcome Misclassification Model
}
