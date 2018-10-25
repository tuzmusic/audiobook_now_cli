require_relative '../config/environment.rb'

class CLI

  def get_books_from(url)

    list = Scraper.scrape_book_list(url) # => array of hashes, with urls
    book_urls = list.map { |book| book[:url] }
    # book_hashes = 
    book_urls.each{ |url| 
      hash = Scraper.scrape_book_page(url)
      Book.create_from_hash(hash)
      puts "#{Book.all.count}. #{Book.all.last.listing}"      
    }
    # book_hashes.each { |hash| Book.create_from_hash(hash) } 
  end

  def show_list
    puts "\n"+"Here are some audiobooks currently available for download at NYPL:"+"\n\n"
    Book.all.each.with_index(1) { |book, i| puts "#{i}. #{book.listing}" }
  end

  def select_book
    loop {
      puts "\n"+"Enter the number for a book you'd like to know more about."
      num = gets.strip.to_i 
      return Book.all[num - 1] if num > 0 && num <= Book.all.count  # 'return' breaks the loop. it's necessary!
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
    # url = "./fixtures/available-now-list/available-now.htm"
    url = "https://nypl.overdrive.com/collection/26060"
    
    puts "\n"+"Here are some audiobooks currently available for download at NYPL:"+"\n\n"
    puts "Loading books..."+"\n\n"

    get_books_from(url)  # populates Book.all 

    loop {
      show_info_for(select_book)
      break if another_book? == false
      show_list
    }

  end

end

