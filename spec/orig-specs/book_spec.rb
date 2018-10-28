require 'spec_helper'

describe 'Book.new' do
  let!(:book) { Book.new(title: 'After Alice', author: 'Gregory Maguire') }
  it 'initializes a book with a title and author' do
    expect(book.title).to eq('After Alice')
    expect(book.author).to eq('Gregory Maguire')
  end

  it 'fails if no title or author provided' do
    expect{Book.new(title: "name of book")}.to raise_error(ArgumentError)
    expect{Book.new(author: "author of book")}.to raise_error(ArgumentError)

  end
  
  it 'sets the availability to \'true\' by default' do   
    expect(book.available).to be(true)
  end

  it 'adds the book to available if available' do
     expect(Book.available_books).to include(book)
  end
end

describe 'Book.create_from_hash' do

  let!(:book_info) {  
    {:title=>"Who Was Rosa Parks?", :author=>"Yona Zeldis McDonough", :description=>'In 1955, Rosa Parks refused to give her bus seat to a white passenger in Montgomery, Alabama. This seemingly small act triggered civil rights protests across America and earned Rosa Parks the title "Mother of the Civil Rights Movement."',:duration=>"01:08:56", :year=>"2016"}
  }

  it 'Creates a book from a scraped hash' do
    book = Book.create_from_hash(book_info)
    expect(book.title). to eq(book_info[:title])
    expect(book.author). to eq(book_info[:author])
    expect(book.description). to eq(book_info[:description])
    expect(book.year). to eq(book_info[:year])
    expect(book.duration). to eq(book_info[:duration])
  end

  it 'fails if no title or author provided' do
    no_title_hash = {author:"author with no title", description:"TL;DR", duration:"1:09"}
    no_author_hash = {title:"title with no author", description:"TL;DR", duration:"1:09"}
    # bad_book = Book.create_from_hash(no_title_hash)
    # binding.pry

    expect{Book.create_from_hash(no_title_hash)}.to raise_error(ArgumentError)
    expect{Book.create_from_hash(no_author_hash)}.to raise_error(ArgumentError)

  end

  it 'can handle hashes with other properties missing' do
    okay_hash = {title:"book with no year", author:"someone awesome", description:"TL;DR", duration:"1:09"}
    expect{Book.create_from_hash(okay_hash)}.to_not raise_error
  end



end