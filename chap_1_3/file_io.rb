TMP = "/tmp/test.txt"

open(TMP, "w"){|f| f.puts "あいうえお".encode("Shift_JIS")}

# 読み込みエンコードがマッチしていない
File.read(TMP)  # =>

unmatchd = open(TMP, &:read)  # =>

unmatchd.encoding  # =>

# エンコーディングを変換する必要がある
unmatchd.force_encoding("Shift_JIS").encode!("UTF-8")  # =>

unmatchd  # =>

# 入力ファイルのエンコーディングを指定する
sjis = open(TMP, "r:Shift_JIS", &:read)  # =>

sjis.encoding  # =>
sjis.encode("UTF-8")  # =>

# 内部エンコーディングを指定すれば open の段階で UTF-8 になる
utf8 = open(TMP, "r:Shift_JIS:UTF-8", &:read)  # =>

utf8.encoding  # =>

# エンコーディングを推測して変換する
require 'kconv'
File.read(TMP).toutf8  # =>
NKF.nkf("-wmO", File.read(TMP))  # =>
File.unlink TMP
