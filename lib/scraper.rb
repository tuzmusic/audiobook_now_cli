# require_relative '../config/environment.rb'

class Scraper

  def self.scrape_book_list(url)
    
    session = Capybara::Session.new(:poltergeist)
    session.visit(url)

    html = open(url)
    doc = Nokogiri::HTML(html)

    # books = doc.css('.js-titleCard')
    books = session.all('.js-titleCard')
    books_hash = books.map { |book|
      hash = {}

      # hash[:title] = book.css('.title-name').first.text.strip
      hash[:title] = book.first('.title-name').text.strip

      # hash[:author] = book.css('[aria-label^="Search by author"]').text.strip
      hash[:author] = book.first('[aria-label^="Search by author"]').text.strip
      
      # url_elem = title_elem.css('a').first
      # hash[:url] = url_elem['href']
      hash[:url] = book.first('.title-name').first('a')['href']
      # binding.pry
      hash 
    } 
    books_hash
  end

  def self.scrape_book_page(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    book = {}

    book[:title] = doc.css('.TitleDetailsHeading-title').text
    book[:author] = doc.css('.TitleDetailsHeading-creator').first.css('a').first.text
    book[:description] = doc.css('.TitleDetailsDescription-description').first.text.strip
    book[:year] = doc.css('li[aria-label^="Release date"]').first.text.scan(/\d{4}/).first
    book[:duration] = doc.css('li[aria-label^="Duration"]').first.text.strip.gsub('Duration: ','')
    book
  end


end