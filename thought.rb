require 'yaml/store'

class Thought
  attr_reader :title, :description

  def initialize(title, description)
    @title = title
    @description = description
  end

  def save
    database.transaction do |db|
      db["thoughts"] ||= []
      db["thoughts"] << {title: title, description: description}
    end
  end

  def self.all
    raw_ideas.map do |data|
      new(data[:title], data[:description])
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
  
  def self.database
    @database ||= YAML::Store.new("thoughts")
  end

  def database
    Thought.database
  end
end