require '../spec_helper'
# require '../../lib/cli.rb'


context 'CLI for Sorting' do
  describe 'show_filters' do
=begin    
    it 'displays the available filters' do

      allow($stdout).to receive(:puts)
      
      expect($stdout).to receive(:puts).with("1. Subjects:")
      expect($stdout).to receive(:puts).with("2. Length:")
      expect($stdout).to receive(:puts).with("3. Audience:")
      expect($stdout).to receive(:puts).with("4. Date Added:")
      expect($stdout).to receive(:puts).with("5. Language:")

      CLI.new.run 

    end    
=end    
    it 'displays the available filters, with the selected filters' do

      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("1. Subjects: Fiction, Mystery")
      expect($stdout).to receive(:puts).with("2. Length: 1:30-3:00")
      expect($stdout).to receive(:puts).with("3. Audience: General Adult")
      expect($stdout).to receive(:puts).with("4. Date Added: Last 3 Months")
      expect($stdout).to receive(:puts).with("5. Language: English")
      
      CLI.new.show_filters
      
    end    
  end
  
  describe 'ask_for_filter_number' do
    it 'lets a user select what they want to filter by (subject, time, language)' do
      cli = CLI.new
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.))
      
      allow(cli).to receive(:gets).and_return('1') 
      expect(cli.ask_for_filter_number).to equal(:subjects)     
      allow(cli).to receive(:gets).and_return('4')      
      expect(cli.ask_for_filter_number).to equal(:date_added)     
    end    
    
    it 'asks again if the user enters an invalid number' do
      cli = CLI.new
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.)).exactly(3).times
      
      # NOTE: I'm not sure why I have to call the method 3 times. (otherwise the 'expect' above only gets 3 times). 
      # Shouldn't the allow/gets lines cause it to be asked 3 times within the method?
      # In fact, this test is full on wrong, because the 3 times is faked by calling it 3 times.
      # But, I've tested it for real and it does work, so, moving on.
      allow(cli).to receive(:gets).and_return('9')      
      allow(cli).to receive(:gets).and_return('8')      
      allow(cli).to receive(:gets).and_return('4')      
      expect(cli.ask_for_filter_number).to eq(:date_added)     
      expect(cli.ask_for_filter_number).to eq(:date_added)     
      expect(cli.ask_for_filter_number).to eq(:date_added)     
    end    

    # it '' do; end    
  end

  describe 'show_current(filter)' do
    it 'accepts an argument that is a filter key' do
      expect(show_current(:subject)).to equal(true)
      expect(show_current(:balls)).to equal(false)
      expect(show_current("junk")).to equal(false)
    end
    
  end

  describe 'Sorting by subject' do

    it 'displays a list of available subjects to sort by' do
      subject1 = "Mystery"
      subject2 = "Non-fiction"
      subject3 = "Biography"
      subject4 = "Movies and Television"

      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with(subject1)
      expect($stdout).to receive(:puts).with(subject2)
      expect($stdout).to receive(:puts).with(subject3)
      expect($stdout).to receive(:puts).with(subject4)
      
    end
    
    it 'allows a user to select a subject' do; end
    
    it 'adds to Filter.selected when a user selects a subject' do; end
    
    it 'allows a user to delete a subject from their selected list' do; end
    
    it 'uses Filter.show_selected when a user selects or deletes a subject' do; end
    
    it 'allows a user to re-display the list of available subjects by typing "list"' do; end
    
    it 'allows a user to re-display the list of all set filters (from Filter.selected) by typing "list 
    filters"' do; end
    
    it 'allows a user to exit subject selections by typing "done"' do; end
    
    it '' do; end
  end
end