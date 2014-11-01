target = "abc123"

# 正規表現にマッチした位置を取得する
target =~ /\d+/ # =>
target =~ /xyz/ # =>

# 正規表現にマッチした文字列を取得する
target[/\d+/] #=>
target[/xyz/] #=>
target[/abc/] #=>

# 最初にカッコにマッチした文字列を取得する
target[/^[a-z]+(\d+)/, 1] #=>
target[/^[a-c]+(\d)/, 1] #=>
target[/(abc)+(\d+)/, 1] #=>

# 最長マッチ VS 最短マッチ

# 最短マッチ
target[/(.?).+/, 1] #=>

# 最短マッチ
target[/(.??).+/, 1] #=>

# 最長マッチ
target[/(.+).+/, 1] #=>

# 最短マッチ
target[/(.+?).+/, 1] #=>

# シンプルな正規表現置換
target.sub(/abc/, 'def') #=>

# マッチした部分を評価して置換
target.sub(/[a-z]+/){|s| s.upcase} # =>

# ハッシュで置換パターンを設定
target.gsub(/[a-z]/, 'a' => 'x', 'b'=>'y', 'c'=> 'z') #=>

# HTMLからリンクを抽出する
html = '<a href="http://blog.beaglesoft.net/?p=688">Capistranoを利用するファーストステップ</a><a href="http://blog.beaglesoft.net/?p=680">RSpecのexampleの情報を取得する</a>'

# 正しくない例
html[%r!<a href="(.+)">(.+)</a>!, 1] # =>

# 正しい例
html[%r!<a href="(.+?)">(.+?)</a>!, 1] # =>
