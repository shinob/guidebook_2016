# 企業支援施策ガイドブック2016年版検索サイトの構築

- Ruby 2.0
- Elasticsearch 2.4.1

## Elasticsearchのインストール

以下のサイトを参照。
http://qiita.com/mix_dvd/items/3ed9888499c2839d8c43

## gemのインストール

sudo gem install elasticsearch

## インデックスの作成

sh ./guidebook/create_index.sh

## データの生成

ruby insert_data.rb

## apacheの設定変更

sudo nano /etc/httpd/conf/httpd.conf

「httpd.conf」内にある以下の表記を「None」から「All」に変更する
AllowOverride None
　↓
AllowOverride All

## 実行

sudo service httpd restart
