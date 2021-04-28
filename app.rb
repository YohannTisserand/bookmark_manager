require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  
  configure :development do
    register Sinatra::Reloader
  end


  run! if app_file == $0
end