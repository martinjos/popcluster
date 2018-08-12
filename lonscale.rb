#!/usr/bin/env ruby

require 'csv'

scale = pfile = nil

while !ARGV.empty?
    begin
        scale = Float(ARGV[0])
    rescue
        pfile = ARGV[0]
    end
    ARGV.shift
end

pops = {}
if pfile
    CSV.foreach(pfile) do |row|
        pops[row[0]] = Integer(row[2])
    end
end

# multiply longitude by this value to convert England to roughly rectangular
# grid
LonFactor = scale ? scale : 0.6

STDIN.each_line do |line|
    vals = line.split(',')
    begin
        lon = Float(vals[1])
        lon *= LonFactor
        pop = pops[vals[0]] || 100
        1.upto((pop/100.0).round) do
            print "#{lon} #{vals[2]}"
        end
    rescue ArgumentError
        raise 'Column name incorrect' if vals[1] != 'lon'
        #print line
        next
    end
end
