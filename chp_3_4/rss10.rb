require 'nokogiri'
require 'open-uri'

url = 'http://feeds.feedburner.com/hatena/b/hotentry'
xml = open(url).read

doc = Nokogiri::XML(xml)

namespaces = {
    'rss' => 'http://purl.org/rss/1.0/',
    'rdf' => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    'content' => 'http://purl.org/rss/1.0/modules/content/',
    'dc' => 'http://purl.org/dc/elements/1.1/',
    'feedburner' => 'http://rssnamespace.org/feedburner/ext/1.0'
}

channel = doc.xpath('//rss:channel', namespaces)

p channel.xpath('rss:title', namespaces)
p channel.xpath('feedburner:info', namespaces)
lis =  channel.xpath('//rdf:li', namespaces)

lis.each do |li|
  p li.attribute("resource")
end


# CSSセレクタでtitleを検索
doc.css('channel title')

items = doc.xpath('//rss:item', namespaces)
items.each do |item|
  p item.xpath('rss:title', namespaces).inner_text
  p item.xpath('content:encode', namespaces)
  p item.xpath('dc:date', namespaces).inner_text
end