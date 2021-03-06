###############################################################
#                                                             #
#   (c) Victor Maus <vwmaus1@gmail.com>                       #
#       Institute for Geoinformatics (IFGI)                   #
#       University of Muenster (WWU), Germany                 #
#                                                             #
#       Earth System Science Center (CCST)                    #
#       National Institute for Space Research (INPE), Brazil  #
#                                                             #
#                                                             #
#   R Package dtwSat - 2015-09-01                             #
#                                                             #
###############################################################

.onAttach = function(lib, pkg){
  packageStartupMessage(
    sprintf("Loaded dtwSat v%s. See ?dtwSat for help, citation(\"dtwSat\") for use in publication.\n",
            utils::packageDescription("dtwSat")$Version) )
  
  ## Register TWDTW as a distance function into package proxy
  twdtwProxyRegister()
}

#' @import zoo 
#' @import raster
#' @import ggplot2
#' @import methods
#' @import rgdal 
#' @import snow 
#' @importFrom proxy dist pr_DB
#' @importFrom reshape2 melt
#' @importFrom scales pretty_breaks date_format percent
#' @importFrom grDevices terrain.colors gray.colors
#' @importFrom plyr alply
#' @importFrom sp Polygon Polygons SpatialPoints SpatialPolygons SpatialPointsDataFrame over CRS spTransform coordinates bbox 
#' @importFrom mgcv gam predict.gam 
#' @importFrom RColorBrewer brewer.pal 
#' @importFrom stats xtabs ave window na.omit sd qnorm 
#' @importFrom lubridate month month<- day day<- year year<-
#' @importFrom caret createDataPartition 
#' @importFrom xtable xtable print.xtable
#' @importFrom utils packageDescription flush.console 
#' @useDynLib dtwSat, .registration = TRUE
#' 
NULL


### Import and export functions from other packages

#' @importFrom dtw symmetric1
#' @export 
dtw::symmetric1

#' @importFrom dtw symmetric2 
#' @export 
dtw::symmetric2

#' @importFrom dtw asymmetric 
#' @export 
dtw::asymmetric

#' @importFrom dtw rabinerJuangStepPattern 
#' @export 
dtw::rabinerJuangStepPattern
