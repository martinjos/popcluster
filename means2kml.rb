#!/usr/bin/env ruby
#
# Remember to use the corrected outputs, and a version of the kmeans input data
# file with true lon/lat coordinates.
#
# indir - directory containing corrected kmeans output
# outdir - output directory to write kml files to
# assigndir - directory containing kmeans assignments
# datafile - kmeans input file with output area coordinates in true lon/lat
#

require 'nokogiri'
require 'set'

(indir, outdir, assigndir, datafile) = ARGV

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
                    (1..k).each do |i|
                        lnos = Set.new
                        File.foreach("#{assigndir}/#{fname}").each_with_index do |line, lno|
                            j = line.to_i
                            lnos << lno if i == j
                        end
                        points = []
                        File.foreach(datafile).each_with_index do |line, lno|
                            next if !lnos.member?(lno)
                            points << line
                        end
                        open('|qhull Fx', 'w+') do |sp|
                            sp.puts '2'
                            sp.puts points.size
                            points.each do |point|
                                sp.puts point
                            end
                            sp.close_write
                            count = Integer(sp.readline)
                            first = nil
                            xml.Placemark do
                                xml.LineString do
                                    xml.coordinates do
                                        xml.text("\n")
                                        sp.each_line do |line|
                                            num = Integer(line)
                                            first = num if first.nil?
                                            xml.text(points[num].split(' ').join(',')+"\n")
                                        end
                                        xml.text(points[first].split(' ').join(',')+"\n")
                                    end
                                end
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
