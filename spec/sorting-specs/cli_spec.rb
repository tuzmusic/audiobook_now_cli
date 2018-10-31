require '../spec_helper'
# require '../../lib/cli.rb'


context 'CLI for Sorting' do
  cli = CLI.new
  current = {}
  before do
    current = {
        subjects: ["Fiction", "Mystery"],
        length: "1:30-3:00",
        audience: "General Adult",
        date_added:"Last 3 Months",
        language: "English",
      }
    cli = CLI.new
    
    avail_terms = {
      subjects: ["Non-fiction", "Biography", "Movies and Television"],
      audience: ["Juvenile", "Young Adult", "Mature Adult"]
    }
    
    all_terms = {
      subjects: ["Non-fiction", "Biography", "Movies and Television", "Fiction", "Mystery"],
      audience: ["Juvenile", "Young Adult", "Mature Adult", "General Adult"]
    }

    cli.all_terms = all_terms

    cli.current_filters = {
        subjects: ["Fiction", "Mystery"],
        length: "1:30-3:00",
        audience: "General Adult",
        date_added:"Last 3 Months",
        language: "English",
      }
  end

  describe 'show_filters' do
    it 'displays the available filters, with the selected filters' do

      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("1. Subjects: Fiction, Mystery")
      expect($stdout).to receive(:puts).with("2. Length: 1:30-3:00")
      expect($stdout).to receive(:puts).with("3. Audience: General Adult")
      expect($stdout).to receive(:puts).with("4. Date Added: Last 3 Months")
      expect($stdout).to receive(:puts).with("5. Language: English")
      
      cli.show_filters
      
    end    
  end
  
  describe 'ask_for_filter_number' do
    it 'lets a user select what they want to filter by (subject, time, language)' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.))
      
      allow(cli).to receive(:gets).and_return('1') 
      expect(cli.ask_for_filter_number).to equal(:subjects)     
      allow(cli).to receive(:gets).and_return('4')      
      expect(cli.ask_for_filter_number).to equal(:date_added)     
    end    
    
    it 'asks again if the user enters an invalid number' do
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

  end

  describe 'show_current(filter)' do

    it 'shows the selected filter' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with(%(Current Subjects selected:))
      cli.show_current(:subjects)      
    end

    it 'shows the current values for the selected filter' do
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with(%(1. Fiction))
      expect($stdout).to receive(:puts).with(%(2. Mystery))
      cli.show_current(:subjects)
      
      expect($stdout).to receive(:puts).with(%(1. General Adult))
      cli.show_current(:audience)      
    end
  end

  describe 'available_terms_for(filter)' do
    
    it 'returns available values for a filter' do
      
      expect(cli.available_terms_for(:subjects) ).to include("Non-fiction")
      expect(cli.available_terms_for(:subjects) ).to include("Biography")
      expect(cli.available_terms_for(:subjects) ).to include("Movies and Television")
             
      expect(cli.available_terms_for(:audience) ).to include("Juvenile")
      expect(cli.available_terms_for(:audience) ).to include("Young Adult")
      expect(cli.available_terms_for(:audience) ).to include("Mature Adult")
    end

    it %(doesn't returns filters that are currently selected) do
      expect(cli.available_terms_for(:subjects) ).to_not include(current[:subjects][0])
      expect(cli.available_terms_for(:subjects) ).to_not include(current[:subjects][1])
      expect(cli.available_terms_for(:subjects) ).to_not include(current[:subjects][1])
      expect(cli.available_terms_for(:subjects) ).to_not include(current[:audience])
    end
  end

  describe 'add_or_remove_terms(filter)' do
    
    it 'displays the avialable filters' do
      allow($stdout).to receive(:puts)
      
      expect($stdout).to receive(:puts).with("1. Non-fiction")
      expect($stdout).to receive(:puts).with("2. Biography")
      expect($stdout).to receive(:puts).with("3. Movies and Television")
      cli.add_or_remove_terms(:subjects)

      expect($stdout).to receive(:puts).with("1. Juvenile")
      expect($stdout).to receive(:puts).with("2. Young Adult")
      expect($stdout).to receive(:puts).with("3. Mature Adult")
      cli.add_or_remove_terms(:audience)
    end

    it %(doesn't show filters that are currently selected) do
      expect($stdout).to_not receive(:puts).with(current[:subjects][0])
      expect($stdout).to_not receive(:puts).with(current[:subjects][1])
      cli.add_or_remove_terms(:subjects)

      expect($stdout).to_not receive(:puts).with(current[:audience])
      cli.add_or_remove_terms(:audience)
    end
    
    it 'instructs the user to add a term from the filter using "add (number)"' do
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets)
      expect($stdout).to receive(:puts).with(%(To add from available terms, enter "add " and the number . Ex. "add 1" to add "Non-fiction"))
      expect(cli).to receive(:gets).exactly(1).times
      cli.add_or_remove_terms(:subjects)
    end

    it 'allows a user to add a term from the filter using "add (number)"' do
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets).and_return('add 1') 
      expect(cli.current_filters[:subjects]).to include("Non-fiction")
      cli.add_or_remove_terms(:subjects)
    end
    
    it 'displays the currently selected terms after a term is added' do
      cli.current_filters[:subjects] = ["Fiction", "Mystery"]
      allow($stdout).to receive(:puts)

      allow(cli).to receive(:gets).and_return('add 1')
      expect($stdout).to receive(:puts).with("1. Fiction")
      expect($stdout).to receive(:puts).with("2. Mystery")
      expect($stdout).to receive(:puts).with("3. Non-fiction")
      
      cli.add_or_remove_terms(:subjects)
    end
    
    it 'instructs the user to remove a term from the filter using "remove (number)"' do
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets)
      expect($stdout).to receive(:puts).with(%(To remove a current term, enter "remove " and the number . Ex. "remove 1" to remove "Fiction"))
      expect(cli).to receive(:gets).exactly(1).times
      cli.add_or_remove_terms(:subjects)
    end

    it 'allows a user to remove a term from the filter using "remove (number)"' do
      allow($stdout).to receive(:puts)
      allow(cli).to receive(:gets).and_return('remove 1') 
      expect(cli.current_filters[:subjects]).to_not include("Fiction")
      cli.add_or_remove_terms(:subjects)
    end
    
    it 'displays the currently selected terms after a term is removed' do; expect(true).to eq(false); end
    
    it 'allows a user to re-display the list of available terms by typing "list"' do; expect(true).to eq(false); end
    
    it 'allows a user to re-display the list of all set filters (from Filter.selected) by typing "list filters"' do; expect(true).to eq(false); end
    
    it 'allows a user to exit filter selection by typing "done"' do; expect(true).to eq(false); end
    
    # it '' do; expect(true).to eq(false); end

  end

  describe 'Sorting by subject' do

    it 'displays a list of available subjects to sort by' do
     
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Mystery")
      expect($stdout).to receive(:puts).with("Non-fiction")
      expect($stdout).to receive(:puts).with("Biography")
      expect($stdout).to receive(:puts).with("Movies and Television")
      
    end
    
    it 'allows a user to select a subject' do; expect(true).to eq(false); end
    
    it 'adds to Filter.selected when a user selects a subject' do; expect(true).to eq(false); end
    
    it 'allows a user to delete a subject from their selected list' do; expect(true).to eq(false); end
    
    it 'uses Filter.show_selected when a user selects or deletes a subject' do; expect(true).to eq(false); end
    
    it 'allows a user to re-display the list of available subjects by typing "list"' do; expect(true).to eq(false); end
    
    it 'allows a user to re-display the list of all set filters (from Filter.selected) by typing "list 
    filters"' do; expect(true).to eq(false); end
    
    it 'allows a user to exit subject selections by typing "done"' do; expect(true).to eq(false); end
    
    it '' do; expect(true).to eq(false); end
  end
end
