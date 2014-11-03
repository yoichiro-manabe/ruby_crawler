require 'anemone'
require 'nokogiri'
require 'kconv'

sub_category_hash = {c466284: '文学・評論', c571582: '人文・思想', c571584: '社会・政治', c492152: 'ノンフィクション',
                     c466286: '歴史・地理', c466282: 'ビジネス・経済', c492054: '投資・金融・会社経営', c466290: '科学・テクノロジー',
                     c492166: '医学・薬学・看護学・歯科学', c466298: 'コンピュータ・IT', c466294: 'アート・建築・デザイン', c466292: '趣味・実用',
                     c2400471051: 'スポーツ・アウトドア', c492228: '資格・検定', c466304: '暮らし・健康・子育て', c492090: '旅行ガイド',
                     c466302: '語学・辞事典・年鑑', c3148931: '教育・学参・受験', c466306: '絵本・児童書', c2501045051: 'コミック・ラノベ・BL',
                     c500592: 'タレント写真集', c466296: 'エンターテイメント', c492266: 'ゲーム攻略・ゲームブック', c2189048051: '文庫',
                     c2189049051: '新書', c2189050051: 'ノベルス', c13384021: '雑誌', c746102: '楽譜・スコア・音楽書',
                     c886928: 'カレンダー', c13383771: 'ポスター', c10667101: 'アダルト', c2457910051: 'ライトアダルト'}

# クロールの起点となるURLを指定
urls = ['http://www.amazon.co.jp/gp/bestsellers/books/']
Anemone.crawl(urls, depth_limit: 2, skip_query_strings: true) do |anemone|

  # 巡回先の絞り込み
  anemone.focus_crawl do |page|
    # p "page:#{page}"
    page.links.keep_if { |link|
      # p "link:#{link}"
      link.to_s.match(/\/gp\/bestsellers\/books/)
    }
  end

  PATTERN = sub_category_hash.keys.map(&:to_s)

  anemone.on_every_page do |page|
    puts page.url
  end
end
