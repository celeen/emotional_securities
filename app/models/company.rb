class Company
  include Mongoid::Document
  field :symbol, type: String
  field :name, type: String
  field :sector, type: String
  embeds_many :quotes
  embeds_many :tweets
  validates_presence_of :symbol
  validates_uniqueness_of :symbol

  def self.get_400_symbols
    self.all.to_a.map!{|e| e.symbol}.take(400)
  end
end
