#===============================================================================
# CELTIC model analysis
# Clustering
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(cluster)
library(NbClust)
library(fpc)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic <- readRDS("./data/celtic_6hrs_imputed.csv")

#   ____________________________________________________________________________
#   subset data                                                             ####

celtic_cluster <- celtic %>%
	select(-c(Sheep_ID, Group, Weight, Fluid_input))


#   ____________________________________________________________________________
#   scale data                                                              ####

celtic_cluster_scale <- celtic_cluster %>%
	scale(center = TRUE, scale = TRUE)

#   ____________________________________________________________________________
#   optimal cluster number                                                  ####

##  using NbClust function  in NbClust package
##  https://www.rdocumentation.org/packages/NbClust/versions/3.0/topics/NbClust
##  using majority vote of 26 measures of optimal cluster number

NbClust(t(celtic_cluster_scale),
	distance = "euclidean",
	min.nc = 2,
	max.nc = 18,
	method = "kmeans",
	index = "all")

#   ____________________________________________________________________________
#   partitioning around medoids                                             ####

##  https://www.rdocumentation.org/packages/cluster/versions/2.1.0/topics/pam

celtic_pam <- pam(celtic_cluster_scale,
	2,
	diss = FALSE,
	metric = "euclidean",
	stand = FALSE)

#   ____________________________________________________________________________
#   cluster sizes                                                           ####

celtic_pam_tib <- as_tibble(celtic_pam$clustering)

table(celtic_pam_tib)

#   ____________________________________________________________________________
#   summary stats                                                           ####

celtic_clustered <- celtic %>%
	add_column(Cluster = celtic_pam$clustering) %>%
	mutate_at(vars(Sheep_ID, Group, Cluster), list(factor))

celtic_clustered %>%
	split(celtic_clustered$Cluster) %>%
	map(summary)

#   ____________________________________________________________________________
#   diagnostics                                                             ####

##  using clusterboot function in FPC package
##  https://www.rdocumentation.org/packages/fpc/versions/2.1-9/topics/clusterboot
##  1000 resamplings

celtic_boot <- clusterboot(celtic_cluster_scale,
	B = 1000,
	distances = FALSE,
	bootmethod = "boot",
	clustermethod = pamkCBI,
	krange = 2,
	seed = 1984)


#   ____________________________________________________________________________
#   write to csv                                                            ####

write_csv(celtic_clustered, "./data/celtic_6hrs_clustered.csv")

#===============================================================================
