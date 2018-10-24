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

  def book_from_list(url:)
    puts "Here are some audiobooks currently available for download at NYPL:"
    puts ""
    puts "1. Who Was Rosa Parks? - Yona Zeldia McDonough"
    puts "2. Frostbite - Richelle Mead"
    puts ""
    puts "Enter the number for a book you'd like to know more about:"
    num = gets.strip.to_i # TO-DO: Validate input
  end

  def show_info_for(book)
    def test_text   
      puts ""
      puts "\"Who Was Rosa Parks?\" (2016)"
      puts "by Yona Zeldis McDonough"
      puts "Length: 01:08:56"
      puts ""
      puts 'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."'
      puts ""
    end
    puts "\"#{book.title}\" (#{book.year})"
    puts "by #{book.author}"
    puts "Length: #{book.duration}"
    puts book.description + '\n'
    # test_text
  end 

  def run
    book_from_list(url:)
    show_info_for(:book)
  end

end

CLI.new.run