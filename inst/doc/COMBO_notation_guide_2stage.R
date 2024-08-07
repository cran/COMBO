## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)

## -----------------------------------------------------------------------------
Term <- c("$X$", "$Z^{(1)}$", "$Z^{(2)}$",
          "$Y$", "$y_{ij}$",
          "$Y^{*(1)}$", "$y^{*(1)}_{ik}$",
          "$Y^{*(2)}$", "$y^{*(2)}_{i \\ell}$",
          "True Outcome Mechanism", "First-Stage Observation Mechanism",
          "Second-Stage Observation Mechanism",
          "$\\pi_{ij}$","$\\pi^{*(1)}_{ikj}$", "$\\pi^{*(2)}_{i \\ell kj}$",
          "$\\pi^{*(1)}_{ik}$", 
          "$\\pi^{*(1)}_{jj}$", "$\\pi^{*(2)}_{jjj}$",
          "First-Stage Sensitivity", "First-Stage Specificity",
          "$\\beta_X$", "$\\gamma^{(1)}_{11Z^{(1)}}$", "$\\gamma^{(1)}_{12Z^{(1)}}$",
          "$\\gamma^{(2)}_{111Z^{(2)}}$", "$\\gamma^{(2)}_{121Z^{(2)}}$",
          "$\\gamma^{(2)}_{112Z^{(2)}}$", "$\\gamma^{(2)}_{122Z^{(2)}}$")
Definition <- c("--", "--", "--",
                "$Y \\in \\{1, 2\\}$", "$\\mathbb{I}\\{Y_i = j\\}$",
                "$Y^{*(1)} \\in \\{1, 2\\}$", "$\\mathbb{I}\\{Y^{*(1)}_i = k\\}$",
                "$Y^{*(2)} \\in \\{1, 2\\}$", "$\\mathbb{I}\\{Y^{*(2)}_i = \\ell \\}$",
                "$\\text{logit} \\{ P(Y = j | X ; \\beta) \\} = \\beta_{j0} + \\beta_{jX} X$",
                "$\\text{logit}\\{ P(Y^{*(1)} = k | Y = j, Z^{(1)} ; \\gamma^{(1)}) \\} = \\gamma^{(1)}_{kj0} + \\gamma^{(1)}_{kjZ^{(1)}} Z^{(1)}$",
                "$\\text{logit}\\{ P(Y^{*(2)} = \\ell | Y^{*(1)} = k, Y = j, Z^{(2)} ; \\gamma^{(2)}) \\} = \\gamma^{(2)}_{\\ell kj0} + \\gamma^{(2)}_{\\ell kjZ^{(2)}} Z^{(2)}$",
                "$P(Y_i = j | X ; \\beta) = \\frac{\\text{exp}\\{\\beta_{j0} + \\beta_{jX} X_i\\}}{1 + \\text{exp}\\{\\beta_{j0} + \\beta_{jX} X_i\\}}$",
                "$P(Y^{*(1)}_i = k | Y = j, Z^{(1)} ; \\gamma^{(1)}) = \\frac{\\text{exp}\\{\\gamma^{(1)}_{kj0} + \\gamma^{(1)}_{kjZ^{(1)}} Z_i^{(1)}\\}}{1 + \\text{exp}\\{\\gamma^{(1)}_{kj0} + \\gamma^{(1)}_{kjZ^{(1)}} Z_i^{(1)}\\}}$",
                "$P(Y^{*(2)}_i = \\ell | Y^{*(1)} = k, Y = j, Z^{(2)} ; \\gamma^{(2)}) = \\frac{\\text{exp}\\{\\gamma^{(2)}_{\\ell kj0} + \\gamma^{(2)}_{\\ell kjZ^{(2)}} Z_i^{(2)}\\}}{1 + \\text{exp}\\{\\gamma^{(2)}_{\\ell kj0} + \\gamma^{(2)}_{\\ell kjZ^{(2)}} Z_i^{(2)}\\}}$",
                "$P(Y^{*(1)}_i = k | X, Z^{(1)} ; \\gamma^{(1)}) = \\sum_{j = 1}^2 \\pi^{*(1)}_{ikj} \\pi_{ij}$",
                "$P(Y^{*(1)} = j | Y = j, Z^{(1)} ; \\gamma^{(1)}) = \\sum_{i = 1}^N \\pi^{*(1)}_{ijj}$",
                "$P(Y^{*(2)} = j | Y^{*(1)}_i = j, Y = j, Z^{(2)} ; \\gamma^{(2)}) = \\sum_{i = 1}^N \\pi^{*(2)}_{ijjj}$",
                "$P(Y^{*(1)} = 1 | Y = 1, Z^{(1)} ; \\gamma^{(1)}) = \\sum_{i = 1}^N \\pi^{*(1)}_{i11}$",
                "$P(Y^{*(1)} = 2 | Y = 2, Z^{(1)} ; \\gamma^{(1)}) = \\sum_{i = 1}^N \\pi^{*(1)}_{i22}$",
                "--", "--", "--", "--", "--", "--", "--")
Description <- c("Predictor matrix for the true outcome.",
                 "Predictor matrix for the first-stage observed outcome, conditional on the true outcome.",
                 "Predictor matrix for the second-stage observed outcome, conditional on the true outcome and first-stage observed outcome.",
                 "True binary outcome. Reference category is 2.",
                 "Indicator for the true binary outcome.",
                 "First-stage observed binary outcome. Reference category is 2.",
                 "Indicator for the first-stage observed binary outcome.",
                 "Second-stage observed binary outcome. Reference category is 2.",
                 "Indicator for the second-stage observed binary outcome.",
                 "Relationship between $X$ and the true outcome, $Y$.",
                 "Relationship between $Z^{(1)}$ and the first-stage observed outcome, $Y^{*(1)}$, given the true outcome $Y$.",
                 "Relationship between $Z^{(2)}$ and the second-stage observed outcome, $Y^{*(2)}$, given the first-stage observed outcome, $Y^{*(1)}$, and the true outcome $Y$.",
                 "Response probability for individual $i$'s true outcome category.",
                 "Response probability for individual $i$'s first-stage observed outcome category, conditional on the true outcome.",
                 "Response probability for individual $i$'s second-stage observed outcome category, conditional on the first-stage observed outcome and the true outcome.",
                 "Response probability for individual $i$'s first-stage observed outcome cateogry.",
                 "Average probability of first-stage correct classification for category $j$.",
                 "Average probability of first-stage and second-stage correct classification for category $j$.",
                 "True positive rate. Average probability of observing first-stage outcome $k = 1$, given the true outcome $j = 1$.",
                 "True negative rate. Average probability of observing first-stage outcome $k = 2$, given the true outcome $j = 2$.",
                 "Association parameter of interest in the true outcome mechanism.",
                 "Association parameter of interest in the first-stage observation mechanism, given $j=1$.",
                 "Association parameter of interest in the first-stage observation mechanism, given $j=2$.",
                 "Association parameter of interest in the second-stage observation mechanism, given $k = 1$ and $j = 1$.",
                 "Association parameter of interest in the second-stage observation mechanism, given $k = 2$ and $j = 1$.",
                 "Association parameter of interest in the second-stage observation mechanism, given $k = 1$ and $j = 2$.",
                 "Association parameter of interest in the second-stage observation mechanism, given $k = 2$ and $j = 2$.")

notation_table <- data.frame(Term, Definition, Description)

## ----results = "asis"---------------------------------------------------------
library(xtable)
xtable_notation <- xtable(notation_table)
print(xtable(notation_table), type = "html", include.rownames=FALSE)

