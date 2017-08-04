From rocker/geospatial:latest
Maintainer "Bhaskar V. Karambelkar" bhaskarvk@gmail.com

COPY sources.list /etc/apt/
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  libprotobuf-dev protobuf-compiler \
  && Rscript -e "update.packages(ask=FALSE)" \
  && install2.r evaluate learnr \
  animation \
  maptools rmapshaper cleangeo gdistance spatstat \
  raster rasterVis \
  ggthemes ggiraph ggalt hrbrthemes ggmap ggspatial \
  leaflet leaflet.minicharts leaflet.extras leaflet.esri \
  lawn geojson geojsonio geoaxe geonames elevatr\
  cartogram cartography tmap mapview \
  tigris acs tidycensus usmap \
  tilegramsR colormap \
  micromap micromapST \
  rnaturalearth rnaturalearthdata \
  osmdata OpenStreetMap \
  plotGoogleMaps googleway plotKML \
  rbokeh plotly highcharter \
  widgetframe manipulateWidget xaringan \
  choroplethr choroplethrMaps choroplethrAdmin1 rUnemploymentData \
  RNetCDF ncdf4 rnoaa ropenaq \
  && installGithub.r tidyverse/ggplot2 \
  && installGithub.r edzer/sfr \
  && installGithub.r hrbrmstr/ggalt \
  && installGithub.r hrbrmstr/albersusa \
  && installGithub.r hrbrmstr/hrbrthemes \
  && installGithub.r rstudio/leaflet \
  && installGithub.r rstudio/DT \
  && installGithub.r rstudio/rmarkdown \
  && installGithub.r rstudio/crosstalk \
  && installGithub.r mtennekes/tmap \
  && installGithub.r bhaskarvk/leaflet.extras \
  && installGithub.r bhaskarvk/leaflet.esri \
  && installGithub.r 'r-spatial/mapview@develop' \
  && installGithub.r r-spatial/mapedit \
  && installGithub.r nowosad/spData \
  && installGithub.r dkahle/ggmap \
  && installGithub.r walkerke/tidycensus \
  && installGithub.r hrecht/censusapi \
  && installGithub.r ropenscilabs/rnaturalearthhires \
  && installGithub.r ropensci/geoparser \
  && installGithub.r ropensci/plotly \
  && installGithub.r arilamstein/choroplethrZip \
  && installGithub.r oswaldosantos/ggsn \
  && installGithub.r paleolimbot/ggspatial \
  && installGithub.r dgrtwo/gganimate \
  && installGithub.r riatelab/cartography
