require_relative '../config/environment.rb'

class CLI

  def get_books_from(url)
    list = Scraper.scrape_book_list(url) # => array of hashes, with urls

    book_urls = list.map { |book| book[:url] }
    book_hashes = book_urls.map { |url| Scraper.scrape_book_page(url) }
    books = book_hashes.map { |hash| Book.create_from_hash(hash) } 
  end

  def show_list(books)
    puts "\n"+"Here are some audiobooks currently available for download at NYPL:"+"\n\n"
    books.each.with_index(1) { |book, i| puts "#{i}. #{book.listing}" }
  end

  def select_book(books)
    loop {
      puts "\n"+"Enter the number for a book you'd like to know more about."
      input = gets.strip
      num = input.strip.to_i 
      return books[num - 1] if num > 0 && num <= books.count
    }
    
  end

  def show_info_for(book)
    puts "\n" + "\"#{book.title}\" (#{book.year})"
    puts "by #{book.author}"
    puts "Length: #{book.duration}"
    puts "\n"+ book.description + "\n"
  end 

  def another_book?
    puts "\n"+"Do you want to see information for another book? (y/n)"
    another = gets.strip == 'y'
  end

  def run
    puts "Loading books. Sorry, this could take a few seconds...\n"

    # url = "./fixtures/available-now-list/available-now.htm"
    url = "https://nypl.overdrive.com/collection/26060"
    books = get_books_from(url)  

    loop {
      show_list(books)  
      book = select_book(books)
      show_info_for(book)
      break if another_book? == false
    }

  end

end

