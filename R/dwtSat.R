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
#   R Package dtwSat - 2016-07-14                             #
#                                                             #
###############################################################

#' @title Time-Weighted Dynamic Time Warping for Satellite Image Time Series 
#' @name dtwSat
#' @author Victor Maus, \email{vwmaus1@@gmail.com}
#' 
#' @description Provides an implementation of the Time-Weighted Dynamic Time Warping 
#' (TWDTW) method for land use and land cover mapping using satellite image time series [1]. 
#' TWDTW is based on the Dynamic Time Warping technique and has achieved high accuracy 
#' for land use and land cover classification using satellite data. The method is based 
#' on comparing unclassified satellite image time series with a set of known temporal 
#' patterns (e.g. phenological cycles associated with the vegetation). Using 'dtwSat' 
#' the user can build temporal patterns for land cover types, apply the TWDTW analysis 
#' for satellite datasets, visualize the results of the time series analysis, produce 
#' land cover maps, and create temporal plots for land cover change analysis.
#' 
#'
#' @references 
#' [1] Maus  V,  Camara  G,  Cartaxo  R,  Sanchez  A,  Ramos  FM,  de Queiroz, GR.
#' (2016). A Time-Weighted Dynamic Time Warping method for land use and land cover 
#' mapping. Selected Topics in Applied Earth Observations and Remote Sensing, 
#' IEEE Journal of, vol.PP, no.99, pp.1-11.
#' 
#' @seealso \code{\link[dtwSat]{twdtwApply}}
#' 
#' define the dependencies of the dtwSat package
#' @import lattice
#' 
NULL


#' @title TWDTW distance proxy register 
#' @name twdtwProxyRegister
#' @author Victor Maus, \email{vwmaus1@@gmail.com}
#' 
#' @description This function performs a multidimensional Time-Weighted DTW 
#' analysis and retrieves the matches between the temporal patterns and 
#' a set of time series [1].
#' 
#' @details Register TWDTW as a distance function into package proxy
#' 
#' @return NULL
#' 
#' @seealso 
#' \code{\link[proxy]{pr_DB}}, 
#' 
#' @export  
twdtwProxyRegister <- function(){
  is_there <- c("TWDTW","twdtw") %in% proxy::pr_DB$get_entry_names()
  sapply(c("TWDTW","twdtw")[is_there], proxy::pr_DB$delete_entry)
  
  proxy::pr_DB$set_entry(FUN   = .twdtwDist,
                         names = c("TWDTW","twdtw"),
                         loop  = FALSE,
                         type  = "metric",
                         description = "Time-Weighted Dynamic Time Warping",
                         reference   = "Maus V, Camara G, Cartaxo R, Sanchez A, Ramos FM, de Queiroz GR (2016). A Time-Weighted Dynamic Time Warping method for land use and land cover mapping. IEEE Journal of Selected Topics in Applied Earth Observations and Remote Sensing, 9 (8), pp. 3729--3739. <doi: 10.1109/JSTARS.2016.2517118>."  )
}
