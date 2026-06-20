# ドキュメント索引

楽譜記号学習アプリ（musical-note-training）の企画・要件・タスクをまとめたドキュメント群です。

## このリポジトリについて

ピアノの楽譜に登場する**音符・休符・記号**などを、カテゴリー別に学び、単語帳のように反復練習できる Flutter アプリ。開発者自身も音楽理論を学びながら作ることを目的とする。

## ドキュメント一覧

| ファイル | 内容 |
|----------|------|
| [overview.md](./overview.md) | アプリ概要・コンセプト・技術スタック・収益モデル |
| [functional-requirements.md](./functional-requirements.md) | 機能要件（MVP / 将来機能） |
| [non-functional-requirements.md](./non-functional-requirements.md) | 非機能要件（性能・多言語・課金・広告など） |
| [roadmap.md](./roadmap.md) | フェーズ別ロードマップ（MVP → 将来） |
| [tasks.md](./tasks.md) | 開発タスク一覧（フェーズ・優先度付き） |
| [optional-features.md](./optional-features.md) | オプション機能のアイデア（フラッシュ・リズム練習など） |
| [architecture.md](./architecture.md) | ディレクトリ構成・アーキテクチャ（T-002） |
| [contributing.md](./contributing.md) | ブランチ・Issue・PR・コミット規約 |
| [github-setup.md](./github-setup.md) | ラベル・Milestone・Project 初期設定 |

## クイックリファレンス

### MVP（最初に作るもの）

- 音符・休符・記号・強弱記号・速度記号の学習
- 単語帳（カスタムデッキ・苦手管理）
- カテゴリー別の一通り学習

### 将来機能

- フラッシュカード（複数モード）
- リズム練習
- 和音・スケール・コード
- ユーザー作成カード（100〜500円の課金で開放）

### 技術

- **言語 / フレームワーク**: Flutter（Dart）
- **収益**: 基本無料 + 広告 + 一部機能の IAP

## 更新方針

要件やタスクは開発の進行に合わせて随時更新する。大きな方針変更は `overview.md` と `roadmap.md` を先に更新し、機能要件・タスクへ反映する。
