# 開発ルール（Contributing）

個人開発でも、ブランチ・Issue・PR の型を揃えておくと後から迷いません。

## ブランチ戦略

```text
main      … 本番リリース（ストア出荷タグと対応）
develop   … 次リリースの統合先
issue/#N  … 作業ブランチ（1 Issue = 1 ブランチを基本）
```

| ブランチ | 用途 | マージ先 |
|----------|------|----------|
| `main` | リリース済みコード | — |
| `develop` | 日々の統合 | `main`（リリース時） |
| `issue/12` | Issue #12 の実装 | `develop` |

### 命名

- 機能・タスク: `issue/<番号>`（例: `issue/3`）
- 緊急修正（本番）: `hotfix/<短い説明>` → `main` と `develop` 両方へ

### フロー

1. **GitHub で Issue を作成する**（`gh issue create` または Web UI）。番号 **#N** を確定してからブランチを切る
2. `develop` を最新にする（`git pull origin develop`）
3. `develop` から **`issue/#N` を切る**（`N` は手順 1 の Issue 番号と一致させる）
4. 実装 → `dart analyze` / `flutter test` を通す
5. **`origin` へ `issue/#N` を push**（`develop` にはまだマージしない）
6. **feature ブランチ上で動作確認**（`flutter run` 等）。微調整は同ブランチでコミット・push を繰り返す
7. 問題なさそうなら `issue/#N` を **`develop` にマージ**（ローカル fast-forward マージ可）→ `origin/develop` を push
8. マージ後、Issue を close・作業ブランチを削除（任意）

**禁止**: GitHub Issue なしで `issue/N` ブランチだけ作って実装を進めない。ローカルブランチ番号と GitHub `#N` は必ず対応させる。

**マージ先の承認ルール**

| マージ | 承認 | 備考 |
|--------|------|------|
| `issue/#N` → `develop` | **動作確認後**（ユーザー判断） | テスト通過だけではマージしない。エージェントは明示指示なしでマージしない |
| `develop` → `main` | **必須**（PR レビュー） | ストア出荷・タグ付けの最終関門 |

複数 Issue を連続で進めるときは、**依存順に `develop` へ統合してから**次の `issue/#N` を切る。  
未マージの作業を `stash` で持ち越すとコンフリクトしやすいので、Issue 単位でコミットし、**確認後に** `develop` へマージする。

リリース時は `develop` → `main` の PR を作成し、マージ後に `v1.0.0` 等のタグを付ける。

## Issue の書き方

| 種類 | テンプレート | 例 |
|------|--------------|-----|
| 開発タスク | Task | T-003 Riverpod 導入 |
| 不具合 | Bug report | 学習画面でクラッシュ |
| 機能追加 | Feature request | フラッシュカード UI |

**タスク ID**（`T-003` など）は Issue タイトルまたは本文に書く。`docs/tasks.md` と対応づける。

**本文はタイトルだけにしない。** 後から見返せるよう、最低限次を書く（[AGENTS.md](../AGENTS.md) §3・§4）。

| セクション | 内容 |
|------------|------|
| 背景 | なぜ今やるか |
| 問題 | 現象・困りごと（事実ベース） |
| 受け入れ条件 | 何をもって完了とするか（チェックリスト） |

Bug report / Task テンプレートの項目を埋めれば足りる。詳細は [AGENTS.md](../AGENTS.md) §3・§4。

### ラベル（推奨）

Issue / PR に付ける。一覧は [github-setup.md](./github-setup.md)。

- `type:*` … 種別（task, bug, feature, docs, chore）
- `priority:*` … P0 / P1 / P2（tasks.md と同じ）
- `phase:*` … phase-0 〜 phase-4、または `v1.0` など
- `area:*` … catalog, study, notation など feature 単位
- `status:*` … 任意（blocked 等）

## コミットメッセージ

[Conventional Commits](https://www.conventionalcommits.org/) を推奨:

```text
feat(study): add answer feedback animation
fix(notation): align staff lines on tablet
docs: add contributing guide
chore(ci): run flutter test on PR
```

- 1 コミット = 1 論点（レビューしやすい粒度）
- Issue 番号を末尾に付けてもよい: `feat(router): wire go_router (issue/3) #3`
- 日本語本文でもよい（例: `feat(study): 学習縦スライス (issue/3) #3`）

## PR チェックリスト

- [ ] `flutter analyze` エラーなし
- [ ] `flutter test` 通過
- [ ] 該当タスク ID / Issue 番号を記載
- [ ] UI 変更時はスクリーンショット（任意）
- [ ] `docs/` やアーキテクチャに影響があれば更新

## コード構成

[architecture.md](./architecture.md) に従う。

```text
features → shared → core   （逆方向 import 禁止）
```

- 画面: `features/<name>/presentation/pages/`
- 状態: `features/<name>/presentation/view_models/`（Riverpod Notifier）
- 共通モデル: `shared/domain/models/`
- ルーター・DI: `app/router/`, `app/di/` のみ

## ローカル検証

```bash
flutter pub get
dart analyze
flutter test
flutter run
```

完了前は `dart analyze` と `flutter test` を必ず通す。設計・テスト方針は [AGENTS.md](../AGENTS.md) §7・§8 を参照。

## パッケージ導入ログ

パッケージやライブラリを追加したときは、**実行したコマンド**をここに追記する（再現性のため）。

| 日付 | タスク | コマンド | 目的 |
|------|--------|----------|------|
| 2026-07-08 | T-004 | `flutter pub add drift drift_flutter sqlite3_flutter_libs path_provider path` | ローカル DB（drift + SQLite） |
| 2026-07-08 | T-004 | `flutter pub add dev:drift_dev dev:build_runner` | drift のコード生成 |
| 2026-07-08 | T-004 | `dart run build_runner build` | `app_database.g.dart` 生成 |
| 2026-07-09 | T-014 | `flutter pub add flutter_localizations --sdk=flutter` | UI 多言語（ARB） |
| 2026-07-09 | T-014 | `flutter pub add intl shared_preferences` | 日付フォーマット・設定永続化 |

### コード生成（drift スキーマ変更時）

```bash
dart run build_runner build
```

`lib/shared/data/database/app_database.dart` のテーブル定義を変えたら上記を実行する。

## 関連

- [github-setup.md](./github-setup.md) — ラベル・Milestone・Project 初期設定
- [tasks.md](./tasks.md) — タスク一覧
- [architecture.md](./architecture.md) — ディレクトリ構成