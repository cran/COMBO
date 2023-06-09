#' Compute Conditional Probability of Each Second-Stage Observed Outcome Given Each True Outcome and First-Stage Observed Outcome, for Every Subject
#'
#'  Compute the conditional probability of observing second-stage outcome \eqn{\tilde{Y} \in \{1, 2 \}} given
#'  the latent true outcome \eqn{Y \in \{1, 2 \}} and the first-stage outcome \eqn{Y^* \in \{1, 2\}} as
#'  \eqn{\frac{\text{exp}\{\delta_{\ell kj0} + \delta_{\ell kjV} V_i\}}{1 + \text{exp}\{\delta_{\ell kj0} + \delta_{\ell kjV} V_i\}}}
#'  for each of the \eqn{i = 1, \dots,} \code{n} subjects.
#'
#' @param delta_array A numeric array of estimated regression parameters for the
#'   observation mechanism, \eqn{\tilde{Y} | Y*, Y} (second-stage observed outcome,
#'   given the first-stage observed outcome and the true outcome)
#'   ~ \code{V} (second-stage misclassification predictor matrix). Rows of the array
#'   correspond to parameters for the \eqn{\tilde{Y} = 1} observed outcome, with the
#'   dimensions of \code{v_matrix}. Columns of the array correspond to the first-stage
#'   outcome categories \eqn{k = 1, \dots,} \code{n_cat}. The third stage of the array
#'   corresponds to the true outcome categories \eqn{j = 1, \dots,} \code{n_cat}.
#'   The array should be obtained by \code{COMBO_EM} or \code{COMBO_MCMC}.
#' @param v_matrix A numeric matrix of covariates in the second-stage observation mechanism.
#'   \code{v_matrix} should not contain an intercept.
#'
#' @return \code{misclassification_prob2} returns a dataframe containing five columns.
#'   The first column, \code{Subject}, represents the subject ID, from \eqn{1} to \code{n},
#'   where \code{n} is the sample size, or equivalently, the number of rows in \code{v_matrix}.
#'   The second column, \code{Y}, represents a true, latent outcome category \eqn{Y \in \{1, 2 \}}.
#'   The third column, \code{Ystar}, represents a first-stage observed outcome category \eqn{Y^* \in \{1, 2 \}}.
#'   The fourth column, \code{Ytilde}, represents a second-stage observed outcome category \eqn{\tilde{Y} \in \{1, 2 \}}.
#'   The last column, \code{Probability}, is the value of the equation
#'   \eqn{\frac{\text{exp}\{\delta_{\ell kj0} + \delta_{\ell kjV} V_i\}}{1 + \text{exp}\{\delta_{\ell kj0} + \delta_{\ell kjV} V_i\}}}
#'   computed for each subject, first-stage observed outcome category, second-stage
#'   observed outcome category, and true, latent outcome category.
#'
#' @include pitilde_compute.R
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' set.seed(123)
#' sample_size <- 1000
#' cov1 <- rnorm(sample_size)
#' cov2 <- rnorm(sample_size, 1, 2)
#' v_matrix <- matrix(c(cov1, cov2), nrow = sample_size, byrow = FALSE)
#' estimated_deltas <- array(c(1, -1, .5, .2, -.6, 1.5,
#'                             -1, .5, -1, -.5, -1, -.5), dim = c(3,2,2))
#' P_Ytilde_Ystar_Y <- misclassification_prob2(estimated_deltas, v_matrix)
#' head(P_Ytilde_Ystar_Y)
misclassification_prob2 <- function(delta_array,
                                   v_matrix){

  n_cat = 2
  sample_size = nrow(v_matrix)

  if (is.data.frame(v_matrix))
    v_matrix <- as.matrix(v_matrix)
  if (!is.numeric(v_matrix))
    stop("'v_matrix' should be a numeric matrix.")

  if (is.vector(v_matrix))
    v_matrix <- as.matrix(v_matrix)
  if (!is.matrix(v_matrix))
    stop("'v_matrix' should be a matrix or data.frame.")

  V = matrix(c(rep(1, sample_size), c(v_matrix)),
             byrow = FALSE, nrow = sample_size)

  subject = rep(1:sample_size, n_cat * n_cat)
  Y_categories = rep(1:n_cat, each = sample_size * n_cat * n_cat)
  Ystar_categories = rep(c(1:n_cat, 1:n_cat), each = sample_size * n_cat)
  Ytilde_categories = rep(rep(1:n_cat, each = sample_size), n_cat * n_cat)
  pitilde_array = pitilde_compute(delta_array, V, sample_size, n_cat)
  pitilde_df = data.frame(Subject = subject,
                          Y = Y_categories,
                          Ystar = Ystar_categories,
                          Ytilde = Ytilde_categories,
                          Probability = c(pitilde_array))

  return(pitilde_df)
}
