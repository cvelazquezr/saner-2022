evaluation_github <- function(clusters, library.name) {
  
  # Read the data from the sampled GitHub projects
  github.usages <- readLines(str_c("datasets/selected_usages/", library.name, "_joined.txt"))
  
  # Calling evaluation function
  return(list(perform.evaluation(github.usages, clusters), length(github.usages)))
}

