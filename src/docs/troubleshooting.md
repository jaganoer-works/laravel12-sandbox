# トラブルシューティング

## 開発環境の問題

### Docker関連

1. **コンテナが起動しない**
   ```bash
   # ログの確認
   make logs
   
   # コンテナの再ビルド
   make build
   make up
   ```

2. **ポートの競合**
   ```bash
   # 使用中のポートの確認
   lsof -i :8080
   lsof -i :3306
   
   # docker-compose.ymlでポート番号を変更
   ```

3. **パーミッションエラー**
   ```bash
   # ストレージディレクトリの権限修正
   make app
   chmod -R 777 storage bootstrap/cache
   ```

### Laravel関連

1. **キャッシュの問題**
   ```bash
   # キャッシュのクリア
   make cache-clear
   
   # 設定のリロード
   make optimize
   ```

2. **マイグレーションエラー**
   ```bash
   # データベースのリフレッシュ
   make fresh
   
   # マイグレーションステータスの確認
   docker-compose exec app php artisan migrate:status
   ```

3. **Composerの依存関係**
   ```bash
   # Composerキャッシュのクリア
   docker-compose exec app composer clear-cache
   
   # 依存パッケージの更新
   make update
   ```

## アプリケーションの問題

### データベース接続

1. **接続エラー**
   - `.env`ファイルの設定確認
   - MySQLサービスの状態確認
   - ネットワーク設定の確認

2. **クエリパフォーマンス**
   - N+1問題の解決
   - インデックスの追加
   - クエリログの確認

### キャッシュ

1. **Redisエラー**
   ```bash
   # Redisの状態確認
   docker-compose exec redis redis-cli ping
   
   # キャッシュのフラッシュ
   docker-compose exec redis redis-cli flushall
   ```

2. **セッション問題**
   - セッションドライバーの確認
   - セッションの有効期限設定
   - セッションストレージの権限

### メール送信

1. **Mailpitの問題**
   - Mailpitコンテナの状態確認
   - SMTPポートの確認
   - メール設定の確認

2. **メールキュー**
   ```bash
   # キューワーカーの再起動
   docker-compose exec app php artisan queue:restart
   
   # 失敗したジョブの確認
   docker-compose exec app php artisan queue:failed
   ```

## デバッグ

### Xdebug

1. **接続できない**
   - Xdebug設定の確認
   - IDEの設定確認
   - ファイアウォール設定

2. **ブレークポイントが機能しない**
   - パスマッピングの確認
   - Xdebugモードの確認
   - IDEのデバッグ設定

### ログ

1. **ログの場所**
   ```
   storage/logs/laravel.log
   docker-compose logs
   ```

2. **ログレベルの設定**
   ```php
   // config/logging.php
   'level' => env('LOG_LEVEL', 'debug')
   ```

## CI/CD

### GitHub Actions

1. **ワークフローの失敗**
   - アクションログの確認
   - 環境変数の設定
   - 依存関係の確認

2. **テストの失敗**
   - テストデータベースの設定
   - テスト環境変数
   - テストカバレッジ

### デプロイメント

1. **ビルドエラー**
   - 依存パッケージの互換性
   - ビルドスクリプトの確認
   - 環境設定の確認

2. **デプロイ失敗**
   - サーバー権限
   - ストレージリンク
   - キャッシュクリア 