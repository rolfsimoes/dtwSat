<!--
# Otput to render md file for github webpage 
output_format = rmarkdown::md_document(variant = "markdown_github", preserve_yaml = TRUE)
# Render vignettes
rmarkdown::render(input="./vignettes/twdtw.Rmd",        output_format=output_format)
rmarkdown::render(input="./vignettes/dtwSat_usage.Rmd", output_format=output_format)
rmarkdown::render(input="./vignettes/lucc.Rmd",         output_format=output_format)
-->
dtwSat
======

### Time-Weighted Dynamic Time Warping for remote sensing time series analysis

dtwSat provides an implementation of Time-Weighted Dynamic Time Warping (TWDTW) for satellite image time series analysis and land use classification (Maus et al. 2016). It is useful to account for natural and cultivated vegetation types with inter-annual climatic and seasonal variability. Methods based on dynamic time warping are flexible to handle with irregular sampling and out of phase time series, and have achieved significant results in time series data mining (Velichko and Zagoruyko 1970; Hiroaki Sakoe and Chiba 1971; H. Sakoe and Chiba 1978; Rabiner and Juang 1993; Berndt and Clifford 1994; Keogh and Ratanamahatana 2005; Müller 2007; Petitjean, Inglada, and Gancarski 2012). Bellow we show a quick demo of the package and some [R vignettes](#vignettes) about the package usage and the TWDTW method.

### Install

``` r
devtools::install_github("vwmaus/dtwSat")
```

### Quick demo

In this quick dome we will perform a TWDTW analysis for a single time series. Suppose that we want to know the crop type of each subinterval in following `example_ts` time series:

``` r
library(dtwSat)
library(ggplot2)
autoplot(example_ts, facets = NULL) + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-example_ts-ts-1.png" alt="Fig. 1. example_ts time series."  />
<p class="caption">
Fig. 1. example\_ts time series.
</p>

We know that in the region where the time series was observed we have *soybean*, *cotton*, and *maize*, whose typical temporal pattern are:

``` r
plotPatterns(patterns.list) + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-patterns-1.png" alt="Fig. 2. Typical temporal patterns of *soybean*, *cotton*, and *maize*."  />
<p class="caption">
Fig. 2. Typical temporal patterns of *soybean*, *cotton*, and *maize*.
</p>

Using the these temporal patterns we run the TWDTW analysis, such that

``` r
log_fun = logisticWeight(alpha=-0.1, beta=100) # Logistic time-weight
matches = twdtw(x=example_ts, patterns=patterns.list, 
             normalize.patterns = TRUE, patterns.length = 23,
             weight.fun = log_fun, keep=TRUE) 
```

The result is a `twdtw` object with all possible matches of the patterns to the time series

``` r
class(matches)
print(matches)
summary(matches)
```

We can use several plot methods to visualize the `twdtw` object. To plot alignments

``` r
plot(x = matches, type = "alignments") + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-alignment-1.png" alt="Fig. 3. TWDTW alignments over time and cost (distance) in y-axis."  />
<p class="caption">
Fig. 3. TWDTW alignments over time and cost (distance) in y-axis.
</p>

to plot matching point

``` r
plot(x = matches, type = "match", attr = "evi") + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-match-1.png" alt="Fig. 4. The best match for each crop type."  />
<p class="caption">
Fig. 4. The best match for each crop type.
</p>

to plot minimum cost paths

``` r
plot(x = matches, type = "paths") + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-path-1.png" alt="Fig. 5. The minimum cost path of the TWDTW alignment for each crop type."  />
<p class="caption">
Fig. 5. The minimum cost path of the TWDTW alignment for each crop type.
</p>

and, finally to classify the subintervals of the example\_ts time series

``` r
plot(x = matches, type = "classification",
     from = "2009-09-01", to = "2013-09-01", 
     by = "6 month", overlap = 0.3) + 
     theme(text = element_text(size = 8, family = "Helvetica"))
```

<img src="figure/plot-group-1.png" alt="Fig. 6. Classification using the best match for each subinterval."  />
<p class="caption">
Fig. 6. Classification using the best match for each subinterval.
</p>

To see more example please check the [R vignettes](#vignettes) and if you want to learn more about the TWDTW method (see, Maus et al. 2016).

### Vignettes

1.  [Timw-Weighted Dynamic Time Warping](./vignettes/twdtw.md)
2.  [Time series analysis and visualization using dtwSat](./vignettes/dtwSat_usage.md)
3.  [Land use changes analysis using dtwSat](./vignettes/lucc.md)

### References

Berndt, Donald J., and James Clifford. 1994. “Using Dynamic Time Warping to Find Patterns in Time Series.” In *KDD Workshop*, edited by Usama M. Fayyad and Ramasamy Uthurusamy, 359–70. AAAI Press.

Keogh, Eamonn, and Chotirat Ann Ratanamahatana. 2005. “Exact Indexing of Dynamic Time Warping.” *Knowledge Information Systems* 7 (3): 358–86.

Maus, Victor, Gilberto Câmara, Ricardo Cartaxo, Alber Sanchez, Fernando M. Ramos, and Gilberto R. de Queiroz. 2016. “A Time-Weighted Dynamic Time Warping method for land use and land cover mapping.” *Accepted for Publication in IEEE Journal of Selected Topics in Applied Earth Observations and Remote Sensing* 9 (X): XXXX–XX.

Müller, Meinard. 2007. *Information Retrieval for Music and Motion*. London: Springer.

Petitjean, F., J. Inglada, and P. Gancarski. 2012. “Satellite Image Time Series Analysis Under Time Warping.” *Geoscience and Remote Sensing, IEEE Transactions on* 50 (8): 3081–95. doi:[10.1109/TGRS.2011.2179050](http://dx.doi.org/10.1109/TGRS.2011.2179050).

Rabiner, Lawrence, and Biing-Hwang Juang. 1993. *Fundamentals of Speech Recognition*. Prentice-Hall International, Inc.

Sakoe, H., and S. Chiba. 1978. “Dynamic Programming Algorithm Optimization for Spoken Word Recognition.” *Acoustics, Speech and Signal Processing, IEEE Transactions on* 26 (1): 43–49. doi:[10.1109/TASSP.1978.1163055](http://dx.doi.org/10.1109/TASSP.1978.1163055).

Sakoe, Hiroaki, and Seibi Chiba. 1971. “A Dynamic Programming Approach to Continuous Speech Recognition.” In *Proceedings of the Seventh International Congress on Acoustics, Budapest*, 3:65–69. Budapest: Akadémiai Kiadó.

Velichko, V.M., and N.G. Zagoruyko. 1970. “Automatic Recognition of 200 Words.” *International Journal of Man-Machine Studies* 2 (3): 223–34. doi:[10.1016/S0020-7373(70)80008-6](http://dx.doi.org/10.1016/S0020-7373(70)80008-6).
