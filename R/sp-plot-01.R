library(maps)
data(world.cities)
world.cities <- world.cities[world.cities$pop>1000000,]
coordinates(world.cities) <- ~long+lat
proj4string(world.cities) <- '+init=epsg:4326'

world <- rnaturalearth::countries110
world <- world[world$name != 'Antarctica',]

grid.lines.mj <- gridlines(
  world,easts = seq(-180,180,by=30), norths = seq(-90,90,by=30))

grid.lines.mi <- gridlines(
  world,easts = seq(-180,180,by=15), norths = seq(-90,90,by=15))

par(mar = c(5, 0.1, 0.1, 0.1))
plot(as(world, "Spatial"), expandBB=c(10,10,10,10))
plot(world, border=grey(0.2))
plot(grid.lines.mi, col=grey(0.95), add=T)
plot(grid.lines.mj, col=grey(0.8), add=T)
text(labels(grid.lines.mj, side=3:4), col = grey(.6), offset=0.3)
plot(world.cities, add=TRUE, col='#FF5A0088', pch=20,
     cex=world.cities$pop/2000000)
v = c(1,4,8,12)
legend(x=-30,y=-50, legend = v, pch = 1, pt.cex = v/2,
       text.col =grey(.7), box.col=grey(0.9), title='Pop. (Millions)', hori=T)
box()

