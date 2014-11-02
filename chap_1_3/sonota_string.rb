# 書式文字列
format("%s %d URLs", "Download", 23)  # =>

# 改行を取り除く
"abc\n".chomp  # =>
"abc\n\n".chomp  # =>
"abc\n\n".chomp("")  # =>

# 文字の出現回数を数える
"abcd".count("a")  # =>
"abcd".count("ab")  # =>
"abcd".count("a-c")  # =>

# a～cのうちbを含まない文字(ac)を数える
"abcd".count("a-c", "^b")  # =>

# 行に分割する
s = "ab\ncd\n"
s.lines.to_a  # =>
s.lines.map(&:chomp)  # =>
s.split("\n") # =>

# 各行毎に繰り返す
a = []
s.each_line{|l| a << 1}
a  # =>

# 文字列を空白で分離
s = " ab cd ef "
s.split  # =>

# 分割数を2に制限する
s.split(nil, 2)  # =>

# 先頭と末尾の空白を取り除く
s.strip  # =>

# 文字に分割する
"abc".chars.to_a  # =>