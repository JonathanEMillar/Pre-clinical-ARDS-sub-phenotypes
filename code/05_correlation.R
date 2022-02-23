#===============================================================================
# CELTIC model analysis
# Correlation
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(corrplot)
library(RColorBrewer)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic <- read_csv("./data/celtic_6hrs_imputed.csv")

#   ____________________________________________________________________________
#   correlation plot                                                        ####

##  ............................................................................
##  wrangling                                                               ####

celtic <- celtic %>%
  select(-c(Sheep_ID, Group)) %>%
  as.data.frame()

M <- cor(celtic,
  use = "na.or.complete",
  method = "spearman"
)

Mp <- cor.mtest(celtic, conf.level = .95)

##  ............................................................................
##  plot                                                                    ####

cor.plot <- corrplot::corrplot(M,
  p.mat = Mp$p,
  type = "full",
  diag = FALSE,
  method = "color",
  col = brewer.pal(n = 10, name = "RdYlBu"),
  sig.level = 0.05,
  insig = "blank",
  order = "original"
)

#==============================================================================
