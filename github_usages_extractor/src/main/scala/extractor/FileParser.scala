package com.crawler
package extractor

import org.eclipse.jdt.core.dom.{AST, ASTParser, ASTVisitor, CompilationUnit, MethodDeclaration}

object FileParser {

  def extractMethods(fileContent: String): List[String] = {
    // Parser configuration
    val parser: ASTParser = ASTParser.newParser(AST.JLS_Latest)
    parser.setSource(fileContent.toCharArray)
    parser.setKind(ASTParser.K_COMPILATION_UNIT)

    // Creating AST
    val compilationUnit: CompilationUnit = parser.createAST(null).asInstanceOf[CompilationUnit]

    // Data structure to store the method chunks
    var methods: List[String] = List()

    // Visiting nodes
    compilationUnit.accept(new ASTVisitor() {
      override def visit(node: MethodDeclaration): Boolean = {
        val modifiers = node.modifiers().stream().map(element => element.toString).toArray
        val returnType = node.getReturnType2
        val methodName: String = node.getName.toString
        val parameters = node.parameters().stream().map(element => element.toString).toArray
        val methodBody = node.getBody

        var methodComposed: String = ""

        if (returnType != null && methodBody != null) {
          methodComposed += modifiers.mkString(" ") + " " + returnType.toString + " " + methodName +
            " (" + parameters.mkString(", ") + ") " + methodBody.toString
        }

        methods :+= methodComposed
        true
      }
    })

    methods
  }
}
