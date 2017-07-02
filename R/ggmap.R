library(ggplot2)
library(ggmap)

paste0("2016-0",1:7) %>%
  purrr::map(function(month) {
    suppressMessages(readr::read_csv(
      system.file(
        sprintf("examples/data/London-Crimes/%s/%s-city-of-london-street.csv.zip",
                month,month),
        package='leaflet.extras')
    ))
  }) %>%
  dplyr::bind_rows() -> crimes

qmplot(Longitude, Latitude, data=crimes, geom="blank", zoom=16,
       maptype = "toner-lite", facets = ~Month) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .3) +
  scale_fill_gradient2("Crime Heatmap", low = "white", mid = "yellow", high = "red")
