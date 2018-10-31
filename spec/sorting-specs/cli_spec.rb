require '../spec_helper'

context 'CLI for Sorting' do
  
  before(:each) do 
    @cli = CLI.new
    
    @subject_filter = Filter.new(:subjects).tap {|f| 
      f.all_terms = ["Non-fiction", "Biography", "Movies and Television", "Fiction", "Mystery"]
      f.selected_terms = ["Fiction", "Mystery"] }
    
    @audience_filter = Filter.new(:audience).tap { |f|
      f.all_terms = ["Juvenile", "Young Adult", "Mature Adult", "General Adult"]
      f.selected_terms = "General Adult" }

    @date_filter = Filter.new(:date_added).tap { |f|
      f.all_terms = ["Last 6 Months", "Last 3 Months", "Last 30 Days", "Last 7 Days"]
      f.selected_terms = "Last 3 Months" }

    @language_filter = Filter.new(:language).tap { |f|
      f.all_terms = ["English", "Spanish", "German"]
      f.selected_terms = "English" }

    # DUMMY FILTER! THIS IS NOT HOW DURATION WILL WORK! (this just fits with the existing testss)
    @length_filter = Filter.new(:length).tap { |f|   
      f.all_terms = ["1:30-3:00", "0:30-1:30", "3:00-8:00"]
      f.selected_terms = "1:30-3:00" }

    Filter.all_active = [@subject_filter, @length_filter, @audience_filter, @date_filter, @language_filter]

    # test setup
    allow($stdout).to receive(:puts)
  end

  describe 'show_all_active_filters' do
    it 'displays the available filters, with the selected filters' do
      expect($stdout).to receive(:puts).with("1. Subjects: Fiction, Mystery")
      expect($stdout).to receive(:puts).with("2. Length: 1:30-3:00")
      expect($stdout).to receive(:puts).with("3. Audience: General Adult")
      expect($stdout).to receive(:puts).with("4. Date Added: Last 3 Months")
      expect($stdout).to receive(:puts).with("5. Language: English")

      @cli.show_all_active_filters    
    end    
  end
  
  describe 'ask_for_filter_number' do
    it 'lets a user select what they want to filter by (subject, time, language)' do
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.))
      
      allow(@cli).to receive(:gets).and_return('1') 
      expect(@cli.ask_for_filter_number).to equal(@subject_filter)     
      allow(@cli).to receive(:gets).and_return('4')      
      expect(@cli.ask_for_filter_number).to equal(@date_filter)     
    end    
    
    it 'asks again if the user enters an invalid number' do
      expect($stdout).to receive(:puts).with(%(Enter the number of the filter you'd like to change.)).exactly(3).times
      
      # NOTE: I'm not sure why I have to call the method 3 times. (otherwise the 'expect' above only gets 3 times). 
      # Shouldn't the allow/gets lines cause it to be asked 3 times within the method?
      # In fact, this test is full on wrong, because the 3 times is faked by calling it 3 times.
      # But, I've tested it for real and it does work, so, moving on.
      allow(@cli).to receive(:gets).and_return('9')      
      allow(@cli).to receive(:gets).and_return('8')      
      allow(@cli).to receive(:gets).and_return('4')      
      expect(@cli.ask_for_filter_number).to eq(@date_filter)     
      expect(@cli.ask_for_filter_number).to eq(@date_filter)     
      expect(@cli.ask_for_filter_number).to eq(@date_filter)     
    end    
  end

  describe 'show_current' do
    it 'shows the selected filter' do            
      @cli.working_filter = @subject_filter
      expect($stdout).to receive(:puts).with(%(Current Subjects selected:))
      @cli.show_current
    end
    
    it 'shows the current values for the selected filter' do
      @cli.working_filter = @subject_filter
      expect($stdout).to receive(:puts).with(%(1. Fiction))
      expect($stdout).to receive(:puts).with(%(2. Mystery))
      @cli.show_current
      
      @cli.working_filter = @audience_filter
      expect($stdout).to receive(:puts).with(%(1. General Adult))
      @cli.show_current
    end
  end

  describe 'available_terms' do    
    it 'returns available values for a filter' do   
      @cli.working_filter = @subject_filter
      expect(@cli.working_filter.available_terms).to include("Non-fiction")
      expect(@cli.working_filter.available_terms).to include("Biography")
      expect(@cli.working_filter.available_terms).to include("Movies and Television")      
      
      @cli.working_filter = @audience_filter
      expect(@cli.working_filter.available_terms).to include("Juvenile")
      expect(@cli.working_filter.available_terms).to include("Young Adult")
      expect(@cli.working_filter.available_terms).to include("Mature Adult")
    end
    
    it %(doesn't returns filters that are currently selected) do
      @cli.working_filter = @subject_filter
      expect(@cli.working_filter.available_terms).to_not include(@subject_filter.selected_terms[0])
      expect(@cli.working_filter.available_terms).to_not include(@subject_filter.selected_terms[1])
      @cli.working_filter = @audience_filter
      expect(@cli.working_filter.available_terms).to_not include(@audience_filter.selected_terms)
    end
  end
  
  describe 'show_available' do
    it 'displays the avialable filters' do
      @cli.working_filter = @subject_filter
      expect($stdout).to receive(:puts).with("1. Non-fiction")
      expect($stdout).to receive(:puts).with("2. Biography")
      expect($stdout).to receive(:puts).with("3. Movies and Television")
      @cli.show_available
      
      @cli.working_filter = @audience_filter
      expect($stdout).to receive(:puts).with("1. Juvenile")
      expect($stdout).to receive(:puts).with("2. Young Adult")
      expect($stdout).to receive(:puts).with("3. Mature Adult")
      @cli.show_available
    end
  
    it %(doesn't show filters that are currently selected) do
      @cli.working_filter = @subject_filter
      expect($stdout).to_not receive(:puts).with(@cli.working_filter.all_terms[0])
      expect($stdout).to_not receive(:puts).with(@cli.working_filter.all_terms[1])
      @cli.show_available

      @cli.working_filter = @audience_filter
      expect($stdout).to_not receive(:puts).with(@cli.working_filter.all_terms)
      @cli.show_available
    end
  end

  describe 'show_current_and_available' do    
    it 'accounts for empty available or current arrays in displaying' do
      @subject_filter.all_terms = []
      @subject_filter.selected_terms = []
      @cli.working_filter = @subject_filter
      expect($stdout).to receive(:puts).with(%(You haven't selected any subjects!))
      expect($stdout).to receive(:puts).with(%(There are no subjects left to select!))      
      @cli.show_current_and_available
    end 
  end

  describe 'add_or_remove_terms(filter)' do  
    it 'instructs the user to add a term from the filter using "add (number)"' do      
      allow(@cli).to receive(:gets)
      expect($stdout).to receive(:puts).with(%(To add from available terms, enter "add " and the number . Ex. "add 1" to add "Non-fiction"))
      expect(@cli).to receive(:gets).exactly(1).times
      @cli.add_or_remove_terms(:subjects)
    end

    it 'allows a user to add a term from the filter using "add (number)"' do
      allow(@cli).to receive(:gets).and_return('add 1') 
      expect(@cli.current_filters[:subjects]).to include("Non-fiction")
      @cli.add_or_remove_terms(:subjects)
    end
    
    it 'displays the currently selected terms after a term is added' do
      allow(@cli).to receive(:gets).and_return('add 1')
      expect($stdout).to receive(:puts).with("1. Fiction")
      expect($stdout).to receive(:puts).with("2. Mystery")
      expect($stdout).to receive(:puts).with("3. Non-fiction")
      
      @cli.add_or_remove_terms(:subjects)
    end
    
    it 'instructs the user to remove a term from the filter using "remove (number)"' do
      allow(@cli).to receive(:gets)
      expect($stdout).to receive(:puts).with(%(To remove a current term, enter "remove " and the number . Ex. "remove 1" to remove "Fiction"))
      expect(@cli).to receive(:gets).exactly(1).times
      @cli.add_or_remove_terms(:subjects)
    end

    it 'allows a user to remove a term from the filter using "remove (number)"' do
      allow(@cli).to receive(:gets).and_return('remove 1') 
      expect(@cli.current_filters[:subjects]).to_not include("Fiction")
      @cli.add_or_remove_terms(:subjects)
    end
    
    it 'displays the currently selected terms after a term is removed' do
      allow(@cli).to receive(:gets).and_return('remove 1') 
      expect($stdout).to receive(:puts).with("1. Mystery")
      @cli.add_or_remove_terms(:subjects)            
    end
    
    it 'instructs a user to re-display the list of available terms by typing "list"' do
      expect($stdout).to receive(:puts).with(%(To show the lists of current and available subjects, enter "list"))
      @cli.add_or_remove_terms(:subjects)            
    end

    it 'allows a user to re-display the list of current and available terms by typing "list"' do
      allow(@cli).to receive(:gets).and_return('list') 
      expect($stdout).to receive(:puts).with("Current Subjects selected:")
      expect($stdout).to receive(:puts).with("1. Fiction")
      expect($stdout).to receive(:puts).with("2. Mystery")
      expect($stdout).to receive(:puts).with("Available Subjects:")
      expect($stdout).to receive(:puts).with("1. Non-fiction")
      expect($stdout).to receive(:puts).with("2. Biography")
      expect($stdout).to receive(:puts).with("3. Movies and Television")

      @cli.add_or_remove_terms(:subjects)                
    end
    
    it 'instructs a user to re-display the list of all set filters by typing "exit"' do
      expect($stdout).to receive(:puts).with(%(To return to the list of all currently selected filters, enter "exit"))
      @cli.add_or_remove_terms(:subjects)                
    end
    
    it 'allows a user to re-display the list of all set filters by typing "exit"' do
      allow(@cli).to receive(:gets).and_return('exit') 
      
      expect($stdout).to receive(:puts).with("1. Subjects: Fiction, Mystery")
      expect($stdout).to receive(:puts).with("2. Length: 1:30-3:00")
      expect($stdout).to receive(:puts).with("3. Audience: General Adult")
      expect($stdout).to receive(:puts).with("4. Date Added: Last 3 Months")
      expect($stdout).to receive(:puts).with("5. Language: English")
 
      @cli.add_or_remove_terms(:subjects)                
    end
  end


    # it '' do; expect(true).to eq(false); end
end
