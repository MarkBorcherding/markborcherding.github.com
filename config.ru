require 'sinatra'
require 'sinatra-index'

use_static_index 'index.html'
set :root, '_site'
set :public_folder, '_site'

run Sinatra::Application
