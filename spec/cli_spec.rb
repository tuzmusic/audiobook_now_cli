require 'spec_helper'

# describe 'CLI.run' do
#   it 'puts "hi there"' do
#     allow($stdout).to receive(:puts)
#     expect($stdout).to receive(:puts).with("hi there")
#     CLI.new.run
#   end
# end

describe '#show_info_for(:book_at_url)' do

  let!(:book_info) {  
      {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
    }

  it 'shows info for a book' do
    allow($stdout).to receive(:puts)
    expect($stdout).to receive(:puts).with("\"#{book_info[:title]}\" (#{book_info[:year]})")
    expect($stdout).to receive(:puts).with("by #{book_info[:author]}")
    expect($stdout).to receive(:puts).with("Length: #{book_info[:duration]}")
    expect($stdout).to receive(:puts).with(book_info[:description])

    CLI.new.show_info_for(book_at_url: nil)
  end
end
