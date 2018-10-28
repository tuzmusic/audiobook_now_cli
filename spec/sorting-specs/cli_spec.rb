# require '../spec_helper'
require '../../lib/cli.rb'


context 'CLI for Sorting' do
  describe 'top-level of CLI' do
    it 'displays the current filters' do

      test_str = %(Current filters:
      1. Subjects: Fiction, Mystery
      2. Length: 1:30-3:00
      3. Language: English
      )

      expect(STDOUT).to receive(:puts).with(test_str)
    
      CLI.new.run

    end    
    it 'displays the available filters' do
      
    end    
    it 'lets a user select what they want to filter by (subject, time, language)' do; end    
    it '' do; end    
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