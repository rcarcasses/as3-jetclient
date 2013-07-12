as3-jetclient
=============

A flexible actionscript 3 framework to handle socket connections

Scope
=====

Althought this light framework was build having in mind Nadron java server it can be used with a wider purpose. It is possible to configure the protocol to use while communicating with the server. Currently AMF3 protocol is implemented, the unit of information should be of the form:

1-Two bytes indicating the length of the payload.
2-The payload encoded in AMF3 format.

The pipeline guarantees the same encoding/decoding while sending or receiving data from the server.

The LengthFieldBasedFrameDecoder is smart while decoding a bunch of TCP packets with the unit packet spread on them, as well as decoding a single TCP packet with several unit of information (game defined packet). You can check in the test folder.

Custom protocol
===============

It is very easy to implement a new protocol by adding the right codecs to the pipeline. A nice approach could be binary JSON (BSON) instead of AMF3, but AMF3 will be good enough for flash applications I guess. Also one could add easily a compression step in the pipeline, but have to take care of the same procedure at the server side.
