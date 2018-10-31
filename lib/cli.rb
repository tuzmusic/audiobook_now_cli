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

  def show_all_filters
    Filter.all_current.each.with_index(1) { |(filter, terms), i|
      value = [terms] # TO-DO: Each filter should have its own description property?
      puts %(#{i}. #{filter.titlelize}: #{[value].join(', ')})
    }
  end

  def ask_for_filter_number
    loop {
      puts %(Enter the number of the filter you'd like to change.)
      i = gets.to_i - 1
      return Filter.all_current.keys[i] if i >= 0 && i < Filter.all_current.keys.count  
    }
  end
    
  def show_current(filter)
    current = [current_filters[filter]].flatten
    if current.count == 0 
      puts %(There are no #{filter.to_s} left to select!)
    else
      puts %(Current #{filter.titlelize} selected:)
      current.each.with_index(1) { |term, i| puts "#{i}. #{term}" }
    end
  end

  def available_terms_for(filter) # => available terms
    all = [all_terms[filter]].flatten
    current = [current_filters[filter]].flatten
    all.select { |term| !current.include?(term)} 
  end
  
  def show_available(filter) # => available   
    available = available_terms_for(filter)
    if available.count == 0 
      puts %(You haven't selected any #{filter.to_s}!)
    else
      puts %(Available #{filter.titlelize}:)
      available.each.with_index(1) { |term, i| puts "#{i}. #{term}" } 
    end
  end

  def show_current_and_available(filter)
    show_current(filter)
    show_available(filter)
  end

  def add_or_remove_terms(filter)
    available = available_terms_for(filter)

    # show options
    puts %(To add from available terms, enter "add " and the number . Ex. "add 1" to add "#{available[0]}")
    puts %(To remove a current term, enter "remove " and the number . Ex. "remove 1" to remove "#{current_filters[filter][0]}")
    puts %(To show the lists of current and available subjects, enter "list")
    puts %(To return to the list of all currently selected filters, enter "exit")
    
    # ask for input
    input = gets
    return if !input

    terms = input.split(' ')
    arg = terms[0]
    num = (terms[1].to_i - 1) if terms[1]
    
    case arg
    when 'exit'  
      show_all_filters
    when 'add'
      current_filters[filter] << available[num]
      show_current_and_available(filter)
    when 'remove'
      current_filters[filter].delete_at(num)
      show_current_and_available(filter)
    when 'list'
      show_current_and_available(filter)
    else  
      # invalid input
    end

  end

  def run
    set_backup_values
    show_all_filters
    filter = ask_for_filter_number
    show_current_and_available(filter)
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
