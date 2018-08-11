#!/usr/bin/env ruby

# multiply longitude by this value to convert England to roughly rectangular
# grid
LonFactor = 0.6

STDIN.each_line do |line|
    vals = line.split(',')
    begin
        lon = Float(vals[1])
        #print "#{vals[0]},#{lon * LonFactor},#{vals[2]}"
        print "#{lon * LonFactor} #{vals[2]}"
    rescue ArgumentError
        raise 'Column name incorrect' if vals[1] != 'lon'
        #print line
        next
    end
end
