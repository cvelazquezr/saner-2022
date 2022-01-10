* Basic utilities: Make using the Java language more pleasant.
    - Using and avoiding null: null can be ambiguous, can cause confusing errors, and is sometimes just plain unpleasant. - - - Many Guava utilities reject and fail fast on nulls, rather than accepting them blindly.
    - Preconditions: Test preconditions for your methods more easily.
    - Common object methods: Simplify implementing Object methods, like hashCode() and toString().
    - Ordering: Guava's powerful "fluent Comparator" class.
    - Throwables: Simplify propagating and examining exceptions and errors.
* Collections: Guava's extensions to the JDK collections ecosystem. These are some of the most mature and popular parts of Guava.
    - Immutable collections, for defensive programming, constant collections, and improved efficiency.
    - New collection types, for use cases that the JDK collections don't address as well as they could: multisets, multimaps, tables, bidirectional maps, and more.
    - Powerful collection utilities, for common operations not provided in java.util.Collections.
    - Extension utilities: writing a Collection decorator? Implementing Iterator? We can make that easier.
* Graphs: a library for modeling graph-structured data, that is, entities and the relationships between them. Key features include:
    - Graph: a graph whose edges are anonymous entities with no identity or information of their own.
    - ValueGraph: a graph whose edges have associated non-unique values.
    - Network: a graph whose edges are unique objects.
    - Support for graphs that are mutable and immutable, directed and undirected, and several other properties.
* Caches: Local caching, done right, and supporting a wide variety of expiration behaviors.
* Functional idioms: Used sparingly, Guava's functional idioms can significantly simplify code.
* Concurrency: Powerful, simple abstractions to make it easier to write correct concurrent code.
    - ListenableFuture: Futures, with callbacks when they are finished.
    - Service: Things that start up and shut down, taking care of the difficult state logic for you.
* Strings: A few extremely useful string utilities: splitting, joining, padding, and more.
* Primitives: operations on primitive types, like int and char, not provided by the JDK, including unsigned variants for some types.
* Ranges: Guava's powerful API for dealing with ranges on Comparable types, both continuous and discrete.
* I/O: Simplified I/O operations, especially on whole I/O streams and files, for Java 5 and 6.
* Hashing: Tools for more sophisticated hashes than what's provided by Object.hashCode(), including Bloom filters.
* EventBus: Publish-subscribe-style communication between components without requiring the components to explicitly register with one another.
* Math: Optimized, thoroughly tested math utilities not provided by the JDK.
* Reflection: Guava utilities for Java's reflective capabilities.

https://github.com/google/guava/wiki