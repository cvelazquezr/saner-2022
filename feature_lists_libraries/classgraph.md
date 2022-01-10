* Build a model in memory of the entire relatedness graph of all classes, annotations, interfaces, methods and fields that are visible to the JVM
* The graphs can be queried enabling some degree of metaprogramming in JVM languages
* Reads the classfile bytecode format directly, so it can read all information about classes without loading or initializing them.
* Compatible with the new JPMS module system (Project Jigsaw / JDK 9+), i.e. it can scan both the traditional classpath and the module path
* Fully backwards compatible with JDK 7 and JDK 8
* Scan the classpath and module path either at runtime or at build time
* Find classes that are duplicated or defined more than once in the classpath or module path
* Can create GraphViz visualizations of the class graph structure

https://github.com/classgraph/classgraph