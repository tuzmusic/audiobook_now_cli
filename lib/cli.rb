require_relative '../config/environment.rb'
# require_relative '../lib/scraper.rb'

class CLI

  def get_books_from(url)
    list = Scraper.scrape_book_list(url)
    # binding.pry
    books = list.map { |hash| Book.create_from_hash(hash) }
  end

  def show_list(books)
    puts "Here are some audiobooks currently available for download at NYPL:\n"
    books.each.with_index(1) { |book, i| puts "#{i}. #{book.listing}" }
  end

  def select_book(books)
    puts "\nEnter the number for a book you'd like to know more about, or type \"exit\" to quit."
    input = gets.strip
    return nil if input.downcase == "exit"
    num = input.strip.to_i # TO-DO: Validate input
    books[num - 1]
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
    books = get_books_from(url)
    
    loop
      show_list(books)  
      book = select_book(books) # "exit" returns nil
      # break if book == false
      show_info_for(book)
    end

  end

# end

CLI.new.run