require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.yahoo.co.jp'))

title = doc.xpath('/html/head/title')
objects = doc.xpath('//a')

puts title
puts objects