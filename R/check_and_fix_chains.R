#' Check Assumption and Fix Label Switching if Assumption is Broken for a List of MCMC Samples
#'
#' @param n_chains An integer specifying the number of MCMC chains to compute over.
#' @param chains_list A numeric list containing the samples from \code{n_chains}
#'   MCMC chains.
#' @param pistarjj_matrix A numeric matrix of the average
#'   conditional probability \eqn{P(Y^* = j | Y = j, Z)} across all subjects for
#'   each MCMC chain, obtained from the \code{pistar_by_chain} function.
#' @param dim_x The number of columns of the design matrix of the true outcome mechanism, \code{X}.
#' @param dim_z The number of columns of the design matrix of the observation mechanism, \code{Z}.
#' @param n_cat The number of categorical values that the true outcome, \code{Y},
#'   and the observed outcome, \code{Y*} can take.
#'
#' @return \code{check_and_fix_chains} returns a numeric list of the samples from
#'   \code{n_chains} MCMC chains which have been corrected for label switching if
#'   the following assumption is not met: \eqn{P(Y^* = j | Y = j, Z) > 0.50 \forall j}.
#'
#' @include label_switch.R
#'
check_and_fix_chains <- function(n_chains, chains_list, pistarjj_matrix,
                                 dim_x, dim_z, n_cat){
  fixed_output_list <- list()
  for(i in 1:n_chains){
    pistar11 = pistarjj_matrix[i, 1]
    pistar22 = pistarjj_matrix[i, 2]

    flip_pistar11 = 1 - pistar22
    flip_pistar22 = 1 - pistar11

    J = pistar11 + pistar22 - 1
    J_flip = flip_pistar11 + flip_pistar22 - 1

    output = if(J_flip <= J){
      chains_list[[i]]
    } else {label_switch(chains_list[[i]],
                         dim_x, dim_z, n_cat)}
    fixed_output_list[[i]] = output
  }
  return(fixed_output_list)
}
