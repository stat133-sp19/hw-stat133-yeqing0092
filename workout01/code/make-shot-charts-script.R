# title: Make a Shot Charts
# description: Codes to make shot charts for each player
# input: durant, curry, green, iguodala, thompon
# output: pdf of each player's shot chart, pdf and png of gsw's short chart


library(ggplot2)
library(jpeg)
library(grid)


#

court_file <- "../images/nba-court.jpg"

cour_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1,"npc"),
  height = unit(1,"npc")
)



#Curry

curry_shot_chart <- ggplot(data = curry)+
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50, 420)+
  ggtitle("shot Chart: Stephen Curry (2016 season)")+
  theme_minimal()

pdf('../images/stephen-curry-shot-chart.pdf', width = 6.5, height = 5)
curry_shot_chart
dev.off()



#Durant

durant_shot_chart <- ggplot(data = durant)+
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50, 420)+
  ggtitle("shot Chart: Kevin Durant (2016 season)")+
  theme_minimal()

pdf('../images/kevin-durant-shot-chart.pdf', width = 6.5, height = 5)
durant_shot_chart
dev.off()


#Green

green_shot_chart <- ggplot(data = green)+
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50, 420)+
  ggtitle("shot Chart: Draymond Green (2016 season)")+
  theme_minimal()

pdf('../images/draymond-green-shot-chart.pdf', width = 6.5, height = 5)
green_shot_chart
dev.off()

#Iguodala

iguodala_shot_chart <- ggplot(data = iguodala)+
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50, 420)+
  ggtitle("shot Chart: Andre Iguodala (2016 season)")+
  theme_minimal()

pdf('../images/andre-iguodala-shot-chart.pdf', width = 6.5, height = 5)
iguodala_shot_chart
dev.off()


#Thompson

thompson_shot_chart <- ggplot(data = thompson)+
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50, 420)+
  ggtitle("shot Chart: Klay Thompson (2016 season)")+
  theme_minimal()

pdf('../images/klay-thompson-shot-chart.pdf', width = 6.5, height = 5)
thompson_shot_chart
dev.off()

#
facetted_shot_chart <- ggplot(data = shot_data) +
  annotation_custom(cour_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal()+
  facet_wrap(~ name)


#
pdf('../images/gsw-shot-charts.pdf', width=8,height=7)
facetted_shot_chart
dev.off()

#
png('../images/gsw-shot-charts.png', width=8,height=7, units="in", res = 72)
facetted_shot_chart
dev.off()
