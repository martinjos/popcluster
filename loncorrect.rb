#!/usr/bin/env ruby

# divide grid longitude by this value to convert back to true longitude
LonFactor = 0.6

STDIN.each_line do |line|
    vals = line.split(' ')
    puts "#{Float(vals[0])/LonFactor} #{vals[1]}"
end
