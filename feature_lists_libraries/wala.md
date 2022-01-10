* Shrike has a patch-based API for instrumenting bytecode
* The bytecodes of a method are represented with an array of immutable instruction objects 
* Bytecode modification is done by adding patches and then applying those patches
* JSRs are automatically inlined, so instrumentation passes can ignore them
* Exception handlers are represented as an explicit handler list for each instruction (rather than ranges of indices covered by handler), easing manipulation
* Simple dataflow analysis and a bytecode verifier for sanity checking of instrumented code

http://wala.sourceforge.net/wiki/index.php/Shrike_technical_overview