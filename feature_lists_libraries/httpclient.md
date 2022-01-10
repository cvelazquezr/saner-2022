* Full implementation of all HTTP methods (GET, POST, PUT, DELETE, HEAD, OPTIONS, and TRACE)
* Supports encryption with HTTPS (HTTP over SSL) protocol
* Transparent connections through HTTP proxies
* Tunneled HTTPS connections through HTTP proxies, via the CONNECT method
* Basic, Digest, NTLMv1, NTLMv2, NTLM2 Session, SNPNEGO, Kerberos authentication schemes
* Plug-in mechanism for custom authentication schemes
* Pluggable secure socket factories, making it easier to use third party solutions
* Connection management support for use in multi-threaded applications. Supports setting the maximum total connections as well as the maximum connections per host. Detects and closes stale connections
* Automatic Cookie handling for reading Set-Cookie: headers from the server and sending them back out in a Cookie: header when appropriate
* Plug-in mechanism for custom cookie policies
* Request output streams to avoid buffering any content body by streaming directly to the socket to the server.
* Response input streams to efficiently read the response body by streaming directly from the socket to the server.
* Persistent connections using KeepAlive in HTTP/1.0 and persistance in HTTP/1.1
* Direct access to the response code and headers sent by the server
* The ability to set connection timeouts
* Support for HTTP/1.1 response caching

https://hc.apache.org/httpcomponents-client-ga/