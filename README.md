# PHP Docker Template

PHP 開発用の Docker 環境テンプレートです。WSL Ubuntu 環境での使用を想定しています。

## 必要条件

- Docker
- Docker Compose
- WSL2 (Ubuntu)
- Git

## セットアップ手順

1. リポジトリのクローン

```bash
git clone [repository-url]
cd php-docker-template
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

## 環境情報

- PHP: [バージョン]
- MySQL: 8.0
- Redis: latest
- Nginx: 1.26-alpine
- Mailhog: latest

## アクセス情報

- Web アプリケーション: http://localhost:8080
- Mailhog Web UI: http://localhost:8025
- MySQL: localhost:3306
- Redis: localhost:6379

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

## 注意事項

- `.env`ファイルは Git にプッシュしないでください
- データベースのデータを保持したい場合は`make clean`は使用しないでください
- 開発中は`make logs`でログを確認しながら作業することを推奨します

## ライセンス

MIT License
