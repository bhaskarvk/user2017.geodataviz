library(ggplot2)

usa <- albersusa::usa_sf()

usa_pop_history <- readr::read_tsv('inst/presentations/usa_pop_history.tsv')

usa <- dplyr::left_join(usa, usa_pop_history, by=c('name'='State'))

g <- ggplot(data=usa) + ggthemes::theme_map() + theme(legend.position = 'bottom') +
  viridis::scale_fill_viridis(direction = -1, option = 'A')

g.2015 <- g + geom_sf(aes(fill=p.2015)) + coord_sf(crs = albersusa::us_aeqd_proj)
g.2010 <- g + geom_sf(aes(fill=p.2010)) + coord_sf(crs = albersusa::us_aeqd_proj)
g.2000 <- g + geom_sf(aes(fill=p.2000)) + coord_sf(crs = albersusa::us_aeqd_proj)
g.1990 <- g + geom_sf(aes(fill=p.1990)) + coord_sf(crs = albersusa::us_aeqd_proj)
g.1950 <- g + geom_sf(aes(fill=p.1950)) + coord_sf(crs = albersusa::us_aeqd_proj)
g.1900 <- g + geom_sf(aes(fill=p.1900)) + coord_sf(crs = albersusa::us_aeqd_proj)

ggsave(g.2015,filename = '/tmp/g_2015.png')
ggsave(g.2010,filename = '/tmp/g_2010.png')
ggsave(g.2000,filename = '/tmp/g_2000.png')
ggsave(g.1990,filename = '/tmp/g_1990.png')
ggsave(g.1950,filename = '/tmp/g_1950.png')
ggsave(g.1900,filename = '/tmp/g_1900.png')

animation::im.convert(files = '/tmp/g_*.png', output =  'animation-01.gif')
