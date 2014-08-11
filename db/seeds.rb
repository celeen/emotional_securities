# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

class SPYParser
  attr_reader :file, :spy_array

  def initialize(file)
    @file = file
    @spy_array = CSV.read(@file,{ :headers => true, :header_converters => :symbol })
    @spy_array.each do |values|
      puts values.headers
      Company.create(name:values[:name], symbol: values[:symbol], sector: values[:sector])
    end
  end
end

SPYParser.new('lib/assets/SPYsymbols.csv')


3000.times do
	Tweet.create()
