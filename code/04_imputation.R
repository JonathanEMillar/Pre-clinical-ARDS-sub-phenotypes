#===============================================================================
# CELTIC model analysis
# Imputation
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(missRanger)
library(psych)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic <- read_csv("./data/celtic_6hrs.csv")

#   ____________________________________________________________________________
#   imputation                                                              ####

##  using missRanger pkg - chained random forests and predictive mean matching.
##  pmm.k = number of candidate non-missing values to to sample in the pmm step.
##  using all variables except Group to impute all missing variables.
##  https://doi.org/10.1093/bioinformatics/btr597

celtic_imptd <- missRanger(celtic,
	formula = . ~ . -Group,
	pmm.k = 20,
	maxiter = 500,
	seed = 1984,
	verbose = 2,
	returnOOB = TRUE)

#   ____________________________________________________________________________
#   comparing imputed vs. non-imputed datasets                              ####

celtic_i <- celtic_imptd %>%
	mutate(imp = ifelse(is.na(Sheep_ID), NA, "Yes"))

celtic_ni <- celtic %>%
	mutate(imp = ifelse(is.na(Sheep_ID), NA, "No"))

celtic_c <- rbind(celtic_ni, celtic_i)

add_stats <- celtic_c %>%
	select(-c(1:3))

describeBy(add_stats, group = celtic_c$imp, quant = c(0.25, 0.75))


#   ____________________________________________________________________________
#   write to csv                                                            ####

# write_csv(celtic_imptd, "./data/celtic_6hrs_imputed.csv")

#==============================================================================
p
