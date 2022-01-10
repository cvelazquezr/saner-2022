* Clean XML. No information is duplicated that can be obtained via reflection. This results in XML that is easier to read for humans and more compact than native Java serialization.
* Requires no modifications to objects. Serializes internal fields, including private and final. Supports non-public and inner classes. Classes are not required to have default constructor.
* Full object graph support. Duplicate references encountered in the object-model will be maintained. Supports circular references.
* Integrates with other XML APIs. By implementing an interface, XStream can serialize directly to/from any tree structure (not just XML).
* Customizable conversion strategies. Strategies can be registered allowing customization of how particular types are represented as XML.
* Security framework. Fine-control about the unmarshalled types to prevent security issues with manipulated input.
* Error messages. When an exception occurs due to malformed XML, detailed diagnostics are provided to help isolate and fix the problem.
* Alternative output format. The modular design allows other output formats. XStream ships currently with JSON support and morphing.

https://x-stream.github.io/