require 'yaml/store'

class Thought
attr_accessor :title, :description
def initialize(attributes)
  @title = attributes["title"]
  @description = attributes["description"]
end

  def save
    database.transaction do |db|
      db["thoughts"] ||= []
      db["thoughts"] << {"title" => title, "description" => description}
    end
  end

  def self.all
    raw_ideas.map do |data|
      Thought.new(data)
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['thoughts'] || []
    end
  end

  def self.delete(position)
    database.transaction do 
      database['thoughts'].delete_at(position)
    end
  end

  def self.find(id)
    raw_idea = find_raw_thought(id)
    Thought.new(raw_idea)
  end

  def self.find_raw_thought(id)
    database.transaction do 
      database['thoughts'].at(id)
    end
  end
  
  def self.update(id, data)
    database.transaction do 
      database["thoughts"][id] = data
    end
  end

  def self.database
    @database ||= YAML::Store.new("thoughts")
  end

  def database
    Thought.database
  end
end