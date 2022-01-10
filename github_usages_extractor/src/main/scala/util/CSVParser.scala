package com.crawler
package util

import com.github.tototoshi.csv.CSVReader
import java.io.File

object CSVParser {

  def parseCSV(filePath: String): List[Repository] = {
    val reader: CSVReader = CSVReader.open(new File(filePath))
    val elements: List[Map[String, String]] = reader.allWithHeaders()

    elements.filter(element => {
      val keys: Set[String] = element.keySet

      keys.contains("full_name") &&  keys.contains("host_type") &&  keys.contains("language") &&
        keys.contains("stars") &&  keys.contains("description")
    }).map(element => {
      val language: String = if (element("language").isEmpty) "" else element("language")
      val stars: Int = if (element("stars").isEmpty) 0 else element("stars").toFloat.toInt
      val description: String = if (element("description").isEmpty) "" else element("description")

      Repository(
        element("full_name"),
        element("host_type"),
        language,
        stars,
        description
      )
    })
  }

}
