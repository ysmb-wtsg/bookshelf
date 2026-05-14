# Book Logger - 開発ガイド

## プロジェクト概要

読書記録を管理するRailsアプリケーション（Ruby 3.3 / Rails 7.x / PostgreSQL）。

## コマンド

```bash
# 依存関係インストール
bundle install

# DB作成・マイグレーション
bin/rails db:create && bin/rails db:migrate

# サーバー起動
bin/rails server

# テスト実行
bundle exec rspec

# 単一ファイルのテスト実行
bundle exec rspec spec/path/to/file_spec.rb

# Lint
bundle exec rubocop

# Lint自動修正
bundle exec rubocop -A
```

## 開発ルール

### ブランチ・PR
- ブランチ命名: `feature/{issue番号}-{kebab-case-desc}` (例: `feature/7-review-model`)
- mainへの直接push禁止。必ずPR経由でマージ
- PRは1 Issueに対応させる

### コミットメッセージ
Conventional Commits準拠。prefix: `feat:`, `fix:`, `refactor:`, `test:`, `chore:`, `docs:`

### コードスタイル
- Rubocop (rubocop-rails, rubocop-rspec) に従う
- テストはRSpec + FactoryBot
- N+1はBulletで検知。`includes`等で解消すること

### 技術的要件（PR前チェック）
- RSpec (system spec or request spec) が書かれている
- `bundle exec rubocop` が通っている
- N+1が発生していない
- バリデーションエラー表示等のUXを考慮している
