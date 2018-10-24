require 'spec_helper'

context 'CLI' do
     
  let!(:book_hash) {  
      {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
    }

  describe '#book_from_list(url:)' do

  it 'Shows the books on the page at the URL given' do
    allow($stdout).to receive(:puts)
    expect($stdout).to receive(:puts).with("1. Who Was Rosa Parks? - Yona Zeldia McDonough")
    expect($stdout).to receive(:puts).with("2. Frostbite - Richelle Mead")

    CLI.new.book_from_list
  end

  it 'asks the user to choose a book' do
    allow($stdout).to receive(:puts)
    expect($stdout).to receive(:puts).with("Enter the number for a book you'd like to know more about:")
    CLI.new.book_from_list
  end 

  # it 'gets the user\'s input' do
  #   cli = CLI.new
  #   allow($stdout).to receive(:puts)
  #   allow(cli).to receive(:gets).and_return('1')
  #   expect(cli.book_from_list).to eq(1)
  # end

  it 'returns that book as an object' do
    cli = CLI.new
    allow($stdout).to receive(:puts)
    allow(cli).to receive(:gets).and_return('1')
    expect(cli.book_from_list).to eq(Book.create_from_hash(book_hash))
  end
end

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
end
end
