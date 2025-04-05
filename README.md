# Laravel 12 Docker Environment

Laravel 12 開発用の Docker 環境です。M1/M2 Mac環境での使用を想定しています。

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

`.env`ファイルを編集し、必要な値を設定してください。

3. Docker 環境の起動

```bash
make up
```

4. コンテナの状態確認

```bash
make ps
```

## 利用可能なコマンド

| コマンド           | 説明                           |
| ------------------ | ------------------------------ |
| `make up`          | Docker 環境を起動              |
| `make down`        | Docker 環境を停止              |
| `make build`       | Docker イメージをビルド        |
| `make restart`     | Docker 環境を再起動            |
| `make ps`          | コンテナの状態確認             |
| `make logs`        | ログの確認                     |
| `make clean`       | コンテナとボリュームの削除     |
| `make app`         | アプリケーションコンテナに接続 |
| `make db`          | データベースコンテナに接続     |
| `make cache-clear` | キャッシュのクリア             |
| `make fresh`       | DBマイグレーションのリフレッシュ |

## 環境情報

- PHP: 8.2
- Laravel: 12.x
- MySQL: 8.0
- Redis: latest
- Nginx: 1.26-alpine
- Mailpit: latest (Mailhogの後継)
- Xdebug: 3.x

## アクセス情報

- Web アプリケーション: http://localhost:8080
- Mailpit Web UI: http://localhost:8025
- MySQL: localhost:3306
- Redis: localhost:6379

## 開発環境の特徴

1. Apple Silicon (M1/M2) 対応
   - `platform: linux/arm64/v8` の設定により、ネイティブ実行が可能

2. 開発支援ツール
   - Xdebugによるデバッグ機能
   - Mailpitによるメール送信テスト
   - Redisによるキャッシュ管理

3. データベース
   - MySQL 8.0を採用
   - 初期設定済みで即座に利用可能

## トラブルシューティング

### よくある問題と解決方法

1. 環境が起動しない場合

```bash
make clean
make build
make up
```

2. キャッシュ関連の問題

```bash
make cache-clear
```

3. データベース接続エラー

```bash
make db
```

4. ストレージ権限の問題

```bash
docker-compose exec app chmod -R 777 storage bootstrap/cache
```

## 注意事項

- `.env`ファイルは Git にプッシュしないでください
- データベースのデータを保持したい場合は`make clean`は使用しないでください
- 開発中は`make logs`でログを確認しながら作業することを推奨します
- 本番環境では適切なセキュリティ設定を行ってください

## ライセンス

MIT License
