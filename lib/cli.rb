require_relative '../config/environment.rb'

class CLI

  def get_books_from(url)
    list = Scraper.scrape_book_list(url)
    books = list.map { |hash| Book.create_from_hash(hash) }
  end

  def show_list(books)
    puts "Here are some audiobooks currently available for download at NYPL:\n"
    books.each.with_index(1) { |book, i| puts "#{i}. #{book.listing}" }
  end

  def select_book(books)
    loop {
      puts "\nEnter the number for a book you'd like to know more about."
      input = gets.strip
      num = input.strip.to_i 
      break if num > 0 && num <= books.count
    }
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

  def another_book?
    puts "Do you want to see information for another book? (y/n)"
    another = gets.strip == 'y'
  end

  def run
    url = "./fixtures/available-now-list/available-now.htm"
    books = get_books_from(url)
    
    loop {
      show_list(books)  
      book = select_book(books)
      show_info_for(book)
      break if another_book? == false
    }

  end

end

