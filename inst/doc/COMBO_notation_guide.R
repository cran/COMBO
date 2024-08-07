## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)

## -----------------------------------------------------------------------------
Term <- c("$X$", "$Z$", "$Y$", "$y_{ij}$", "$Y^*$", "$y^*_{ik}$",
          "True Outcome Mechanism", "Observation Mechanism",
          "$\\pi_{ij}$", "$\\pi^*_{ikj}$", "$\\pi^*_{ik}$", "$\\pi^*_{jj}$",
          "Sensitivity", "Specificity",
          "$\\beta_X$", "$\\gamma_{11Z}$", "$\\gamma_{12Z}$")
Definition <- c("--", "--",
                "$Y \\in \\{1, 2\\}$", "$\\mathbb{I}\\{Y_i = j\\}$",
                "$Y^* \\in \\{1, 2\\}$", "$\\mathbb{I}\\{Y^*_i = k\\}$",
                "$\\text{logit} \\{ P(Y = j | X ; \\beta) \\} = \\beta_{j0} + \\beta_{jX} X$",
                "$\\text{logit}\\{ P(Y^* = k | Y = j, Z ; \\gamma) \\} = \\gamma_{kj0} + \\gamma_{kjZ} Z$",
                "$P(Y_i = j | X ; \\beta) = \\frac{\\text{exp}\\{\\beta_{j0} + \\beta_{jX} X_i\\}}{1 + \\text{exp}\\{\\beta_{j0} + \\beta_{jX} X_i\\}}$",
                "$P(Y^*_i = k | Y_i = j, Z ; \\gamma) = \\frac{\\text{exp}\\{\\gamma_{kj0} + \\gamma_{kjZ} Z_i\\}}{1 + \\text{exp}\\{\\gamma_{kj0} + \\gamma_{kjZ} Z_i\\}}$",
                "$P(Y^*_i = k | Y_i, X, Z ; \\gamma) = \\sum_{j = 1}^2 \\pi^*_{ikj} \\pi_{ij}$",
                "$P(Y^* = j | Y = j, Z ; \\gamma) = \\sum_{i = 1}^N \\pi^*_{ijj}$",
                "$P(Y^* = 1 | Y = 1, Z ; \\gamma) = \\sum_{i = 1}^N \\pi^*_{i11}$",
                "$P(Y^* = 2 | Y = 2, Z ; \\gamma) = \\sum_{i = 1}^N \\pi^*_{i22}$",
                "--", "--", "--")
Description <- c("Predictor matrix for the true outcome.",
                 "Predictor matrix for the observed outcome, conditional on the true outcome.",
                 "True binary outcome. Reference category is 2.",
                 "Indicator for the true binary outcome.",
                 "Observed binary outcome. Reference category is 2.",
                 "Indicator for the observed binary outcome.",
                 "Relationship between $X$ and the true outcome, $Y$.",
                 "Relationship between $Z$ and the observed outcome, $Y^*$, given the true outcome $Y$.",
                 "Response probability for individual $i$'s true outcome category.",
                 "Response probability for individual $i$'s observed outcome category, conditional on the true outcome.",
                 "Response probability for individual $i$'s observed outcome cateogry.",
                 "Average probability of correct classification for category $j$.",
                 "True positive rate. Average probability of observing outcome $k = 1$, given the true outcome $j = 1$.",
                 "True negative rate. Average probability of observing outcome $k = 2$, given the true outcome $j = 2$.",
                 "Association parameter of interest in the true outcome mechanism.",
                 "Association parameter of interest in the observation mechanism, given $j=1$.",
                 "Association parameter of interest in the observation mechanism, given $j=2$.")

notation_table <- data.frame(Term, Definition, Description)

## ----results = "asis"---------------------------------------------------------
library(xtable)
xtable_notation <- xtable(notation_table)
print(xtable(notation_table), type = "html", include.rownames=FALSE)

