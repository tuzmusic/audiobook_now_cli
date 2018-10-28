require '../spec_helper'
# require '../../lib/cli.rb'


context 'CLI for Sorting' do
  describe 'top-level of CLI' do
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
      expect($stdout).to receive(:puts).with("1. Subjects: Fiction, Mystery")
      expect($stdout).to receive(:puts).with("2. Length: 1:30-3:00")
      expect($stdout).to receive(:puts).with("3. Audience: General Adult")
      expect($stdout).to receive(:puts).with("4. Date Added: Last 3 Months")
      expect($stdout).to receive(:puts).with("5. Language: English")
      
      CLI.new.run 
=begin
Filter categories:
  subject
  audience (Juvenile, Young Adult, General Adult, Mature Adult)
  language
  date added (last 7/14/30 days, 3/6 months)
  --availability--

=end
    end    
    it 'lets a user select what they want to filter by (subject, time, language)' do; 

      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.))

      # expect{test}.to output(%(Enter the number of the filter you'd like to change.)).to_stdout
      CLI.new.ask_for_filter_number
      
    end    
    # it '' do; end    
  end

  describe 'Sorting by subject' do
    it 'displays a list of available subjects to sort by' do; end
    it 'allows a user to select a subject' do; end
    it 'adds to Filter.selected when a user selects a subject' do; end
    it 'allows a user to delete a subject from their selected list' do; end
    it 'uses Filter.show_selected when a user selects or deletes a subject' do; end
    it 'allows a user to re-display the list of available subjects by typing "list"' do; end
    it 'allows a user to re-display the list of all set filters (from Filter.selected) by typing "list filters"' do; end
    it 'allows a user to exit subject selections by typing "done"' do; end
    it '' do; end
  end
end