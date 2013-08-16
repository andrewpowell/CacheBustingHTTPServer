#!/bin/bash
echo Installing CacheBustingHTTPServer

cp src/http.rb /bin/cb-http
chmod 777 /bin/cb-http

echo CacheBustingHTTPServer has been installed.  See README for usage.