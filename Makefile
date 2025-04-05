.PHONY: up down build restart ps logs clean

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

# テストデータのシード
fresh:
	docker-compose exec app php artisan migrate:fresh --seed