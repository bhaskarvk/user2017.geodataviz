
world <- rnaturalearth::countries110
{{world@data$id <- row.names(world@data)}}

europe <- world[world$region_un=="Europe"&world$name!='Russia',]

europe.bbox <- SpatialPolygons(list(Polygons(list(Polygon(
  matrix(c(-25,29,45,29,45,75,-25,75,-25,29),byrow = T,ncol = 2)
)), ID = 1)), proj4string = CRS(proj4string(europe)))

europe.clipped <-
{{  rgeos::gIntersection(europe, europe.bbox, byid = TRUE,id=europe$id)}}

#europe <- spTransform(europe, CRS("+proj=aea +lat_1=36.333333333333336 +lat_2=65.66666666666667 +lon_0=14"))
plot(europe.clipped)


library(ggplot2)
library(sf)

world.tidy <- broom::tidy(world)
world.tidy <- dplyr::left_join(world.tidy, world@data)

europe.tidy <- broom::tidy(europe.clipped)
europe.tidy <- dplyr::left_join(europe.tidy, europe@data)


(world.plot <- ggplot(world.tidy, aes(long, lat, group=group)) +
  geom_polygon(alpha=0,color=grey(0.8)) +
  geom_polygon(data=europe.tidy, alpha=0.5,color=grey(0.5), fill='red') +
  ggalt::coord_proj() +
  theme(legend.position = "none",
        plot.background = element_rect(fill='#000000')) +
  ggthemes::theme_map() +
  labs(x=NULL, y=NULL, title=NULL ))

europe.centers <- rgeos::gCentroid(europe.clipped, byid = T)
europe.centers <- SpatialPointsDataFrame(europe.centers, europe@data)



ggplot(europe.tidy, aes(long,lat, group=group,fill=gdp_md_est/1000)) +
  geom_polygon(alpha=0.8,color=grey(0.7)) +
  coord_map("azequalarea") +
  hrbrthemes::theme_ipsum_rc() +
  viridis::scale_fill_viridis(
    name='Median GDP \n(in Billions)', direction = -1, labels=scales::dollar) +
  #theme(legend.justification=c(0,0), legend.position=c(0,0)) +
  theme(legend.position = 'bottom') +
  labs(x=NULL, y=NULL,
       title='Median GDP Estimates of\nContinental Europe & Iceland',
       caption='Source: http://www.naturalearthdata.com/')

ggplot(europe.tidy, aes(long,lat, group=group)) +
  geom_polygon(alpha=0.2,col='white') +
  geom_point(data=as.data.frame(europe.centers),
             aes(x,y,size=gdp_md_est/1000), alpha=0.2, inherit.aes = F) +
  coord_map("azequalarea") +
  hrbrthemes::theme_ipsum_rc() +
  viridis::scale_fill_viridis(
    name='Median GDP \n(in Billions)', direction = -1, labels=scales::dollar) +
  theme(legend.position = 'bottom') +
  labs(x=NULL, y=NULL,
       title='Median GDP Estimates of\nContinental Europe & Iceland',
       caption='Source: http://www.naturalearthdata.com/')

ggplot() +
  ggspatial::geom_spatial(europe.clipped, aes(fill=gdp_md_est/1000))

library(sf)
world <- st_as_sf(rnaturalearth::countries110)
europe <- dplyr::filter(world, region_un=="Europe" & name!='Russia')
# plot(europe)


# A bounding box for continental Europe.
europe.bbox <- st_polygon(list(
  matrix(c(-25,29,45,29,45,75,-25,75,-25,29),byrow = T,ncol = 2)))


europe.clipped <- europe %>% dplyr::filter(as.logical(st_intersects(europe, europe.bbox)))

ggplot(europe.clipped, aes(fill=gdp_md_est/1000)) +
  geom_sf(alpha=0.8,col='white') +
  hrbrthemes::theme_ipsum_rc() +
  viridis::scale_fill_viridis(
    name='Median GDP \n(in Billions)', direction = -1, labels=scales::dollar) +
  theme(legend.position = 'bottom') +
  labs(x=NULL, y=NULL,
       title='Median GDP Estimates of\nContinental Europe & Iceland',
       caption='Source: http://www.naturalearthdata.com/') +
  coord_sf(crs="+proj=aea +lat_1=36.333333333333336 +lat_2=65.66666666666667 +lon_0=14")


data(world.cities)
world.cities <- world.cities[world.cities$pop>1000000,]
coordinates(world.cities) <- ~long+lat
proj4string(world.cities) <- '+init=epsg:4326'
world <- rnaturalearth::countries110
world <- world[world$name != 'Antarctica',]

world.cities <- st_as_sf(world.cities)
world <- st_as_sf(world)


ggplot(world) +
  geom_sf(fill=grey(0.9), color=grey(0.2)) +
#  geom_sf(inherit.aes = F, aes(size=pop/1000000)) +
  coord_sf(crs = '+proj=moll +lon_0=0') +
  hrbrthemes::theme_ipsum_rc() +
 # scale_size(
  # name='Population \n(in Millions)') +
  theme(legend.position = 'bottom')


r <- raster(system.file("external/test.grd", package="raster"))
library(rasterVis)
gplot(r) + geom_tile(aes(fill = value)) +
  viridis::scale_fill_viridis(direction = -1, na.value='#FFFFFF00') +
  coord_equal() + hrbrthemes::theme_ipsum()
