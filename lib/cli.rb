

class CLI

  attr_accessor :working_filter, :current_filters, :all_terms

  def show_all_active_filters
    Filter.all_active.each.with_index(1) { |filter, i|
      value = [filter.selected_terms] # TO-DO: Each filter should have its own description property?
      puts %(#{i}. #{filter.name.titleize}: #{[value].join(', ')})
    }
  end

  def ask_for_filter_number # => filter key (symbol)
    # DANGER: This assumes we are displaying the keys in the same order that they're being iterated. This is probably WRONG. But we'll tackle it later if it breaks. Shouldn't be too hard to fix but will require expanding the data structure a bit.
    loop do
      puts %(Enter the number of the filter you'd like to change.)
      i = gets.to_i
      return Filter.all_active[i - 1] if i.between?(1, Filter.all_active.count)
    end
  end
     
  def show_current_and_available
    show_current
    show_available
  end
  
  def current_terms
    [@working_filter.selected_terms].flatten
  end

  def show_current
    if current_terms.count == 0 
      puts %(There are no #{@working_filter.name.to_s} left to select!)
    else
      puts %(Current #{@working_filter.name.titleize} selected:)
      current_terms.each.with_index(1) { |term, i| puts "#{i}. #{term}" }
    end
  end
  
  def show_available # => available   
    if @working_filter.available_terms.count == 0 
      puts %(You haven't selected any #{@working_filter.name.to_s}!)
    else
      puts %(Available #{@working_filter.name.titleize}:)
      @working_filter.available_terms.each.with_index(1) { |term, i| puts "#{i}. #{term}" } 
    end
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
      show_all_active_filters
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
    show_all_active_filters
    @working_filter = ask_for_filter_number
    show_current_and_available(filter)
    add_or_remove_terms(filter)
  end
end

class C_LI # the actual scraping interface 

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

class Symbol # titleize extension
  def titleize
    self.to_s.gsub('_',' ').gsub(/\w+/) {|x| x.capitalize}
  end
end