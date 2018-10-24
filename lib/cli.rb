require_relative '../config/environment.rb'

class CLI

  def _run
    puts "Here are some audiobooks currently available for download at NYPL:"
    nypl_url = "./fixtures/available-now-list/available-now.htm"
    
    # list = Scraper.scrape_book_list(nypl_url)
    list = Book.available_books

    list.each.with_index(1) { |book, i|
      puts "#{i}. #{book.title} - #{book.author}"
      # puts "#{i}. #{book[:title]} - #{book[:author]}"
    }
  end

  def book_from_list(url:"./fixtures/available-now-list/available-now.htm")
    puts "Here are some audiobooks currently available for download at NYPL:"
    puts ""
    puts "1. Who Was Rosa Parks? - Yona Zeldia McDonough"
    puts "2. Frostbite - Richelle Mead"
    puts ""
    puts "Enter the number for a book you'd like to know more about:"
    num = gets.strip.to_i # TO-DO: Validate input

    book = Book.new(title:"Who Was Rosa Parks?", author:"Yona Zeldia McDonough").tap {|book|
      book.description = 'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."'
      book.duration = "01:08:56"
      book.year = "2016"
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
    book = book_from_list
    show_info_for(book)
  end

end

# CLI.new.run