require 'socket'

server = TCPServer.new 12312 # Server bind to port 12312
loop do
  client = server.accept    # Wait for a client to connect
  client.puts 'Hello !'
  cmd = 'bundle exec jekyll build'
  value = `#{cmd}`
  client.puts value
  client.close
end
