Shape Features:
* Compute its lat-lon bounding box
* Compute an area. For some shapes its more of an estimate
* Compute if it contains a provided point
* Compute the relationship to a lat-lon rectangle. Relationships are: CONTAINS, WITHIN, DISJOINT, INTERSECTS. Note that Spatial4j doesn't have a notion of "touching"

Other features:
* Read and write Shapes as WKT. Include the ENVELOPE extension from CQL, plus a Spatial4j custom BUFFER operation. Buffering a point gets you a Circle
* Read and write Shapes as GeoJSON
* Read and write Shapes as Polyshape
* Read and write Shapes using the Jackson-databdind serialization framework
* 3 great-circle distance calculators: Law of Cosines, Haversine, Vincenty

https://github.com/locationtech/spatial4j