
perform.evaluation <- function(ground.truth, clusters) {
  # Data to be stored
  feature.number <- c()
  cluster.number <- c()
  similarity <- c()
  relevance <- c()
  overflow <- c()
  overflow.classes <- c()
  overflow.methods <- c()
  
  k <- 0
  for (usage in ground.truth) {
    k <- k + 1
    print(k)
    
    feature.data <- extract.information(usage)
    
    classes.feature <- feature.data[[1]] # CF
    methods.feature <- feature.data[[2]] # MF
    
    j <- 0
    for (cluster in clusters) {
      j <- j + 1
      
      number.snippets  <- length(cluster) # CA
      cluster.data <- extract.information(cluster)
      
      classes.cluster <- cluster.data[[1]]
      methods.cluster <- cluster.data[[2]]
      
      intersection.classes <- intersect(classes.feature, classes.cluster)
      intersection.methods <- intersect(methods.feature, methods.cluster)
      
      if (length(intersection.classes) > 0 && length(intersection.methods) > 0) {
        sum.classes <-  0
        sum.no.classes <- length(setdiff(classes.feature, classes.cluster)) / length(classes.feature) - length(setdiff(classes.cluster, classes.feature)) / length(classes.cluster)
        
        for (index in c(1:length(classes.feature))) {
          sum.classes <- sum.classes + frequency.term.snippet(classes.feature[index], cluster) / number.snippets
        }
        
        sum.methods <- 0
        sum.no.methods <- length(setdiff(methods.feature, methods.cluster)) / length(methods.feature) - length(setdiff(methods.cluster, methods.feature)) / length(methods.cluster)
        
        for (index in c(1:length(methods.feature))) {
          sum.methods <- sum.methods + frequency.term.snippet(methods.feature[index], cluster, F) / number.snippets
        }
        
        relevance.classes <- sum.classes / length(classes.feature)
        relevance.methods <- sum.methods / length(methods.feature)
        
        relevance <- c(relevance, (relevance.classes + relevance.methods) / 2)
        overflow.classes <- c(overflow.classes, sum.no.classes)
        overflow.methods <- c(overflow.methods, sum.no.methods)
        
        overflow <- c(overflow, (sum.no.classes + sum.no.methods) / 2)
        
        feature.number <- c(feature.number, k)
        cluster.number <- c(cluster.number, j)
      }
    }
  }
  
  return(data.frame(feature.number,
                    cluster.number,
                    relevance,
                    overflow,
                    overflow.classes,
                    overflow.methods)
  )
}

extract.information <- function(cluster) {
  classes <- c()
  methods <- c()
  
  for (snippet in cluster) {
    snippet <- str_replace_all(snippet, "<br>", ",")
    snippet.divided  <- strsplit(snippet, ",")[[1]]
    
    for (call in snippet.divided) {
      call.divided <- strsplit(call, "\\.")[[1]]
      
      classes <- c(classes, call.divided[1])
      methods <- c(methods, call.divided[2:length(call.divided)])
    }
  }
  
  classes <- unique(classes)
  methods <- unique(methods)
  
  return(list(classes, methods))
}


frequency.term.snippet <- function(term, cluster, is.class = T) {
  counter <- 0
  
  for (snippet in cluster) {
    snippet <- str_replace_all(snippet, "<br>", ",")
    snippet.divided  <- strsplit(snippet, ",")[[1]]
    
    # It ensures that one class/method is counted as appearing in the snippet
    flag <- T
    
    for (call in snippet.divided) {
      call.divided <- strsplit(call, "\\.")[[1]]
      
      classes <- call.divided[1]
      methods <- call.divided[2:length(call.divided)]
      
      if (is.class) {
        if (term %in% classes && flag) {
          counter <- counter + 1
          flag <- F
        }
      } else {
        if (term %in% methods && flag) {
          counter <- counter + 1
          flag <- F
        }
      }
    }
  }
  
  return(counter)
}


reverse.frequency.term.snippet <- function(term, cluster, is.class = T) {
  classes.counted <- c()
  methods.counted <- c()
  
  for (snippet in cluster) {
    snippet <- str_replace_all(snippet, "<br>", ",")
    snippet.divided  <- strsplit(snippet, ",")[[1]]
    
    for (call in snippet.divided) {
      call.divided <- strsplit(call, "\\.")[[1]]
      
      classes <- call.divided[1]
      methods <- call.divided[2:length(call.divided)]
      
      if (is.class) {
        if (term != classes)
          classes.counted <- c(classes.counted, classes)
      } else {
          methods.counted <- c(methods.counted, setdiff(methods, c(term)))
      }
    }
  }
  
  if (is.class)
    return(length(unique(classes.counted)))
  else
    return(length(unique(methods.counted)))
}

