require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.yahoo.co.jp'))

puts doc.class
puts doc.title
puts doc.encoding

puts doc.xpath('//title')