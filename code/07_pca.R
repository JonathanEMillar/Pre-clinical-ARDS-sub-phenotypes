#===============================================================================
# CELTIC model analysis
# Principal component analysis
#===============================================================================
# Author: JE Millar
# Date: 2020-11-04
# Version: 2.0
# [R version 4.0.3]
#===============================================================================

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(tidyverse)
library(FactoMineR)
library(factoextra)
library(corrplot)
library(RColorBrewer)
library(cowplot)

#   ____________________________________________________________________________
#   set seed                                                                ####

set.seed(1984)

#   ____________________________________________________________________________
#   load data                                                               ####

celtic <- read_csv("./data/celtic_6hrs_imputed.csv")
celtic_clustered <- read_csv("celtic_6hrs_clustered.csv")

#   ____________________________________________________________________________
#   subset data                                                             ####

celtic_pca <- celtic %>%
  select(-c(Sheep_ID, Group, Weight, Fluid_input))

#   ____________________________________________________________________________
#   examine outliers                                                        ####

##  using Hampel filter

upper.boundary <- function(x) {
	upper_bound <- median(x) + 3 * mad(x)
	return(upper_bound)
}

lower.boundary <- function(x) {
	lower_bound <- median(x) - 3 * mad(x)
	return(lower_bound)
}

apply(celtic_pca, 2, upper.boundary)
apply(celtic_pca, 2, lower.boundary)

outliers <- function(x) {
	upper_bound <- upper.boundary(x)
	lower_bound <- lower.boundary(x)
	outlier_ind <- which(x < lower_bound | x > upper_bound)
	return(outlier_ind)
}

apply(celtic_pca, 2, outliers)

#   ____________________________________________________________________________
#   scale dataset                                                           ####

##  centered by subtracting variable mean and scaled by dividing by variable
##  standard deviation

celtic_pca <- as.matrix(celtic_pca)

celtic_pca_scale <- celtic_pca %>%
	scale(center = TRUE, scale = TRUE)

#   ____________________________________________________________________________
#   pca                                                                     ####

##  using FactoMineR package
##  https://cran.r-project.org/web/packages/FactoMineR/index.html

celtic_pca_res <- PCA(celtic_pca_scale,
	ncp = 8,
	scale.unit = FALSE,
	graph = FALSE)

summary(celtic_pca_res,
	ncp = 8)

#   ____________________________________________________________________________
#   scree plot                                                              ####

fviz_eig(celtic_pca_res,
	ncp = 8,
	addlabels = FALSE,
	choice = "variance",
	barfill = "white",
	barcolor = "darkblue",
	linecolor = "red") +
scale_y_continuous(limits = c(0,50), breaks = seq(0,50,5), expand = c(0,0)) +
theme_classic()

#   ____________________________________________________________________________
#   quality of representation                                               ####

var <- get_pca_var(celtic_pca_res)

col <- brewer.pal(n = 9, name = "RdBu")

corrplot(var$cos2,
	is.corr = FALSE,
	method = "color",
	col = col)

#   ____________________________________________________________________________
#   contribution of variables                                               ####

corrplot(var$contrib,
	is.corr = FALSE,
	method = "color",
	col = col)

#   ____________________________________________________________________________
#   biplot                                                                  ####

celtic_clustered$Cluster <- as.numeric(celtic_clustered$Cluster)

fviz_pca_biplot(celtic_pca_res,
	axes = c(1,2),
	geom.ind = "point",
	fill.ind = celtic_clustered$Group,
	col.ind = "black",
	pointshape = 21,
	pointsize = 5,
	palette = palette,
	addEllispses = FALSE,
	repel = TRUE,
	col.var = "contrib",
	alpha.var = "contrib",
	select.var = list(contrib = 5),
	gradient.cols = "RdYlBu")

#==============================================================================
