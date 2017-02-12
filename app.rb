require "./thought"

class LightHouseApp < Sinatra::Base
  set :method_override, true
  
  configure :development do
    register Sinatra::Reloader
  end

  not_found do 
    haml :error
  end

  get '/' do 
    haml :index, locals: {thoughts: Thought.all}
  end

  post '/' do
    thought = Thought.new(params["idea_title"], params["idea_description"])
    thought.save

    redirect '/'
  end

  delete '/:id' do |id|
    Thought.delete(id.to_i)
    redirect '/'
  end

end