class Filter
  # TODO: Possibly hard-code the available filters. Since there are certainly more filters available to sort by than we will ever actually want to use.

  attr_accessor :name, :url, :all_terms, :selected_terms

  @@all_active = []
  
  def self.all_active
    @all_active
  end

  def self.all_active=(hash)
    @all_active = hash
  end

  def available_terms
    @all_terms.select { |term| !selected_terms.include?(term) }
  end

  def initialize(name)
    @name = name
    @all_terms = []
    @selected_terms = []
    @url = ""
  end

end