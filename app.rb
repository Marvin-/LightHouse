require "./thought"
require "./thought_store"

class LightHouseApp < Sinatra::Base
  set :method_override, true
  
  configure :development do
    register Sinatra::Reloader
  end

  not_found do 
    haml :error
  end

  get '/' do 
    # binding.pry
    haml :index, locals: {thoughts: ThoughtStore.all, thought: Thought.new(params)}
  end

  post '/' do
    thought = ThoughtStore.create(params[:thought])

    redirect '/'
  end

  get '/:id/edit' do |id|
    thought = Thought.find(id.to_i)
    haml :edit, locals: {id: id, thought: thought}
  end

  put '/:id' do |id|
    data = {
      :title => params[:thought][:title],
      :descrption => params[:thought][:description]
    }

    Thought.update(id.to_i, data)
    redirect '/'
  end

  delete '/:id' do |id|
    Thought.delete(id.to_i)
    redirect '/'
  end

end