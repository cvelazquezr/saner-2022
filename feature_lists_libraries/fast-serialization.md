* Drop-in replacement. Does not require special getters/setters/Constructors/Interfaces to serialize a class
* Extends Outputstream, implements ObjectInput/ObjectOutput
* Full support of JDK-serialization features such as Externalizable writeObject/readObject/readReplace/validation/putField/getField, hooks etc
* Preserves links inside the serialized object graph same as JDK default serialization
* Custom optimization using annotations, custom serializers
* Optional full featured serialization to/from JSON
* Conditional decoding (skip decoding parts of an object/stream in case)

http://ruedigermoeller.github.io/fast-serialization%2F%2F