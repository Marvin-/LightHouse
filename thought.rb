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

  def database
    @database ||= YAML::Store.new "thoughts"
  end
end