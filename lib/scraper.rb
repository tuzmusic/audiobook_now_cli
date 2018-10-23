require 'open-uri'
require 'nokogiri'
require 'pry'

# require_relative "../config/environment.rb"


class Scraper

  def self.scrape_book_list(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    books = doc.css('.js-titleCard')
    books_hash = books.map { |book|
      hash = {}
      title_elem = book.css('.title-name').first
      hash[:title] = title_elem.text.strip
      
      hash 
    }
    # binding.pry    
    books_hash
  end


#  finding the duration:   doc.css('li[aria-label^="Duration"]').first.text

  def self.scrape_book_page(url)
    html = open(url)
    # doc = Nokogiri::HTML(html)
    # test doesn't pass but I think this is right
    
  end


end