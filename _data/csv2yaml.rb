require 'csv'
require 'yaml'
 
array = []
i = 0
CSV.foreach 'sample.csv' do |l|
  hash = {}
  hash['url'] = l[2]
  hash['date'] = l[1]
  hash["mention_#{i}"] = ''
  i += 1
  array << hash
end
 
puts array.to_yaml