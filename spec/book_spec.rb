require 'spec_helper'

describe 'Book.new' do
  it 'initializes a book with a title and author' do
    book = Book.new(title: 'After Alice', author: 'Gregory Maguire')
    expect(book.title).to eq('After Alice')
    expect(book.author).to eq('Gregory Maguire')
    expect(book.available).to be(true)
  end

  it 'adds the book to available if available' do
     book = Book.new(title: 'After Alice', author: 'Gregory Maguire')
     expect(Book.available_books).to include(book)
  end
end

describe 'Book.create_from_hash' do
  it 'Creates a book from a scraped hash' do
    
  end
end