# Aquarist
アクアリウムの写真投稿サイトです。  
自慢のアクアリウムをコメント付きで投稿できます。  
また、現在の位置情報や指定住所から周辺のアクアショップの検索が行えます。  
レスポンシブ対応なので、スマホやタブレットからもご覧になれます。  
<img width="1436" alt="スクリーンショット 2021-09-08 9 19 47" src="https://user-images.githubusercontent.com/74239438/132426050-dc1d4134-4ad8-4f32-b3ab-1e79ada292dc.png">
<br>
<br>

# なぜ作ったのか
「おうち時間」が増えるなかでアクアリウムのブームが広がりつつあります。  
しかし、アクアリウム専用の写真投稿サイトというのはあまり多くはありません。  
折角作り上げたアクアリウム、家の中で鑑賞するだけでは勿体ない！  
という思いからこのサイトを作りました。  

また投稿するだけではなく、アクアリストである自分自身の  
「ワンタッチで簡単にショップの検索が出来たら便利だな」  
という目線からショップ検索機能を実装しました。
<br>
<br>

# 使用技術

## フロントエンド
  * HTML/CSS/Scss/BootStrap
  * jQuery 3.6.0
  * Googl Maps API
<br>
<br>

## バックエンド
  * Ruby 2.6.6
  * Ruby on Rails 6.1.4
<br>
<br>

## データベース
  * MySQL 8.0.23
<br>
<br>

## テスト
  * RSpec  
    * model  
    * request  
    * system
<br>
<br>

## インフラ
  * Heroku
  * AWS S3
  * Docker/Docker-compose
  * CircleCI CI/CD
<br>
<br>

# インフラ構成図
<img width="787" alt="スクリーンショット 2021-10-06 13 19 55" src="https://user-images.githubusercontent.com/74239438/136140169-921c4377-58ce-40f1-9060-7d7bd713ed00.png">

* GitHubへのpush時にRSpec&Rubocopが自動で実行されます。
* masterへのpush時、RSpecとRubocopが成功した場合はHerokuへ自動デプロイされます。
<br>
<br>

# データベース設計

ER図

<img width="691" alt="スクリーンショット 2021-10-06 13 42 18" src="https://user-images.githubusercontent.com/74239438/136141837-b7a9d12d-a05a-44f0-8ff8-f7e0fa2f0e05.png">
<br>
<br>

# テーブル設計
  * users　　　 『ユーザー情報登録』
  * aquaria　　 『アクアリウム投稿』
  * likes　　　　『いいね機能』
  * comments  　『コメント投稿』
  * relationship   『フォロー、フォロワー機能』
<br>
<br>

# 機能一覧
* ユーザー登録、編集、ログイン機能(devise)
* 投稿機能
* いいね機能(Ajax)
* コメント機能(Ajax)
* フォロー、フォロワー機能(Ajax)
* 投稿検索機能(ransack)
* 画像アップロード機能(CarreirWave)
* ショップ検索機能(Google Maps API)  
  * 位置情報検索(geocorder,geolocation)  
  * ショップ情報検索(Place API)   
