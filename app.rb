require 'sinatra'
configure { set :server, :puma }
set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
get '/' do
  send_file 'index.html'
end
