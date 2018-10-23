require 'spec_helper'

describe 'Scraper.scrape_book_list' do

  let!(:books_index_array) {[
    {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough",   :url=>"https://nypl.overdrive.com/media/2381206?cid=26060"},
  {:title=>"Frostbite", :author=>"Richelle Mead",   :url=>"https://nypl.overdrive.com/media/3758613?cid=26060"},
  {:title=>"Knucklehead", :author=>"Jon Scieszka ",   :url=>"https://nypl.overdrive.com/media/3758645?cid=26060"}]}



  it 'returns an array of hashes with basic book info for available audiobooks' do
    index_url = "./fixtures/available-now-list/available-now.htm"
    scraped_books = Scraper.scrape_book_list(index_url)
    expect(scraped_books).to be_a(Array)
    expect(scraped_books.first).to have_key(:title)
    expect(scraped_books.first).to have_key(:author)
    expect(scraped_books.first).to have_key(:url)
    expect(scraped_books).to include(books_index_array[0], books_index_array[1], books_index_array[2])
  end
end

describe 'Scraper.scrape_book_page' do

  let!(:books_array) {[
    {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:00:56", :year=>"2016"},
    {:title=>"Frostbite", :author=>"Richelle Mead ", :description=>"Rose loves Dimitri, Dimitri might love Tasha, and Mason would die to be with Rose...

    It's winter break at St. Vladimir's, but Rose is feeling anything but festive. A massive Strigoi attack has put the school on high alert, and now the Academy's crawling with Guardians—including Rose's hard-hitting mother, Janine Hathaway. And if handto- hand combat with her mom wasn't bad enough, Rose's tutor Dimitri has his eye on someone else, her friend Mason's got a huge crush on her, and Rose keeps getting stuck in Lissa's head while she's making out with her boyfriend, Christian! The Strigoi are closing in, and the Academy's not taking any risks.... This year, St. Vlad's annual holiday ski trip is mandatory.

    But the glittering winter landscape and the posh Idaho resort only create the illusion of safety. When three friends run away in an offensive move against the deadly Strigoi, Rose must join forces with Christian to rescue them. But heroism rarely comes without a price...",:duration=>"01:00:56", :year=>"2016"},
    {:title=>"Knucklehead", :author=>"Jon Scieszka ", :description=>'How did Jon Scieszka get so funny, anyway? Growing up as one of six brothers was a good start, but that was just the beginning. Throw in Catholic school, lots of comic books, lazy summers at the lake with time to kill, babysitting misadventures, TV shows, jokes told at family dinner, and the result is Knucklehead. Part memoir, part scrapbook, this hilarious trip down memory lane provides a unique glimpse into the formation of a creative mind and a free spirit.',:duration=>"08:47:46", :year=>"2018"}]
  }

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
  end
end