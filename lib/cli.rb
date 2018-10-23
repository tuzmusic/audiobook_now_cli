require_relative '../config/environment.rb'

class CLI

  def run
    puts "Here are some audiobooks currently available for download at NYPL:"
    nypl_url = "./fixtures/available-now-list/available-now.htm"
    
    # list = Scraper.scrape_book_list(nypl_url)
    list = Book.available_books

    list.each.with_index(1) { |book, i|
      puts "#{i}. #{book.title} - #{book.author}"
      # puts "#{i}. #{book[:title]} - #{book[:author]}"
    }
  end

end