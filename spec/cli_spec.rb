require 'spec_helper'
require_relative '../lib/cli.rb'

describe 'CLI.run' do
  it 'puts "hi there"' do
    allow($stdout).to receive(:puts)
    expect($stdout).to receive(:puts).with("hi there")
    CLI.new.run
  end
  
end
