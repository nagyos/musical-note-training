# GitHub 初期設定ガイド

リポジトリ: `nagyos/musical-note-training`

`gh` CLI が使える環境では末尾のコマンド例を実行してください。Web UI でも同じ内容を設定できます。

---

## 1. ブランチ保護（推奨）

| ブランチ | 設定 |
|----------|------|
| `main` | PR 必須、直接 push 禁止、ステータスチェック（CI 導入後） |
| `develop` | PR 推奨（ソロ開発中は緩めでも可） |

---

## 2. ラベル

### 種別 `type:`

| ラベル | 色 | 用途 |
|--------|-----|------|
| `type:task` | `#1D76DB` | 開発タスク（T-xxx） |
| `type:bug` | `#D73A4A` | 不具合 |
| `type:feature` | `#0E8A16` | ユーザー向け機能 |
| `type:docs` | `#0075CA` | ドキュメントのみ |
| `type:chore` | `#FBCA04` | 依存更新・設定・CI |

### 優先度 `priority:`

| ラベル | 色 |
|--------|-----|
| `priority:P0` | `#B60205` |
| `priority:P1` | `#D93F0B` |
| `priority:P2` | `#FEF2C0` |

### フェーズ / バージョン `phase:`

| ラベル | 用途 |
|--------|------|
| `phase:0` | 準備・設計 |
| `phase:1` | MVP / v1.0 |
| `phase:2` | 体験向上 / v1.1–v1.2 |
| `phase:3` | 収益化 / v2.0 |
| `phase:4` | 拡張 |

出荷バージョンだけ切りたい場合は `release:v1.0` などを追加してもよい。

### 領域 `area:`

| ラベル | 対応 feature / shared |
|--------|----------------------|
| `area:app` | `lib/app/`（ルーター・DI） |
| `area:notation` | `shared/widgets/notation/` |
| `area:catalog` | catalog |
| `area:study` | study |
| `area:deck` | deck |
| `area:weak-items` | weak_items |
| `area:settings` | settings |
| `area:flash` | flash |
| `area:rhythm` | rhythm |
| `area:custom-card` | custom_card |
| `area:infra` | CI, lint, ビルド |

### 状態 `status:`（任意）

| ラベル | 用途 |
|--------|------|
| `status:blocked` | 依存タスク待ち |
| `status:needs-design` | 設計・仕様未確定 |
| `status:good-first-issue` | 着手しやすい |

### gh CLI で一括作成（例）

```bash
gh label create "type:task" --color "1D76DB" --description "Development task (T-xxx)"
gh label create "type:bug" --color "D73A4A" --description "Bug fix"
gh label create "type:feature" --color "0E8A16" --description "User-facing feature"
gh label create "type:docs" --color "0075CA" --description "Documentation"
gh label create "type:chore" --color "FBCA04" --description "Maintenance / CI / deps"

gh label create "priority:P0" --color "B60205" --description "Must have"
gh label create "priority:P1" --color "D93F0B" --description "Important"
gh label create "priority:P2" --color "FEF2C0" --description "Nice to have"

gh label create "phase:0" --color "EDEDED" --description "Phase 0 — prep"
gh label create "phase:1" --color "C5DEF5" --description "Phase 1 — MVP v1.0"
gh label create "phase:2" --color "BFD4F2" --description "Phase 2 — experience"
gh label create "phase:3" --color "D4C5F9" --description "Phase 3 — monetization"
gh label create "phase:4" --color "E6E6E6" --description "Phase 4 — expansion"
```

`area:*` も同様に `gh label create` で追加。

---

## 3. Milestone

| Milestone | 説明 | 目安 |
|-----------|------|------|
| **v1.0 MVP** | 音符〜速度記号、単語帳、苦手、日英 | Phase 1 完了 |
| **v1.1** | フラッシュ、統計 | Phase 2 一部 |
| **v1.2** | リズム、和音 | Phase 2 |
| **v2.0** | カスタムカード + IAP | Phase 3 |

Issue 作成時に Milestone を必ず 1 つ付ける（どの出荷に含まれるかが一目で分かる）。

---

## 4. GitHub Project（推奨）

**Project 名例:** `Musical Note Training — Roadmap`

### ビュー構成

1. **Board**（ステータス）
   - カラム: `Backlog` → `Ready` → `In Progress` → `Review` → `Done`
   - フィールド: Status, Priority, Phase, Area

2. **Table**（タスク一覧）
   - ソート: Priority → Phase
   - フィルタ: `phase:1` かつ `priority:P0`

3. **Roadmap**（任意）
   - Milestone または Phase でタイムライン表示

### 運用

- Issue を Project に追加（Auto-add workflow 可）
- `docs/tasks.md` の T-xxx は Issue 化したものを Project で追跡
- PR マージで Done へ（GitHub の自動化ルール）

---

## 5. Issue テンプレート

リポジトリに `.github/ISSUE_TEMPLATE/` を配置済み:

- `task.yml` — 開発タスク（T-xxx 向け）
- `bug_report.yml` — 不具合
- `feature_request.yml` — 機能要望

---

## 6. 最初に作る Issue 例（Phase 0 残り）

| Issue タイトル | ラベル例 | Milestone |
|----------------|----------|-----------|
| T-003 Riverpod + go_router 導入 | type:task, priority:P0, phase:0, area:app | v1.0 MVP |
| T-010 データモデル設計 | type:task, priority:P0, phase:0, area:infra | v1.0 MVP |
| T-011 楽譜描画 PoC | type:task, priority:P0, phase:0, area:notation | v1.0 MVP |
| T-004 ローカル DB 選定 | type:task, priority:P0, phase:0 | v1.0 MVP |

---

## 関連

- [contributing.md](./contributing.md)
- [tasks.md](./tasks.md)