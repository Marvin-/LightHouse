require "./thought"

class LightHouseApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  not_found do 
    haml :error
  end

  get '/' do 
    haml :index
  end

  post '/' do
    thought = Thought.new
    thought.save
    
    "Creating a thought!"
  end

end