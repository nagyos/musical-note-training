# アーキテクチャ・ディレクトリ構成

公式スキル [flutter-apply-architecture-best-practices](../.agents/skills/flutter-apply-architecture-best-practices/SKILL.md) をベースに、**スケールしやすい feature-module + shared kernel** 構成を採用する。

> **リリース計画（MVP）とディレクトリ構成は別物。**  
> フォルダは将来機能分まで最初から決め、**実装は段階的**に進める。MVP は「何を出荷するか」の話であり、後から `lib/` を組み替えない。

---

## 3 層 + features

```text
app/       … 起動・ルーティング・DI（composition root）
core/      … テーマ・定数・ユーティリティ（ビジネスロジックなし）
shared/    … 2 つ以上の feature が使う domain / data / widgets
features/  … 画面単位の機能（必要なら feature 内に domain/data を持てる）
```

```text
┌──────────────────────────────────────────────────────────────┐
│  features/*/presentation     Pages / Widgets / ViewModels    │
├──────────────────────────────────────────────────────────────┤
│  features/*/domain           feature 固有のモデル・UseCase   │  ← 必要時のみ
│  features/*/data             feature 固有の Repository       │  ← 必要時のみ
├──────────────────────────────────────────────────────────────┤
│  shared/widgets              楽譜描画・共通 UI                 │
├──────────────────────────────────────────────────────────────┤
│  shared/domain               共通モデル・Repository 抽象      │
│  shared/data                 DB・DTO・Repository 実装          │
├──────────────────────────────────────────────────────────────┤
│  core/                       インフラ（UI・ドメイン非依存）    │
└──────────────────────────────────────────────────────────────┘
```

### 依存ルール

```text
features → shared → core
features → core          （shared を経由せず core だけ触るのは OK）

禁止:
  shared  → features
  core    → shared / features
  data    → presentation
```

---

## ディレクトリ構成（確定版）

```text
lib/
├── main.dart                          # エントリのみ
│
├── app/                               # Composition Root
│   ├── app.dart                       # MaterialApp / テーマ / l10n
│   ├── bootstrap.dart                 # 非同期初期化（DB 等）
│   ├── di/
│   │   └── providers.dart             # Riverpod 集約（T-003）
│   └── router/
│       ├── routes.dart                # パス定数
│       └── app_router.dart            # GoRouter（T-003）
│
├── core/                              # 横断的インフラ（ビジネスなし）
│   ├── constants/
│   ├── errors/                        # AppException 等
│   ├── extensions/
│   ├── theme/
│   └── utils/
│
├── shared/
│   ├── domain/
│   │   ├── models/                    # Card, Deck, Category, Lesson …
│   │   └── repositories/              # 抽象インターフェース
│   ├── data/
│   │   ├── database/                  # Turso (libSQL) + embedded replica
│   │   ├── datasources/               # local / asset JSON
│   │   ├── dto/                       # JSON / DB 行モデル
│   │   └── repositories/              # 抽象の実装
│   └── widgets/
│       ├── common/                    # ローディング・ボタン等
│       └── notation/                  # 五線譜・音符・休符・記号
│
├── features/
│   ├── home/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── view_models/
│   ├── catalog/                       # カテゴリー・レッスン一覧（旧 category）
│   │   └── presentation/
│   ├── study/                         # 共通クイズエンジン
│   │   ├── domain/                    # StudySession, 正誤判定
│   │   └── presentation/
│   ├── deck/
│   │   └── presentation/
│   ├── weak_items/
│   │   └── presentation/
│   ├── settings/
│   │   └── presentation/
│   ├── flash/                         # Phase 2 — フォルダのみ先に確保可
│   │   └── presentation/
│   ├── rhythm/                        # Phase 2
│   │   ├── domain/                    # テンポ・拍子ロジック
│   │   └── presentation/
│   └── custom_card/                   # Phase 3 — 課金エディタ
│       ├── domain/
│       ├── data/
│       └── presentation/
│
└── l10n/                              # ARB（T-014）
    ├── app_en.arb
    └── app_ja.arb

assets/
└── content/                           # 公式カード JSON シード
    ├── notes.json
    └── ...

test/
├── shared/
├── features/
└── ...                                # lib/ と同型を推奨

integration_test/
```

---

## アーキテクチャスタイル（DDD との関係）

**厳密な DDD ではなく、Flutter 向けの feature-module + レイヤード構成**を採用する。

| 採用する考え方 | 採用しない（本プロジェクト規模では過剰） |
|----------------|------------------------------------------|
| ドメインモデル（`shared/domain/models/`） | 境界づけられたコンテキストの厳密分離 |
| Repository 抽象と実装の分離 | 集約ルート・ドメインイベントの全面運用 |
| feature 単位の責務分割 | Ubiquitous Language の形式張った運用 |
| 複雑な feature だけ `domain/` にロジック | 全 feature に UseCase クラスを必須化 |

**study** のクイズエンジンや **rhythm** の拍ロジックなど、ロジックが複雑になった feature から `domain/` を厚くする。  
画面が薄い feature（home, settings）は `presentation/` のみでよい。

→ **「DDD で全部やる」より「ドメイン中心のレイヤード + feature 分割」** がこのアプリに合う。

---

## 定数・マジックナンバーの置き場

**必要最低限の粒度で「塊」として管理**する。全部を 1 ファイルに集めない。

| 塊 | 置き場 | 例 |
|----|--------|-----|
| アプリ全体の余白スケール | `core/theme/app_spacing.dart` | `AppSpacing.sm`, `lg` |
| 楽譜描画の比率・閾値 | `shared/widgets/notation/staff_metrics.dart` | `noteXRatio`, `stemUpThresholdStep` |
| アプリ名など不変の識別子 | `core/constants/app_constants.dart` | 既存 |
| 1 画面だけの一度きりの値 | その Widget 内 | 無理に共通化しない |

`StaffLayout` / `StaffPainter` は **計算と描画** に専念し、チューニング値は `StaffMetrics` に集約する。

---

## コード品質・テスト（実装ルール）

エージェント・開発者共通の詳細ルールは [AGENTS.md](../AGENTS.md) §7（設計原則）・§8（テスト方針）を参照。

**要約**

- クリーン・疎結合・単一責任を優先。`features → shared → core` を守る。
- ドメインロジックは `domain/` の純 Dart。Widget / Painter にビジネスルールを書かない。
- **domain / repository 推奨領域は TDD 必須**（`AGENTS.md` §8）。UI はクリティカルパスのみテスト。
- 過剰設計は避ける。ルールが不適切な場合は `decisions.md` で見直す。

---

## 各レイヤーの責務

| 場所 | 置くもの | 置かないもの |
|------|----------|--------------|
| `app/` | ルーター、DI、MaterialApp | 画面 Widget、ビジネスロジック |
| `core/` | Theme, 定数, DateUtils | Card, Deck 等のドメイン |
| `shared/domain` | 全 feature で共有するモデル・Repo 抽象 | 画面状態 |
| `shared/data` | DB, JSON 読込, Repo 実装 | Widget |
| `shared/widgets/notation` | CustomPainter 等の **描画のみ** | 正誤判定 |
| `features/*/presentation` | Page, ViewModel(Notifier) | SQL, HTTP |
| `features/*/domain` | その feature だけのロジック | 他 feature から import されない設計 |
| `features/*/data` | その feature だけの Repo 実装 | 共通 Card Repo（→ shared） |

---

## feature 一覧

| Feature | 責務 | 共有 / 固有 |
|---------|------|-------------|
| **home** | ダッシュボード、各機能への入口 | presentation のみ |
| **catalog** | 音符/休符/記号…カテゴリー・レッスン一覧 | shared CardRepo |
| **study** | 出題→回答→フィードバック（全学習モード共通） | domain にセッションエンジン |
| **deck** | 単語帳 CRUD・デッキ学習開始 | shared DeckRepo |
| **weak_items** | 苦手一覧・苦手復習開始 | shared WeakItemRepo |
| **settings** | 言語、音名モード、課金状態表示 | presentation + IAP 読取 |
| **flash** | タイマー式フラッシュ | study と CardRepo を再利用 |
| **rhythm** | テンポ同期・リズムパターン | **固有 domain**（拍・BPM） |
| **custom_card** | 五線譜エディタ、和音作成 | **固有 data/domain** + notation |

### study feature を中心に据える理由

catalog / deck / weak_items は「カード集合の選び方」だけが違う。クイズ UI と正誤フローは 1 か所に集約する。

```dart
// shared/domain/models/study_source.dart（既存）
enum StudySourceType { catalog, deck, weakItems }
// 将来: flash, rhythm 用の Source を拡張 or 別 feature から study を呼ばない
```

---

## 前回案（中央集約 data/）からの変更点

| 前回 | 今回 | 理由 |
|------|------|------|
| `lib/data/repositories/` に全部 | `shared/data` + `features/*/data` | rhythm / custom_card が肥大化しても shared を汚さない |
| `lib/ui/features/` | `lib/features/*/presentation/` | feature が domain/data を隣に持てる |
| `lib/domain/` トップレベル | `shared/domain/` | 「共有カーネル」であることが名前から明確 |
| MVP 時だけ home/study | 全 feature パスを docs で定義 | 後からフォルダを増やさず feature を「追加実装」できる |

---

## リリースフェーズ vs 実装順（MVP の位置づけ）

**MVP = v1.0 で出荷する機能セット。** ディレクトリは上記フル構成を前提に、中身を順に埋める。

| フェーズ | 出荷する機能 | 主に触る feature / shared |
|----------|--------------|---------------------------|
| v1.0 MVP | 音符〜速度記号、単語帳、苦手、日英 | catalog, study, deck, weak_items, settings, shared/* |
| v1.1 | フラッシュ、統計強化 | flash, study |
| v1.2 | リズム、和音識別 | rhythm, notation |
| v2.0 | カスタムカード + IAP | custom_card, app/di（IAP provider） |

インフラ（`core/`, `app/`, `shared/widgets/notation/`）は v1.0 から正しい場所に置く。

---

## presentation 内の命名

各 feature の `presentation/` は次で統一する。

```text
presentation/
├── pages/           # 画面 1 ファイル = 1 route
├── widgets/         # その feature 専用の部品
└── view_models/     # Riverpod Notifier / AsyncNotifier（T-003）
```

公式スキルの ViewModel = Riverpod の `Notifier` クラスを `view_models/` に置く。

---

## テスト配置

```text
test/
├── shared/
│   ├── domain/
│   └── data/
├── features/
│   └── study/
│       └── domain/
└── ...

integration_test/
└── app_test.dart                      # ホーム → 学習 1 周
```

feature の domain ロジック（正誤判定・苦手スコア）は **必ず** `test/features/<name>/domain/` に置く。

---

## 技術選定（T-003 以降）

| 項目 | 選定 | スキル |
|------|------|--------|
| 状態管理 | Riverpod | architecture skill |
| ルーティング | go_router | flutter-setup-declarative-routing |
| モデル | freezed（推奨） | flutter-implement-json-serialization |
| DB | **MVP**: drift + SQLite（ローカル） / **将来**: Turso (libSQL) 同期 | — |
| i18n | ARB | flutter-setup-localization |

---

## 現在の scaffold 状態

| パス | 状態 |
|------|------|
| `lib/main.dart` | ✅ エントリ |
| `lib/app/` | ✅ app, bootstrap, routes, router, di |
| `lib/core/` | ✅ theme, constants |
| `lib/shared/` | ✅ models, notation, `app_database` (drift) |
| `lib/features/home/` | ✅ HomePage |
| その他 feature | 📁 本 doc のパスに従い実装時に追加 |
| `app/router/app_router.dart` | ✅ |
| `app/di/providers.dart` | ✅ |

---

## 関連

- [tasks.md](./tasks.md) — T-002 完了
- [roadmap.md](./roadmap.md) — 出荷フェーズ
- [functional-requirements.md](./functional-requirements.md)
