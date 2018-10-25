# require_relative '../config/environment.rb'

class Scraper

  def self.scrape_book_list(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    books = doc.css('.js-titleCard')
    binding.pry
    books_hash = books.map { |book|
      hash = {}
      title_elem = book.css('.title-name').first
      hash[:title] = title_elem.text.strip

      auth_elem = book.css('[aria-label^="Search by author"]')
      hash[:author] = auth_elem.text.strip
      
      url_elem = title_elem.css('a').first
      hash[:url] = url_elem['href']

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