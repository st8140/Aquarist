# Aquarist
アクアリウムの写真投稿サイトです。  
自慢のアクアリウムをコメント付きで投稿できます。  
また、現在の位置情報や指定住所から周辺のアクアショップの検索が行えます。  
レスポンシブ対応なので、スマホやタブレットからもご覧になれます。  
<img width="1436" alt="スクリーンショット 2021-09-08 9 19 47" src="https://user-images.githubusercontent.com/74239438/132426050-dc1d4134-4ad8-4f32-b3ab-1e79ada292dc.png">

  
# 使用技術
* Ruby 2.6.6
* Ruby on Rails 6.1.4
* MySQL 8.0.23
* PUMA
* AWS S3
* Docker/Docker-compose
* CircleCI CI/CD
* RSpec
* Googl Maps API

# インフラ構成図
<img width="799" alt="スクリーンショット 2021-09-08 10 12 10" src="https://user-images.githubusercontent.com/74239438/132429896-c1c0aee1-a4ad-4134-8fc8-37140f10ed5f.png">

* GitHubへのpush時にRSpec&Rubocopが自動で実行されます。
* RSpecとRubocopが成功した場合、Herokuへ自動デプロイされます。


# 機能一覧
* ユーザー登録、ログイン機能(devise)
* 投稿機能
* いいね機能(Ajax)
* コメント機能(Ajax)
* 投稿検索機能(ransack)
* ショップ検索機能(Google Maps API)  
  1.位置情報検索(geocorder,geolocation)  
  2.ショップ情報検索(Place API)  
  
# テスト
* Rspec  
  1.model  
  2.request  
  3.feature  
