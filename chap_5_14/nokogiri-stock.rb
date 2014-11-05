require 'nokogiri'
require 'open-uri'
require 'parallel'

class CompanyInfo
  def initialize(ticker_code)
    @base_url = "http://stocks.finance.yahoo.co.jp/stocks"
    @ticker_code = ticker_code

    scrape
  end

  attr_reader :name, :ticker_code, :category, :unit, :recent_high_price, :recent_low_price, :high_price,
              :low_price, :price, :annual_settlements

  private
  def scrape_stok_info(html, index)
    get_content(html, "dd", "ymuiEditLink marO", index, "/strong").delete(",")
  end

  def get_company_info

    p 'exec get_company_info'

    url = "#{@base_url}/profile/?code=#{@ticker_code}"
    doc = get_nokogiri_doc(url)
    @name = doc.xpath("//th[@class='symbol']/h1").text
    @category = doc.xpath("//table[@class='boardFinCom marB6']/tr[6]/td").text
    @unit =     doc.xpath("//table[@class='boardFinCom marB6']/tr[13]/td").text

  end

  def get_stock_info

    url = "#{@base_url}/detail/?code=#{@ticker_code}"
    doc = get_nokogiri_doc(url)

    @recent_high_price = doc.xpath("//div[11]/dl/dd[@class='ymuiEditLink mar0']/strong").text
    @recent_low_price = doc.xpath("//div[12]/dl/dd[@class='ymuiEditLink mar0']/strong").text
    @high_price = doc.xpath("//div[@class='innerDate']/div[3]/dl/dd[@class='ymuiEditLink mar0']/strong").text
    @low_price = doc.xpath("//div[@class='innerDate']/div[4]/dl/dd[@class='ymuiEditLink mar0']/strong").text

    @price = doc.xpath("//td[@class='stoksPrice']").text
  end

  def get_nokogiri_doc(url)

    begin
      html = open(url)
    rescue OpenURI::HTTPError
      return
    end

    Nokogiri::HTML(html.read, nil, 'utf-8')
  end

  def scrape
    get_company_info
    get_stock_info
  end
end

company = CompanyInfo.new('1301')
puts company.name
puts company.ticker_code
puts company.category
puts company.unit
puts company.recent_high_price
puts company.recent_low_price
puts company.high_price
puts company.low_price
puts company.price

# target_ticker_codes = ['1301','1332','1333','1352','1377','1379','1414','1417','1419','1420','1514','1515','1518','1605','1606','1662']
#
# # target_ticker_codes.each do |target_ticker_code|
#
# Parallel.each(target_ticker_codes, in_threads: 10) do |target_ticker_code|
#   company = CompanyInfo.new(target_ticker_code)
#   puts company.name
#   puts company.ticker_code
#   puts company.category
#   puts company.unit
#   puts company.recent_high_price
#   puts company.recent_low_price
#   puts company.high_price
#   puts company.low_price
#   puts company.price
# end
# # end
#
