library(sp)
demo(meuse, ask = FALSE, echo = FALSE)
plot(meuse, pch = 1, cex = sqrt(meuse$zinc)/12, axes=TRUE)
v = c(100,200,400,800,1600)
legend("topleft", legend = v, pch = 1, pt.cex = sqrt(v)/12)
plot(meuse.riv, add = TRUE, col = grey(.9, alpha = .5))

crs.longlat = CRS("+init=epsg:4326")
meuse.longlat = spTransform(meuse, crs.longlat)
plot(meuse.longlat, axes = TRUE)

meuse.riv.longlat <- spTransform(meuse.riv, crs.longlat)

library(methods) # as

grid.lines <- gridlines(meuse.longlat, easts=seq(5.71, 5.76, by = 0.01 ),
                         norths = seq(50.955,51,by=0.005))

par(mar = c(1, 1, 1, 1))
plot(as(meuse.longlat, "Spatial"), expandBB=c(0.05,0,0.1,0))
plot(grid.lines, add = TRUE, col = grey(.8))
plot(meuse.longlat, pch=1, cex = sqrt(meuse$zinc)/12, add = TRUE)
text(labels(grid.lines, side=2:3), col = grey(.7), offset=1.5)
v = c(100,200,400,800,1600)
legend("bottomright", legend = v, pch = 1, pt.cex = sqrt(v)/12,
       text.col =grey(.8), box.col=grey(0.8), title='Zinc Conc. (ppm)')
plot(meuse.riv.longlat, add = TRUE, col = grey(.9, alpha = .5))
