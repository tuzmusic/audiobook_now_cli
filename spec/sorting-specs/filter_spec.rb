require '../spec_helper'

context 'Filter object' do
  describe 'Filter superclass' do    
    it 'has a property to store the url query for the filter' do; end
    it 'stores all the possible filters (i.e., all the subjects for the subjects filter)' do; end
    it 'returns nil for the "all" property for filters that don\'t have a list (like duration)' do; end
    it 'has a name property that is a user-facing name for the filter' do; end
    it '' do; end
  end
  
  describe 'Filter.selected' do    
    it 'includes all currently selected filters' do; end
  end
  
  describe 'Filter.show_selected' do    
    it 'prints all currently selected filters' do; end
  end

end
