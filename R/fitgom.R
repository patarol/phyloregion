#' Fits Grade of membership models for biogeographic regionalization
#'
#' This function generates grade of membership, “admixture”,
#' “topic” or “Latent Dirichlet Allocation” models, for
#' clustering regions based on attributes.
#'
#' @param counts A matrix of multinomial response counts in
#' ncol(counts) phrases/categories for nrow(counts)
#' documents/observations. It can also be a simple matrix.
#' @param K The number of latent topics. If length(K)>1,
#' topics will find the Bayes factor (vs a null single topic model)
#' for each element and return parameter estimates for the highest
#' probability K.
#' @param shape Optional argument to specify the Dirichlet prior
#' concentration parameter as shape for topic-phrase probabilities.
#' Defaults to 1/(K*ncol(counts)). For fixed single K, this can also
#' be a ncol(counts) by K matrix of unique shapes for each topic element.
#' @param initopics Optional start-location for \eqn{[\theta_1, \ldots, \theta_K]}, the
#' topic-phrase probabilities. Dimensions must accord with the smallest
#' element of K. If NULL, the initial estimates are built by incrementally
#' adding topics.
#' @param tol An indicator for whether or not to calculate the Bayes factor
#' for univariate K. If length(K)>1, this is ignored and Bayes factors are
#' always calculated.
#' @param bf An indicator for whether or not to calculate the Bayes factor
#' for univariate K. If length(K)>1, this is ignored and Bayes factors are
#' always calculated.
#' @param kill For choosing from multiple K numbers of topics (evaluated
#' in increasing order), the search will stop after kill consecutive drops
#' in the corresponding Bayes factor. Specify kill=0 if you want Bayes factors
#' for all elements of K.
#' @param ord If \code{TRUE}, the returned topics (columns of theta) will
#' be ordered by decreasing usage (i.e., by decreasing \code{colSums(omega)}).
#' @param verb A switch for controlling printed output. verb > 0 will
#' print something, with the level of detail increasing with verb.
#' @param \dots Further arguments passed to or from other methods.
#' @rdname fitgom
#' @keywords bioregion
#' @importFrom maptpx topics
#' @return An topics object list with entries
#' \itemize{
#'   \item \code{K} The number of latent topics estimated. If input
#'   \code{length(K)>1}, on output this is a single value corresponding to
#'   the model with the highest Bayes factor.
#'   \item \code{theta} The ncol{counts} by K matrix of estimated
#'   topic-phrase probabilities.
#'   \item \code{omega} The nrow{counts} by K matrix of estimated
#'   document-topic weights.
#'   \item \code{BF} The log Bayes factor for each number of topics
#'   in the input K, against a null single topic model.
#'   \item \code{D} Residual dispersion: for each element of K, estimated
#'   dispersion parameter (which should be near one for the multinomial),
#'   degrees of freedom, and p-value for a test of whether the true dispersion
#'   is >1.
#'   \item \code{X} The input count matrix, in dgTMatrix format.
#' }
#' @export
fitgom <- function(counts, K, shape = NULL, initopics = NULL, tol = 0.1,
                      bf = TRUE, kill = 2, ord = TRUE, verb = 1, ...) {
    res <- topics(counts, K, shape = shape, initopics = initopics, tol = tol,
                  bf = bf, kill = kill, ord = ord, verb = verb, ...)
    return(res)
}
