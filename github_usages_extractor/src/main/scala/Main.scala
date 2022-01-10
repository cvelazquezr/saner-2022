package com.crawler

import extractor.{API_Extractor_Island, FileParser}
import util.{CSVParser, Repository}

import upickle.default._

import java.io.{File, PrintWriter}
import scala.collection.mutable.{Map => MMap}
import scala.io.Source
import scala.language.postfixOps
import scala.sys.process._

object Main {

  def getListOfFiles(directory: File): Array[File] = {
    val filesList: Array[File] = directory.listFiles
    val res: Array[File] = filesList ++ filesList.filter(_.isDirectory).flatMap(getListOfFiles)
    res.filter(file => {
      file.getName.endsWith(".java") && !file.isDirectory
    })
  }

  def main(args: Array[String]): Unit = {
    // Global variables
    val GITHUB_URL: String = "https://github.com"
    val DATA_FOLDER: String = "data"

    val CSV_FOLDER: String = s"$DATA_FOLDER/csv"
    val REPOSITORIES_FOLDER: String = s"$DATA_FOLDER/repositories"
    val USAGES_FOLDER: String = s"$DATA_FOLDER/usages"
    val FILE_NAME: String = "com.google.guava_guava.csv"

    val nameDivided: Array[String] = FILE_NAME.split("_")
    val groupID: String = nameDivided(0)
    val artifactID: String = nameDivided(1).split("\\.")(0)

    // Make a CLI application that:
    // 1 - Reads a CSV file passed as arguments
    println("Reading and parsing CSV file ...")
    val filePath: String = s"$CSV_FOLDER/$FILE_NAME"
    val repositories: List[Repository] = CSVParser.parseCSV(filePath)
    val javaRepositories: List[Repository] = repositories.filter(_.language.equals("Java"))
    println("Done!")

    javaRepositories.foreach(repository => {
      val repositoryFullName: String = repository.fullName
      val repositoryName: String = repositoryFullName.split("/").last

      // Checking whether the repository exists
      println(s"Checking the existence of the repository $repositoryFullName ...")
      var shouldCloneRepository: Boolean = true
      try {
        requests.get(s"$GITHUB_URL/$repositoryFullName")
      } catch {
        case _: Exception => shouldCloneRepository = false
      }
      println("Done!")

      // 2 - Clone the repositories
      if (shouldCloneRepository) {
        println(s"Cloning the repository $repositoryFullName ...")
        val repositoryAddress: String = s"$GITHUB_URL/$repositoryFullName"
        val destinationFolder: String = s"$REPOSITORIES_FOLDER/$repositoryName"
        val output: Int = Seq("git", "clone", repositoryAddress, destinationFolder).!
        println("Done!")

        // 3 - Iterate over all Java files
        if (output == 0) {
          println("Extracting Java files ...")
          val javaFiles: Array[File] = getListOfFiles(new File(destinationFolder))
          val filteredJavaFiles: List[File] = javaFiles.filterNot(_.getName.equals("package-info.java")).toList
          println("Done!")

          // 4 - Apply the island parser on the Java files
          println("Applying Island Parsers ...")
          val usagesRepository: List[List[String]] = filteredJavaFiles.flatMap(javaFile => {
            val sourceFile: Source = Source.fromFile(javaFile)
            var fileContent: String = ""

            try {
              fileContent = sourceFile.getLines().mkString("\n")
            } catch {
              case _: Exception =>
            }

            sourceFile.close()

            val methodsFile: List[String] = FileParser.extractMethods(fileContent)
            methodsFile.map(method => API_Extractor_Island.extractAPIs(method).distinct)
          })
          println("Done!")

          // 5 - Delete the folder
          println("Deleting ...")
          Seq("rm", "-rf", destinationFolder).!
          println("Done!")

          // 6 - Filters the usages related to an specific library (given a previous dictionary of classes)
          // Reading dictionary
          println("Filtering usages ...")
          val sourceDictionary: Source = Source.fromFile(s"$DATA_FOLDER/dictionaries/$groupID" +
            s"|$artifactID.json")
          val informationLibrary: String = sourceDictionary.getLines().mkString("")

          val dictionaryLibrary: MMap[String, Array[String]] = read[MMap[String, Array[String]]](informationLibrary)
          sourceDictionary.close()

          // Filtering usages extracted in the dictionary (only class names are checked here)
          val usagesLibrary: List[String] = usagesRepository.map(usage => {
            usage.filter(call => {
              val receiverName: String = call.trim.split("\\.").head
              dictionaryLibrary.keys.toList.contains(receiverName)
            }).mkString(",")
          }).filter(_.nonEmpty)

          // 7 - Save the filtered usages in an external file
          val pw: PrintWriter = new PrintWriter(new File(s"$USAGES_FOLDER/" +
            s"${repositoryFullName.replace("/", "_")}.txt"))
          usagesLibrary.foreach(usage => {
            pw.write(usage + "\n")
          })
          pw.close()

          println("Saved information!")
          println()
        }
      }
    })
  }
}
