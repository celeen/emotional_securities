class WordFrequency
  include Mongoid::Document
  field :word, type: String
  field :klass, type: Integer
  field :expert, type: Integer
  field :spam, type: Integer
  # index :word 
end
