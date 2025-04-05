.PHONY: up down build restart ps logs clean app db cache-clear fresh init test lint format help install update routes optimize ide-helper

# ヘルプの表示
help:
	@echo "利用可能なコマンド:"
	@echo "  make up           - Docker環境を起動"
	@echo "  make down         - Docker環境を停止"
	@echo "  make build        - Dockerイメージをビルド"
	@echo "  make restart      - Docker環境を再起動"
	@echo "  make ps           - コンテナの状態確認"
	@echo "  make logs         - ログの確認"
	@echo "  make clean        - コンテナとボリュームの削除"
	@echo "  make app          - アプリケーションコンテナへの接続"
	@echo "  make db           - データベースコンテナへの接続"
	@echo "  make cache-clear  - キャッシュのクリア"
	@echo "  make fresh        - DBマイグレーションのリフレッシュ"
	@echo "  make init         - プロジェクトの初期化"
	@echo "  make test         - テストの実行"
	@echo "  make lint         - コードの静的解析"
	@echo "  make format       - コードのフォーマット"
	@echo "  make routes       - ルート一覧の表示"
	@echo "  make optimize     - アプリケーションの最適化"
	@echo "  make update       - 依存パッケージの更新"
	@echo "  make ide-helper   - IDE Helper filesの生成"

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

# キャッシュのクリア
cache-clear:
	docker-compose exec app php artisan cache:clear
	docker-compose exec app php artisan config:clear
	docker-compose exec app php artisan route:clear
	docker-compose exec app php artisan view:clear
	docker-compose exec app php artisan event:clear

# テストデータのシード
fresh:
	docker-compose exec app php artisan migrate:fresh --seed

# プロジェクトの初期化
init:
	docker-compose exec app composer install
	docker-compose exec app cp .env.example .env
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	docker-compose exec app chmod -R 777 storage bootstrap/cache
	docker-compose exec app php artisan migrate:fresh --seed

# テストの実行
test:
	docker-compose exec app php artisan test

# コードの静的解析
lint:
	docker-compose exec app ./vendor/bin/pint --test
	docker-compose exec app php artisan about

# コードのフォーマット
format:
	docker-compose exec app ./vendor/bin/pint

# ルート一覧の表示
routes:
	docker-compose exec app php artisan route:list

# アプリケーションの最適化
optimize:
	docker-compose exec app php artisan optimize:clear
	docker-compose exec app php artisan optimize
	docker-compose exec app php artisan event:cache
	docker-compose exec app php artisan view:cache
	docker-compose exec app php artisan config:cache
	docker-compose exec app php artisan route:cache

# 依存パッケージの更新
update:
	docker-compose exec app composer update

# IDE Helper filesの生成
ide-helper:
	docker-compose exec app composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec app php artisan ide-helper:generate
	docker-compose exec app php artisan ide-helper:meta
	docker-compose exec app php artisan ide-helper:models --nowrite