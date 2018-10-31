require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'capybara/poltergeist'
require 'require_all'
require 'bundler'


# require_all '../lib/*'
# require 'require_all'
# require_rel ('../lib')

require_relative "../lib/book.rb"
require_relative "../lib/cli.rb"
require_relative "../lib/filter.rb"
require_relative "../lib/scraper.rb"