require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rspec'
require 'capybara/poltergeist'
require 'require_all'
require 'bundler'

# Bundler.require

# require_all 'lib'

require_relative '../lib/cli.rb'
require_relative '../lib/book.rb'
require_relative '../lib/scraper.rb'
