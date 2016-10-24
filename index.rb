#!/usr/bin/ruby
# encoding: utf-8

require 'cgi'
require 'json'

load './guidebook.rb'

$cgi = CGI.new()

params = {}
params["word"] = ""

$cgi.params.each {|key, val|
  params[key] = val
}

puts <<EOF
Content-type: text/html

<html>
<head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>GUIDEBOOK</title>
  <style>
* {
	margin: 0px;
	padding: 0px;
	font-size: 11pt;
}
@media screen and (min-width: 800px) {
   /* 表示領域が800px以上の場合に適用するスタイル */
   body {
	margin: 0px auto;
	width: 800px;
   }
}
@media screen and (max-width: 799px) {
   /* 表示領域が800px未満の場合に適用するスタイル */
   body {
        margin: 0px auto;
	width: 90%;
   }
}
input {
	margin: 5px 0px;
}
.title {
	font-size: 24pt;
	padding: 20px 10px;
}
.menu {
	border-bottom: 1px solid #000;
}
.word {
	font-size: 18pt;
	padding: 5px;
}
.ans {
	border: 1px solid #F00;
	margin: 10px 0px;
	padding: 10px;
	
    border-radius: 10px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
}
  </style>
</head>
<body>
  <div class="title">企業支援施策（2016年版）検索</div>
  <div>下のボックスに質問を入力して送信してください。</div>
  <form method="post" class="menu">
    <input type="text" name="word" class="word" /><br />
    <input type="submit" name="submit" value="送信" />
  </form>
EOF

text = ""

if params["word"] != "" then
  gb = GuideBook.new()
  text = gb.find(params["word"])
end

if text != "" then
  puts "<div class='ans'>" + text + "</div>"
end
  
puts <<EOF
</body>
</html>
EOF

