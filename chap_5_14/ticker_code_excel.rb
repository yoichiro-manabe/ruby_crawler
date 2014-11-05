require 'nokogiri'
require 'open-uri'
require 'fileutils'
require "tmpdir"

BASE_URL = 'http://www.tse.or.jp/market/data/listed_companies/b7gje60000023aiz-att/'

@ticker_code_list = {
    '市場第一部 （内国株）' => 'b7gje6000003l9u4.xls',
    '市場第一部 （外国株）' => 'b7gje60000023aym.xls',
    '市場第二部' => 'b7gje60000023aza.xls',
    'マザーズ （内国株）' => 'b7gje60000023azg.xls',
    'マザーズ （外国株）' => 'b7gje60000023azm.xls',
    'REIT・ベンチャーファンド・カントリーファンド' => 'b7gje60000023b04.xls',
    'ETF・ETN' => 'b7gje60000023azy.xls',
    'PRO Market' => 'b7gje60000023azq.xls',
    'JASDAQ(グロース）' => 'b7gje6000002t00f.xls',
    'JASDAQ（スタンダード）' => 'b7gje6000003uzjd.xls',
    'JASDAQ（スタンダード・外国株）' => 'b7gje6000003v04x.xls',
}

tmp_dir = Dir.mktmpdir('ticker_')

@ticker_code_list.each do |key, value|

  save_file_name = "#{tmp_dir}/#{value}"

  p save_file_name

  open(save_file_name, 'wb') do |output|
    open("#{BASE_URL}#{value}") do |data|
      output.write(data.read)
    end
  end
end
