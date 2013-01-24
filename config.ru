require 'sinatra'

set :root, '_site'
set :public_folder, '_site'
get '/' do
  send_file '_site/index.html'
end
run Sinatra::Application
