# Laravel 12 Sandbox Documentation

このドキュメントは、Laravel 12 Sandboxプロジェクトの技術仕様とAPIリファレンスを提供します。

## 目次

1. [環境構築](setup.md)
2. [アーキテクチャ](architecture.md)
3. [APIリファレンス](api.md)
4. [開発ガイドライン](guidelines.md)

## プロジェクト概要

Laravel 12を使用したサンドボックス環境です。以下の特徴があります：

- Docker環境による開発環境の統一
- GitHub Actionsによる自動テストとCI/CD
- APIドキュメントの自動生成
- コード品質管理ツールの導入

## 技術スタック

- PHP 8.2
- Laravel 12.x
- MySQL 8.0
- Redis
- Nginx
- Docker

## 開発環境

- メインアプリケーション: [http://localhost:8080](http://localhost:8080)
- メールサーバー（Mailpit）: [http://localhost:8025](http://localhost:8025)
- PHPMyAdmin: [http://localhost:8081](http://localhost:8081)
- Redis Commander: [http://localhost:8082](http://localhost:8082) 