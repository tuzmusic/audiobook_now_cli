require 'spec_helper'

describe 'Scraper.scrape_book_list' do

  let!(:books_index_array) {[{:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough",   :url=>"https://nypl.overdrive.com/media/2381206?cid=26060"}]}



  it 'returns an array of hashes with basic book info for available audiobooks' do
    index_url = "./fixtures/available-now-list/available-now.htm"
    scraped_books = Scraper.scrape_book_list(index_url)
    expect(scraped_books).to be_a(Array)
    expect(scraped_books.first).to have_key(:title)
    expect(scraped_books.first).to have_key(:author)
    expect(scraped_books.first).to have_key(:url)
    expect(scraped_books).to include(books_index_array[0])#, books_index_array[1], books_index_array[2])
  end
end

describe 'Scraper.scrape_book_page' do
   it 'gets the html for a book page' do
    book_url = "https://nypl.overdrive.com/media/2381206?cid=26060"
    fix_url = "./fixtures/rosa-parks-book/rosa-parks-book.htm"
    fix_html = open(fix_url)
    fix_doc = Nokogiri::HTML(fix_html)
    # expect(Scraper.scrape_book_page(book_url)).to eq(fix_doc)
  end

  it 'returns a hash of information for a book' do
    index_url = "./fixtures/rosa-parks-book/rosa-parks-book.htm"
    scraped_books = Scraper.scrape_book_page(index_url)
    expect(scraped_books).to be_a(Array)
    expect(scraped_books.first).to have_key(:title)
    expect(scraped_books.first).to have_key(:author)
    expect(scraped_books.first).to have_key(:subject)
    expect(scraped_books.first).to have_key(:description)
    expect(scraped_books.first).to have_key(:year)
    expect(scraped_books.first).to have_key(:duration)
    # expect(scraped_books).to include(student_index_array[0], student_index_array[1], student_index_array[2])
  end
end