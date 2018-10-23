class Scraper

  def self.scrape_book_page(url)
    html = open(url)
  end
=begin
  finding the duration:
  doc.css('li[aria-label^="Duration"]').first.text
=end


end