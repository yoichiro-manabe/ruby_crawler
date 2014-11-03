require 'nokogiri'
require 'open-uri'

url = 'http://www.amazon.co.jp/gp/rss/new-releases/books/ref=zg_bsnr_books_rsslink'

xml = open(url).read

doc = Nokogiri::XML(xml)

items = doc.xpath('//rss/channel/item')
items.each do |item|
  p item.xpath('title').text
end
