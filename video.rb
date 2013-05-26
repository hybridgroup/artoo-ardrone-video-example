require 'argus'
require 'socket'

socket = TCPSocket.open(ENV["DRONE_IP"] ? ENV["DRONE_IP"] : '192.168.1.1', 5555)
streamer = Argus::VideoStreamer.new(socket)

streamer.start

IO.popen("ffmpeg -i - -vcodec libx264 -y -threads 0 -f image2 -vcodec png -updatefirst 1 public/out.png", "w+b") do |io|
  while true do
    io.write streamer.receive_data.frame
    io.flush
  end
end
