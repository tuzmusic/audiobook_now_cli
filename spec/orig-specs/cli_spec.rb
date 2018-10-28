require 'spec_helper'

context 'CLI' do
     
  let!(:book_hash) {  
      {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
    }

  describe '#book_from_list(url:)' do

    url = "./fixtures/available-now-list/available-now.htm"

    # TO-DO: It (ultimately) needs to get all the info (or at least the duration) for each book when it shows the list! That's the whole point!

    it 'Shows the books on the page at the URL given' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("1. Who Was Rosa Parks? - Yona Zeldis McDonough")
      expect($stdout).to receive(:puts).with("2. Frostbite - Richelle Mead")

      CLI.new.book_from_list(url)
    end

    it 'asks the user to choose a book' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("Enter the number for a book you'd like to know more about:")
      CLI.new.book_from_list(url)
    end 

    it 'returns that book as an object' do
      cli = CLI.new
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets).and_return('1')

      book = Book.create_from_hash(book_hash)
      test = cli.book_from_list(url)

      expect(test.title).to eq(book.title)
      expect(test.author).to eq(book.author)
      # expect(test.description).to eq(book.description)
      # expect(test.duration).to eq(book.duration)
      # expect(test.year).to eq(book.year)
    end

    it 'returns the 2nd book if user enters "2"' do
      cli = CLI.new
      book = Book.new(title:"Frostbite", author:"Richelle Mead")
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets).and_return('2')
      test = cli.book_from_list(url)
      expect(test.title).to eq(book.title)
      expect(test.author).to eq(book.author)
    end

  end #describe

  describe '#show_info_for(book)' do

    it 'shows info for a book' do

      # REMEMBER: This hash is just to populate the tests.
      # i.e., the objects/hashes/etc we use in the test don't have to change as the method changes.  
      # HOWEVER: the object we give to the actual call in the test is important.

      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("\"#{book_hash[:title]}\" (#{book_hash[:year]})")
      expect($stdout).to receive(:puts).with("by #{book_hash[:author]}")
      expect($stdout).to receive(:puts).with("Length: #{book_hash[:duration]}")
      expect($stdout).to receive(:puts).with(book_hash[:description])

      book = Book.create_from_hash(book_hash)

      CLI.new.show_info_for(book)
    end
    
end #describe

end #context
