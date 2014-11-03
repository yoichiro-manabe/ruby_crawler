page_source = open("samplepage.html", &:read)
# note:日付は1桁の場合はスペース埋めされているため、正規表現としてスペースが必要
dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)
dates # =>

url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
url_titles  # =>

dates.length  # =>
url_titles.size  # =>

dates.zip(url_titles)  # =>