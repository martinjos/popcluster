#!/usr/bin/env ruby

require 'nokogiri'

kfile = ARGV[0]
kml = File.open(kfile) { |f| Nokogiri::XML(f) }
kml.remove_namespaces!

puts "name,lon,lat"
kml.css('Placemark').each do |pm|
    name = pm.at_xpath(".//SimpleData[@name='oa11cd'][1]/text()[1]").to_s
    coords = pm.at_xpath(".//coordinates[1]/text()[1]").to_s
    next if name[0] != 'E'  # Remove Wales
    puts "#{name},#{coords}"
end
