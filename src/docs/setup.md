# 環境構築ガイド

## 必要条件

- Docker
- Docker Compose
- Git
- macOS (M1/M2)

## セットアップ手順

1. リポジトリのクローン

```bash
git clone https://github.com/jaganoer-works/laravel12-sandbox.git
cd laravel12-sandbox
```

2. 環境変数の設定

```bash
cp .env.example .env
```

3. Docker環境の起動

```bash
make up
```

4. 依存パッケージのインストールと初期設定

```bash
make init
```

## 開発用コマンド

| コマンド           | 説明                           |
| ------------------ | ------------------------------ |
| `make up`          | Docker環境を起動              |
| `make down`        | Docker環境を停止              |
| `make build`       | Dockerイメージをビルド        |
| `make restart`     | Docker環境を再起動            |
| `make ps`          | コンテナの状態確認            |
| `make logs`        | ログの確認                    |
| `make app`         | アプリケーションコンテナに接続 |
| `make db`          | データベースコンテナに接続     |
| `make test`        | テストの実行                  |
| `make lint`        | コードの静的解析              |
| `make format`      | コードのフォーマット          |

## アクセス情報

- Webアプリケーション: http://localhost:8080
- Mailpit Web UI: http://localhost:8025
- MySQL: localhost:3306
- Redis: localhost:6379

## トラブルシューティング

### よくある問題と解決方法

1. 権限エラー
```bash
docker-compose exec app chmod -R 777 storage bootstrap/cache
```

2. キャッシュの問題
```bash
make cache-clear
```

3. データベースの問題
```bash
make fresh
``` 