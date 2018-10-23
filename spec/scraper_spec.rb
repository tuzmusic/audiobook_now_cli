require 'spec_helper'

describe 'Scraper.scrape_book_page'
  it 'gets the html for a book page' do
    book_url = "https://nypl.overdrive.com/media/2381206?cid=26060"
    html = 
    expect(Scraper.scrape_book_page(book_url)).to equal(value)
  end
end