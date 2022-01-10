evaluation_rq2 <- function(clusters, library.name) {
  # Read feature file
  path.content <- readLines(str_c("datasets/input_evaluation/", library.name, ".txt"))
  
  feature.names <- c()
  feature.tutorials <- c()
  
  # Process feature file
  for (line in path.content) {
    divided.line <- str_split(line, ":")[[1]]
    
    # Process feature names to construct queries
    if (startsWith(line, "Name")) {
      feature.names <- c(feature.names, divided.line[2])
    } else if (startsWith(line, "Code")) {
      feature.tutorials <- c(feature.tutorials, divided.line[2])
    }
  }
  
  # Calling evaluation function
  return(list(perform.evaluation(feature.tutorials, clusters), length(feature.tutorials)))
}