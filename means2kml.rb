#!/usr/bin/env ruby
#
# Remember to use the corrected outputs.
#

require 'nokogiri'

(indir, outdir) = ARGV

Dir.each_child(indir) do |fname|
    k = Integer(fname.split('.')[0])
    builder = Nokogiri::XML::Builder.new do |xml|
        xml.kml('xmlns' => 'http://www.opengis.net/kml/2.2') do
            xml.Document('id' => 'root_doc') do
                xml.Folder do
                    xml.name("#{k} mean#{k > 1 ? 's' : ''}")
                    File.foreach("#{indir}/#{fname}") do |line|
                        (lon,lat) = line.split(' ')
                        xml.Placemark do
                            xml.Point do
                                xml.coordinates("#{lon},#{lat}")
                            end
                        end
                    end
                end
            end
        end
    end
    File.open("#{outdir}/#{k}.kml", 'w') do |f|
        f.puts builder.to_xml
    end
end
