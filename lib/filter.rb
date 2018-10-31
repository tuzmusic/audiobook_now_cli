class Filter

  attr_accessor :name, :url, :all_terms, :selected_terms

  @@all_current = {}
  
  def self.all_current
    @all_current
  end

  def self.all_current=(hash)
    @all_current = hash
  end

  def initialize(name)
    @name = name
    @all_terms = []
    @selected_terms = []
    @url = ""
  end

end