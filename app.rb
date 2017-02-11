require 'bundler'
Bundler.require

class LightHouseApp < Sinatra::Base
  get '/' do 
    'Light House'
  end

  run! if app_file == $0
end