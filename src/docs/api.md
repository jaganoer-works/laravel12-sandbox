# API仕様書

## 概要

このAPIは、Laravel 12を使用して実装されたRESTful APIです。認証にはSanctuarを使用し、JSONレスポンスを返します。

## 認証

### ログイン

```http
POST /api/login
```

**リクエスト**
```json
{
    "email": "user@example.com",
    "password": "password"
}
```

**レスポンス**
```json
{
    "token": "2|JKdj8a9f8j3k..."
}
```

### ログアウト

```http
POST /api/logout
```

**ヘッダー**
```
Authorization: Bearer {token}
```

## ユーザー管理

### ユーザー一覧取得

```http
GET /api/users
```

**クエリパラメータ**
- `page`: ページ番号（デフォルト: 1）
- `per_page`: 1ページあたりの件数（デフォルト: 10）

**レスポンス**
```json
{
    "data": [
        {
            "id": 1,
            "name": "John Doe",
            "email": "john@example.com",
            "created_at": "2024-03-20T12:00:00Z"
        }
    ],
    "meta": {
        "current_page": 1,
        "total": 50,
        "per_page": 10
    }
}
```

### ユーザー詳細取得

```http
GET /api/users/{id}
```

**レスポンス**
```json
{
    "data": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": "2024-03-20T12:00:00Z",
        "updated_at": "2024-03-20T12:00:00Z"
    }
}
```

### ユーザー作成

```http
POST /api/users
```

**リクエスト**
```json
{
    "name": "Jane Doe",
    "email": "jane@example.com",
    "password": "password",
    "password_confirmation": "password"
}
```

**レスポンス**
```json
{
    "data": {
        "id": 2,
        "name": "Jane Doe",
        "email": "jane@example.com",
        "created_at": "2024-03-20T12:00:00Z"
    }
}
```

## エラーレスポンス

### バリデーションエラー (422)

```json
{
    "message": "The given data was invalid.",
    "errors": {
        "email": [
            "The email field is required."
        ]
    }
}
```

### 認証エラー (401)

```json
{
    "message": "Unauthenticated."
}
```

### 権限エラー (403)

```json
{
    "message": "This action is unauthorized."
}
```

### リソース未検出 (404)

```json
{
    "message": "Resource not found."
}
```

## レート制限

APIには以下のレート制限が設定されています：

- 認証済みユーザー: 60リクエスト/分
- 未認証ユーザー: 30リクエスト/分

制限を超えた場合は429ステータスコードが返されます。

## バージョニング

APIのバージョンはURLに含まれます：

```
/api/v1/users
```

現在サポートされているバージョン：
- v1 (現行バージョン) 