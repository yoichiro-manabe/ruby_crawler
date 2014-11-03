require 'cgi'

def parse(page_source)
  # note:日付は1桁の場合はスペース埋めされているため、正規表現としてスペースが必要
  dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)

  url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
  url_titles.zip(dates).map{|(aurl, atitle), ymd| [CGI.unescapeHTML(aurl), CGI.unescapeHTML(atitle), Time.local(*ymd)]}
end

def format_text(title, url, url_title_time_ary)
  s = "Title: #{title}\nURL: #{url}\n\n}"
  url_title_time_ary.each do |aurl, atitle, atime|
    s << "* (#{atime})#{atitle}\n"
    s << "     #{aurl}\n"
  end
  s
end

# x = parse(`/usr/bin/wget -q -O- http://crawler.sbcr.jp/samplepage.html`)
# x = parse(open("samplepage.html", &:read))
puts format_text "WWW.SBCR>JP トピックス", 'http://crawler.sbcr.jp/samplepage.html', parse(`/usr/bin/wget -q -O- http://crawler.sbcr.jp/samplepage.html`)