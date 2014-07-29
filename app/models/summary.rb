class Summary
  include Mongoid::Document
  field :klass, type: Integer
  field :expert, type: Integer
  field :spam, type: Integer
  # index :klass
end
