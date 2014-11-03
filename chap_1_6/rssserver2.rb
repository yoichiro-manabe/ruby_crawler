require 'cgi'
require 'open-uri'
require 'rss'
require 'kconv'

class Site
  def initialize(url: "", title: "")
    @url = url
    @title = title
  end

  attr_reader :url, :title

  def page_source
    @page_source ||= open(@url, &:read).toutf8
  end

  def output(formatter_klass)
    formatter_klass.new(self).format(parse)
  end

end

class SbcrTopics < Site
  def parse
    # note:日付は1桁の場合はスペース埋めされているため、正規表現としてスペースが必要
    dates = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)

    url_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)
    url_titles.zip(dates).map { |(aurl, atitle), ymd| [CGI.unescapeHTML(aurl), CGI.unescapeHTML(atitle), Time.local(*ymd)] }
  end
end

class Formatter
  def initialize(site)
    @url = site.url
    @title = site.title
  end

  attr_reader :url, :title
end

class TextFormatter < Formatter
  def format(url_title_time_ary)
    s = "Title: #{title}\nURL: #{url}\n\n}"
    url_title_time_ary.each do |aurl, atitle, atime|
      s << "* (#{atime})#{atitle}\n"
      s << "     #{aurl}\n"
    end
    s
  end
end

class RssFormatter < Formatter
  def format(url_title_time_ary)
    RSS::Maker.make("2.0") do |maker|
      maker.channel.updated = Time.now.to_s
      maker.channel.link = url
      maker.channel.title = title
      maker.channel.description = title
      url_title_time_ary.each do |aurl, atitle, atime|
        maker.items.new_item do |item|
          item.link = aurl
          item.title = atitle
          item.updated = atime
          item.description = atitle
        end
      end
    end
  end
end


site = SbcrTopics.new(url: 'http://crawler.sbcr.jp/samplepage.html',
                      title: 'WWW.SBCR>JP トピックス')

case ARGV.first
  when "rss-output"
    puts site.output RssFormatter
  when "text-output"
    puts site.output TextFormatter
end