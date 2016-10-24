#!/usr/bin/env ruby
 
require 'elasticsearch'
require 'json'

es = Elasticsearch::Client.new hosts: "localhost:9200"
puts es.info

esIndex = "guidebook"
esType = "description"

rows = File.readlines("data.csv").map {|l|
  row = l.chomp.split(',')
  row.map.with_index {|val, j|
    if val == "" then
      row[j] = " "
    end
    val
  }
  row
}

i = 0
rows.map {|row|
  row.map {|val|
    if val == "" then
      i += 1
    end
  }
}

puts i

rows.each do |row|
  es.index(index:esIndex, type:esType, body:{code:row[0], title:row[1], contact:row[2], subtitle:row[3], text:row[4]})
end

puts rows.length
