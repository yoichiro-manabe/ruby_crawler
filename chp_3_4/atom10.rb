require 'nokogiri'
require 'open-uri'

url = 'http://b.hatena.ne.jp/dkfj/atomfeed'
xml = open(url).read

doc = Nokogiri::XML(xml)

namespaces = {
    "atom"=>'http://purl.org/atom/ns#',
    "dc"=>'http://purl.org/dc/elements/1.1/'
}

entries = doc.xpath('//atom:entry', namespaces)
entries.each do |entry|
  p entry.xpath('atom:title', namespaces).text
end