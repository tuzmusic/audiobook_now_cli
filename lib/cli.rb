require 'pry'
require 'active_support'
require_relative '../config/environment.rb'

class Symbol # titleize extension
  def titlelize
    self.to_s.gsub('_',' ').gsub(/\w+/) {|x| x.capitalize}
  end
end

class CLI

  def stringified_value(value)
    value = value.join(', ') if value.class == Array
    value
  end

  # calls to test_filters_hash should ultimately be refactored to Filters.current or Search.filters or search#filters or something
  def self.test_filters_hash
    filters_hash = {
      subjects: ["Fiction", "Mystery"],
      length: "1:30-3:00",
      audience: "General Adult",
      date_added:"Last 3 Months",
      language: "English",
    }
  end

  attr_accessor :current_filters, :all_terms

  def self.filters # => array of available filters. 
    # TO DO: this belongs in a class method on Filters
    filters_array = [
      :subjects,
      :length,
      :audience,
      :date_added,
      :language,
    ]
  end

  def filters
    CLI.filters
  end

  def show_filters
    # binding.pry
    CLI.filters.each.with_index(1) { |filter, i|
      value = stringified_value(current_filters[filter]) # TO-DO: Each filter should have its own description property?
      value = value.join(', ') if value.class == Array
      puts %(#{i}. #{filter.titlelize}: #{value})
    }
  end

  def ask_for_filter_number
    loop {
      puts %(Enter the number of the filter you'd like to change.)
      i = gets.to_i - 1
      return filters[i] if i >= 0 && i < filters.count  
    }
  end
    
  def show_current(filter)
    puts %(Current #{filter.titlelize} selected:)
    terms = [current_filters[filter]].flatten
    terms.each { |term| puts term }
  end

  def show_available(filter)
    puts %(Available #{filter.titlelize}:)
    all = [all_terms[filter]].flatten
    current = [current_filters[filter]]
    all.each { |term| 
      puts term if !current.flatten.include?(term)
    }
  end

  def run
    set_backup_values
    show_filters
    filter = ask_for_filter_number
    show_current(filter)
    show_available(filter)
    add_or_remove_terms(filter)
  end

  def set_backup_values
    if current_filters == nil
      puts "setting backup filters"
      self.current_filters = {
        subjects: ["Fiction", "Mystery"],
        length: "1:30-3:00",
        audience: "General Adult",
        date_added:"Last 3 Months",
        language: "English",
      }
    end
    if all_terms == nil 
      self.all_terms = {
        subjects: ["Non-fiction", "Biography", "Movies and Television", "Fiction", "Mystery"],
        audience: ["General Adult", "Juvenile", "Young Adult", "Mature Adult",]
      }
    end
  end

end

class C_LI

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

# CLI.new.run
