#!/usr/bin/env ruby

# Runs a HTTP server in the current directory

# Created as a non-caching replacement for Python's SimpleHTTPServer.
# Default port 8000, specify alternate port as first parameter:
#   www 3000
#   sudo www 80 # (probably a bad idea)

# Inspired by http://chrismdp.github.com/2011/12/cache-busting-ruby-http-server/
# Originally from https://gist.github.com/pda/3300372 with modifications

require 'webrick'

include WEBrick

class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler

  DAY = 86400

  def do_GET(request, response)
    super
    set_no_cache(response)
    set_content_type(response)
  end

  private

  def set_no_cache(response)
    response["Content-Type"]
    response["ETag"]          = nil
    response["Last-Modified"] = Time.now + DAY
    response["Cache-Control"] = "no-store, no-cache, must-revalidate, post-check=0, pre-check=0"
    response["Pragma"]        = "no-cache"
    response["Expires"]       = Time.now - DAY
  end

  def set_content_type(response)
    response["Content-Type"] = content_type(response.filename)
  end

  def content_type(path)
    case path.match(%r{\.(\w+)\z})[1]
      when "html" then "text/html"
      when "js" then "text/javascript"
      when "css","less" then "text/css"
      else '/usr/bin/file --brief --mime-type #{Shellwords.escape(path)}'.chomp
    end
  end

end

HTTPServer.new(:Port => ARGV.first || 8000,:DocumentRoot=>Dir::pwd ).tap do |server|
  server.mount "/", NonCachingFileHandler , Dir.pwd
  trap("INT") { server.stop }
  server.start
end