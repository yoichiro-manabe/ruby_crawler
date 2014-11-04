require 'csv'
require 'open-uri'

# 国債金利情報を取得する

urls = ["http://www.mof.go.jp/jgbs/reference/interest_rate/data/jgbcm_all.csv",
        "http://www.mof.go.jp/jgbs/reference/interest_rate/jgbcm.csv"]


urls.each do |url|

  csv_obj = CSV.new(open(url), {encoding: 'Shift_JIS', headers: :first_row})

  csv_obj.each do |row|
    puts "基準日：#{row[0]}"
    puts "1年：#{row[1]}"
    puts "2年：#{row[2]}"
    puts "3年：#{row[3]}"
    puts "4年：#{row[4]}"
    puts "5年：#{row[5]}"
    puts "6年：#{row[6]}"
    puts "7年：#{row[7]}"
    puts "8年：#{row[8]}"
    puts "9年：#{row[9]}"
    puts "10年：#{row[10]}"
    puts "15年：#{row[15]}"
    puts "20年：#{row[20]}"
    puts "25年：#{row[25]}"
    puts "30年：#{row[30]}"
    puts "40年：#{row[40]}"
  end
end

