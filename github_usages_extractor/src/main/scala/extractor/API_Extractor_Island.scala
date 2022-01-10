package com.crawler
package extractor

import com.parser.extractor.Extractor

object API_Extractor_Island {

  def extractAPIs(codeSnippet: String): List[String] = {
    val extractor: Extractor = new Extractor(codeSnippet)
    val methodInvocations = extractor.extractMethodCalls()
    var methodInvocationsArray: Array[String] = Array()

    methodInvocations.forEach(call => {
      methodInvocationsArray :+= call
    })

    methodInvocationsArray.toList
  }
}
