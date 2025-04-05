.PHONY: up down build restart ps logs clean app db cache-clear fresh init test lint format help install update redis tinker route-list queue-work storage-link ide-helper

# ヘルプの表示
help:
	@echo "利用可能なコマンド:"
	@echo "  make up              - Docker環境を起動"
	@echo "  make down            - Docker環境を停止"
	@echo "  make build           - Dockerイメージをビルド"
	@echo "  make restart         - Docker環境を再起動"
	@echo "  make ps              - コンテナの状態確認"
	@echo "  make logs            - ログの確認"
	@echo "  make clean           - コンテナとボリュームの削除"
	@echo "  make app             - アプリケーションコンテナへの接続"
	@echo "  make db              - データベースコンテナへの接続"
	@echo "  make redis           - Redisコンテナへの接続"
	@echo "  make cache-clear     - キャッシュのクリア"
	@echo "  make fresh           - DBマイグレーションのリフレッシュ"
	@echo "  make init            - 初期セットアップの実行"
	@echo "  make test            - テストの実行"
	@echo "  make lint            - コードの静的解析"
	@echo "  make format          - コードのフォーマット"
	@echo "  make install         - 依存パッケージのインストール"
	@echo "  make update          - 依存パッケージの更新"
	@echo "  make tinker          - Tinkerの起動"
	@echo "  make route-list      - ルート一覧の表示"
	@echo "  make queue-work      - キューワーカーの起動"
	@echo "  make storage-link    - ストレージリンクの作成"
	@echo "  make ide-helper      - IDE Helper生成"

# Docker環境の起動
up:
	docker-compose up -d

# Docker環境の停止
down:
	docker-compose down

# Dockerイメージのビルド
build:
	docker-compose build

# Docker環境の再起動
restart:
	docker-compose restart

# コンテナの状態確認
ps:
	docker-compose ps

# ログの確認
logs:
	docker-compose logs -f

# コンテナとボリュームの削除
clean:
	docker-compose down -v

# アプリケーションコンテナへの接続
app:
	docker-compose exec app bash

# データベースコンテナへの接続
db:
	docker-compose exec db bash

# Redisコンテナへの接続
redis:
	docker-compose exec redis redis-cli

# キャッシュのクリア
cache-clear:
	docker-compose exec app php artisan cache:clear
	docker-compose exec app php artisan config:clear
	docker-compose exec app php artisan route:clear
	docker-compose exec app php artisan view:clear

# テストデータのシード
fresh:
	docker-compose exec app php artisan migrate:fresh --seed

# 初期セットアップ
init:
	cp -n .env.example .env || true
	docker-compose up -d
	docker-compose exec app composer install
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	docker-compose exec app php artisan migrate
	docker-compose exec app chmod -R 777 storage bootstrap/cache

# テストの実行
test:
	docker-compose exec app php artisan test

# コードの静的解析
lint:
	docker-compose exec app ./vendor/bin/pint --test

# コードのフォーマット
format:
	docker-compose exec app ./vendor/bin/pint

# 依存パッケージのインストール
install:
	docker-compose exec app composer install

# 依存パッケージの更新
update:
	docker-compose exec app composer update

# Tinkerの起動
tinker:
	docker-compose exec app php artisan tinker

# ルート一覧の表示
route-list:
	docker-compose exec app php artisan route:list

# キューワーカーの起動
queue-work:
	docker-compose exec app php artisan queue:work

# ストレージリンクの作成
storage-link:
	docker-compose exec app php artisan storage:link

# IDE Helper生成
ide-helper:
	docker-compose exec app composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec app php artisan ide-helper:generate
	docker-compose exec app php artisan ide-helper:models -N
	docker-compose exec app php artisan ide-helper:meta