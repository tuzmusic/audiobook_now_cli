require_relative '../config/environment.rb'

class Book
  
  attr_accessor :title, :author, :available, :duration, :year, :description

  @@available = []

  def self.available_books
    @@available
  end

  def initialize(title:, author:, available: true)
    self.title = title
    self.author = author
    self.available = available
    @@available << self if available
  end

end