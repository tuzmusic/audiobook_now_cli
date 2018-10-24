require 'spec_helper'

# describe 'CLI.run' do
#   it 'puts "hi there"' do
#     allow($stdout).to receive(:puts)
#     expect($stdout).to receive(:puts).with("hi there")
#     CLI.new.run
#   end
# end

describe '#show_info_for(book)' do

  let!(:book_hash) {  
      {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
    }

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
