# require_relative '../config/environment.rb'

class Book
  
  attr_accessor :title, :author, :available, :duration, :year, :description, :url

  @@available = []

  def self.available_books
    @@available
  end
  
  def self.all
    @@available
  end

  def self.create_from_hash(hash)
    raise ArgumentError, 'Must provide a title and an author' if !hash[:title] || !hash[:author]

    book = self.new(title: hash[:title], author: hash[:author])
    book.url = hash[:url]
    book.year = hash[:year] 
    book.description = hash[:description] 
    book.duration = hash[:duration] 
    book
  end

  def listing
    "#{self.title} - #{self.author} (#{self.duration})"
  end

  def initialize(title:, author:, available: true)
    self.title = title
    self.author = author
    self.available = available
    @@available << self if available
  end

end