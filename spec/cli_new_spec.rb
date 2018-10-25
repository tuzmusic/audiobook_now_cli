require 'spec_helper'

url = "./fixtures/available-now-list/available-now.htm"
cli = CLI.new

describe 'get_books_from(url)' do
  it 'adds books at the url to Book.all' do
    # oops, this is async so other gems are required    
    expect(Book.all.count).to eq(24)
    cli.get_books_from(url)
  end

end