#===============================================================================
# CELTIC model analysis
# Data pre-processing
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic_wide <- read_csv("./data/celticmaster.csv") %>%
  mutate(
    Sheep_ID = as.character(Sheep_ID),
    Group = as.factor(Group)
  )

#   ____________________________________________________________________________
#   create long format                                                      ####

celtic_long <- celtic_wide %>%
  select(-c(
    Weight, Vt, Min_vol_6hrs, Fluid_input, Ur_output,
    Cumulative_balance
  )) %>%
  pivot_longer(
    cols = c(FiO2_base:CK_6hrs),
    names_to = c("Variable", "Timepoint"),
    names_sep = "_",
    names_ptype = list(Timepoint = factor()),
    values_to = "Value"
  )

#   ____________________________________________________________________________
#   create subset of data at 6 hours                                        ####

celtic_6hrs <- celtic_wide %>%
  select(-ends_with(c("_base", "_0hrs", "_1hrs", "_2hrs", "_4hrs")))

#   ____________________________________________________________________________
#   write to csv                                                            ####

# write_csv(celtic_wide, "./data/celtic_wide.csv")
#
# write_csv(celtic_long, "./data/celtic_long.csv")
#
# write_csv(celtic_6hrs, "./data/celtic_6hrs.csv")

#===============================================================================
