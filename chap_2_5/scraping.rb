require 'anemone'
require 'nokogiri'
require 'kconv'

opt = {depth_limit: 1,
       skip_query_strings: true,
       delay: 1
}

# クロールの起点となるURLを指定
urls = ['http://www.amazon.co.jp/gp/bestsellers/books/']
Anemone.crawl(urls, opt) do |anemone|

  # 巡回先の絞り込み
  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(/\/gp\/bestsellers\/books/)
    }
  end

  anemone.on_every_page do |page|

    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text
    next if category == '' || category.nil?

    sub_category = doc.xpath("//*[@id='zg_listTitle']/span").text

    puts "--- #{category} - #{sub_category} ---"

    items = doc.xpath('//div[@class="zg_itemRow"]/div[1]/div[2]')
    items += doc.xpath('//div[@class="zg_itemRow"]/div[2]/div[2]')

    items.each do |item|
      rank_no = item.xpath("div[1]/span[1]").text.chop
      title = item.xpath('div["zg_title"]/a').text
      asin = item.xpath('div["zg_title"]/a').attribute("href").text.match(%r{dp/(.+?)/})[1]
      price = item.xpath('div["zg_itemPriceBlock_normal"]/p/span/b').text.gsub(/[¥,]/,'')
      p "price:#{price}"
      puts "#{rank_no}.#{title}[ASIN:#{asin}]"
    end
  end
end
