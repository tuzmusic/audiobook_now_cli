require '../spec_helper'

context 'Filter object' do
  filter = Filter.new(:subjects)

  before do    
  
  end
  
  describe 'HAVING: Filter instance methods and properties' do    
    it '@name property is a user-facing name for the filter' do
      # expect(filter).to have_attributes(:name => :subjects)
      expect(filter).to respond_to(:name)
    end
    
    it '@all_terms stores the possible terms (i.e., all the subjects for the subjects filter)' do
      expect(filter).to respond_to(:all_terms)
      # expect(filter).to have_attributes(:all_terms => [])
    end
    
    it '@selected_terms returns the currently selected terms' do
          expect(filter).to respond_to(:selected_terms)
    end
    
    it '@url stores the query for the filter' do
      expect(filter).to respond_to(:url)
    end
    
    xit 'returns nil for the @all_terms for filters that don\'t have a list (like duration)' do; expect(true).to eq(false); end
    
    # it '' do; expect(true).to eq(false); end
  end
  
  describe 'USING: Filter instance methods and properties' do    
    
    it '@all_terms stores the possible terms (i.e., all the subjects for the subjects filter)' do
      expect(true).to eq(false)
    end
    
    it '@selected_terms returns the currently selected terms' do; expect(true).to eq(false); end
    
    it '@url stores the query for the filter' do; expect(true).to eq(false); end
    
    xit 'returns nil for the @all_terms for filters that don\'t have a list (like duration)' do; expect(true).to eq(false); end
    
    # it '' do; expect(true).to eq(false); end
  end

  describe 'Filter.current_all' do    
    it 'includes all currently selected filters' do; expect(true).to eq(false); end
  end
  
  describe 'Filter.show_current' do    
    it 'prints all currently selected filters' do; expect(true).to eq(false); end
  end

end
