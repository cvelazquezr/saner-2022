name := "github_usages_extractor"
version := "0.1"
scalaVersion := "2.13.6"
idePackagePrefix := Some("com.crawler")

unmanagedJars in Compile ++= Seq(
  file("lib/islandParser.jar")
)

libraryDependencies ++= Seq(
  // CSV parser
  "com.github.tototoshi" %% "scala-csv" % "1.3.8",

  // Utilities
  "com.lihaoyi" %% "upickle" % "1.2.3",
  "com.lihaoyi" %% "requests" % "0.6.9",

  // Eclipse JDT
  "org.eclipse.jdt" % "org.eclipse.jdt.core" % "3.25.0"
)
