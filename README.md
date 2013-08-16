CacheBustingHTTPServer
======================

An alternative to Python's SimpleHTTPServer that prevents caching.


Dependencies:

Requires the webrick gem to be installed.  You can install it by typing this in the console:

sudo gem install webrick


Installation:

In the project root directory, run the install.sh file as root, i.e. "sudo install.sh".  You may have to mark the file
as executable using "chmod 777 install.sh" first.

Usage:

Change to the directory from which you wish to serve files.  Type the following command "cb-http".  The server will
Then start up.  To terminate the server, press CTRL+C.
