library(fmsb)

plot.radar <- function(data.cluster) {
  data.classes <- subset(data.cluster$classes, select=-freq.classes)
  # data.methods <- subset(data.cluster$methods, select=-c(freq.methods, precedents))
  
  data <- as.data.frame(matrix(data.classes$percent.classes * 100 , ncol=nrow(data.classes)))
  # data <- as.data.frame(matrix(data.methods$percent.methods , ncol=nrow(data.methods)))
  
  colnames(data) <- data.classes$unique.classes
  # colnames(data) <- data.methods$unique.methods
  
  data <- rbind(rep(100, nrow(data)) , rep(0, nrow(data.classes)) , data)
  
  radarchart(data, axistype=1 ,

              #custom polygon
              pcol=rgb(0.2,0.4,0.5,0.9) , pfcol=rgb(0.2,0.5,0.7,0.5) , plwd=4 ,

              #custom the grid
              cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8,

              #custom labels
              vlcex=0.9
  )
}
