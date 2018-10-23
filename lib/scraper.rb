require 'open-uri'
require 'nokogiri'
require 'pry'

# require_relative "../config/environment.rb"


class Scraper

  def self.scrape_book_page(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    # test doesn't pass but I think this is right
    2
  end

=begin
  finding the duration:
  doc.css('li[aria-label^="Duration"]').first.text
=end


end