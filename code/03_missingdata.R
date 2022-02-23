#===============================================================================
# CELTIC model analysis
# Missing data
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(naniar)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic <- read_csv("./data/celtic_wide.csv")

#   ____________________________________________________________________________
#   missing data tabular summaries                                          ####

missing.summary <- naniar::miss_summary(cm)
	missing.summary$miss_case_table # number of variables missing per case
	missing.summary$miss_var_table # number of cases missing per variable
	missing.summary$miss_var_summary # variables ranked by number/% missing

#   ____________________________________________________________________________
#   upset plot                                                              ####

miss.upset <- gg_miss_upset(cm,
	nsets = 50,
	nintersects = NA,
	order.by = c("freq", "degree"),
	decreasing = c(TRUE,FALSE))

#==============================================================================
