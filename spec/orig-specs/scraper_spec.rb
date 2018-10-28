require 'spec_helper'

describe 'Scraper.scrape_book_list' do

  let!(:books_index_array) {[{:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough",   :url=>"https://nypl.overdrive.com/media/2381206?cid=26060"},
  {:title=>"Frostbite", :author=>"Richelle Mead",   :url=>"https://nypl.overdrive.com/media/3758613?cid=26060"},
  {:title=>"Knucklehead", :author=>"Jon Scieszka",   :url=>"https://nypl.overdrive.com/media/3758645?cid=26060"}]}


  it 'returns an array of hashes with basic book info for available audiobooks' do
    index_url = "./fixtures/available-now-list/available-now.htm"
    scraped_book = Scraper.scrape_book_list(index_url)
    expect(scraped_book).to be_a(Array)
    expect(scraped_book.first).to have_key(:title)
    expect(scraped_book.first).to have_key(:author)
    expect(scraped_book.first).to have_key(:url)
    expect(scraped_book).to include(books_index_array[0], books_index_array[1], books_index_array[2])
  end
end

describe 'Scraper.scrape_book_page' do

  let!(:book_info) {  
    {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
  }

  it 'returns a hash of information for a book' do
    index_url = "./fixtures/rosa-parks-book/rosa-parks-book.htm"
    scraped_book = Scraper.scrape_book_page(index_url)
    expect(scraped_book).to have_key(:title)
    expect(scraped_book).to have_key(:author)
    expect(scraped_book).to have_key(:description)
    expect(scraped_book).to have_key(:year)
    expect(scraped_book).to have_key(:duration)
    expect(scraped_book).to eq(book_info)
  end
end