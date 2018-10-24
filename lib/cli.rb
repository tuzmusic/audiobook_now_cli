require_relative '../config/environment.rb'

class CLI

  def get_books_from(url:)
    
  end

  def book_from_list(url)
    
    list = Scraper.scrape_book_list(url)
    books = list.map { |hash| Book.create_from_hash(hash) }

    puts "Here are some audiobooks currently available for download at NYPL:"
    puts ""
    show_books(books)
    puts ""
    puts "Enter the number for a book you'd like to know more about:"
    num = gets.strip.to_i # TO-DO: Validate input
    books[num - 1]
  end

  def show_books(books_list)
    books_list.each.with_index(1) { |book, i|
      puts "#{i}. #{book.title} - #{book.author}"
    }
  end

  def show_info_for(book)
    puts ''
    puts "\"#{book.title}\" (#{book.year})"
    puts "by #{book.author}"
    puts "Length: #{book.duration}"
    puts ''
    puts book.description 
    puts ''
  end 

  def run
    url = "./fixtures/available-now-list/available-now.htm"
    books = get_books_from(url: url)
    book = book_from_list
    show_info_for(book)
  end

end

# CLI.new.run