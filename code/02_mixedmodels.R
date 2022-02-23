#===============================================================================
# CELTIC model analysis
# Repeated measures mixed models
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(lme4)
library(rstatix)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic_long <- read_csv("./data/celtic_long.csv")

#   ____________________________________________________________________________
#   order and convert to factors                                            ####

celtic_long$Timepoint <- factor(celtic_long$Timepoint, levels = c(
  "base", "0hrs", "1hrs", "2hrs",
  "4hrs", "6hrs"
))

celtic_long <- celtic_long %>%
  mutate(
    Variable = as.factor(Variable),
    Sheep_ID = as.numeric(Sheep_ID)
  )

#   ____________________________________________________________________________
#   create variable subsets                                                 ####

variable_sets <- list()

variables <- unique(celtic_long$Variable)
for (i in variables) {
  variable_sets[[i]] <- celtic_long %>%
    filter(Variable == i) %>%
    select(-Variable) %>%
    as.data.frame()
}

names(variable_sets) <- variables

list2env(variable_sets, envir = .GlobalEnv)

#   ____________________________________________________________________________
#   fit model                                                               ####

## mixed model with intercept allowed to vary by animal
## fit for each variable set of interest

celtic_mixed_model <- function(data){
  lmer(Value ~ Group*Timepoint + (1|Sheep_ID), data = data)
}

#   ____________________________________________________________________________
#   model summaries and post-hoc comparisons                                ####

## model <- celtic_mixed_model(data)

summary <- tidy(Anova(model, type = "III"))

## Tukey's honestly significant difference test
data %>%
  group_by(Timepoint) %>%
  tukey_hsd(Value~Group, p.adjust.method = "fdr")

#==============================================================================

