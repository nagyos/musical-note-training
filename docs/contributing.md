# 開発ルール（Contributing）

個人開発でも、ブランチ・Issue・PR の型を揃えておくと後から迷いません。

## 作業ディレクトリ（1 リポジトリのみ）

**正（canonical）**: `/mnt/c/Users/s.tagawa/Dev/musical-note-training`

| 役割 | パス |
|------|------|
| Cursor / エディタ | 上記（Windows: `C:\Users\s.tagawa\Dev\musical-note-training`） |
| WSL ターミナル（`stagawa@SHOKI-DESKTOP`） | **同上** |
| エージェントの編集・コミット | **同上** |

**使わない**: `/home/stagawa/Dev/musical-note-training`（`~/Dev/...`）  
同一 GitHub リモートでも **別 `.git`**。こちらで `flutter run` すると Cursor / エージェントのコミットとずれる。

```bash
cd /mnt/c/Users/s.tagawa/Dev/musical-note-training
pwd
git rev-parse --show-toplevel   # 上記と一致すること
```

詳細: [AGENTS.md](../AGENTS.md) §0

### WSL で `flutter run -d linux`（`/mnt/c` 上のリポジトリ）

WSL の Windows ドライブ（`/mnt/c` = drvfs）は **`chmod` が使えない**ため、そのままだと Linux ビルドが失敗することがある（`impellerc` / CMake の `Operation not permitted`）。

**恒久対策（推奨）** — Windows 側 PowerShell で WSL を一度終了してから設定:

```ini
# C:\Users\s.tagawa\.wslconfig または /etc/wsl.conf の [automount]
options = "metadata"
```

```powershell
wsl --shutdown
```

再起動後、次で `chmod` が通るか確認:

```bash
touch /mnt/c/Users/s.tagawa/Dev/musical-note-training/.perm_test
chmod 644 /mnt/c/Users/s.tagawa/Dev/musical-note-training/.perm_test
rm /mnt/c/Users/s.tagawa/Dev/musical-note-training/.perm_test
```

**暫定対策** — `build` を Linux ネイティブ領域へシンボリックリンク（リポジトリ直下で 1 回）:

```bash
cd /mnt/c/Users/s.tagawa/Dev/musical-note-training
rm -rf build linux/build
mkdir -p ~/.cache/flutter-build/musical-note-training/{build,linux-build}
ln -sfn ~/.cache/flutter-build/musical-note-training/build build
ln -sfn ~/.cache/flutter-build/musical-note-training/linux-build linux/build
flutter run -d linux
```

`metadata` 有効化後はシンボリックリンクを外して通常の `build/` に戻してよい。

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
4. 実装 → `dart analyze` / `flutter test` を通す → **ローカルコミット**（微調整は `git commit --amend` でまとめてよい）
5. **ローカルで動作確認**（`flutter run` 等）。デザイン・挙動に問題があれば同ブランチで修正 → amend
6. **ユーザーが OK を出したら** `origin` へ `issue/#N` を push（エージェントは確認前に push しない）
7. 問題なさそうなら `issue/#N` を **`develop` にマージ**（ローカル fast-forward マージ可）→ `origin/develop` を push
8. マージ後、Issue を close・作業ブランチを削除（任意）

**禁止**: GitHub Issue なしで `issue/N` ブランチだけ作って実装を進めない。ローカルブランチ番号と GitHub `#N` は必ず対応させる。

**マージ先の承認ルール**

| 操作 | 承認 | 備考 |
|------|------|------|
| `git push`（`issue/#N`） | **動作・デザイン確認後**（ユーザー判断） | テスト通過だけでは push しない。エージェントは確認前に push しない |
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

[Conventional Commits](https://www.conventionalcommits.org/) の型に従う。**概要は基本日本語**（`feat` / `fix` / `docs` などの type・scope、SMuFL 等の専門用語は英語可）。

```text
feat(study): 回答フィードバックアニメーションを追加
fix(notation): タブレットで五線の位置を調整
docs: 開発ルールを追記
chore(ci): PR で flutter test を実行
```

- 1 コミット = 1 論点（レビューしやすい粒度）
- **Issue 作業のコミットは末尾に `#N` を必須**（GitHub が Issue 画面にコミットを紐づける）。`N` はブランチ `issue/N` と同じ番号
- 形式: `feat(scope): 概要 #N` — 例: `feat(study): 学習縦スライス #3`
- コミット本文に `(issue/N)` は**付けない**（`#N` だけで足りる）
- 1 コミットで複数 Issue を閉じる場合のみ `#8 #9` のように並記可（通常は 1 Issue = 1 `#N`）

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
| 2026-07-13 | T-180〜T-189 | `flutter pub add share_plus file_picker google_sign_in googleapis extension_google_sign_in_as_googleapis_auth http` | データ引き継ぎ（エクスポート/インポート・Google Drive 同期） |
| 2026-07-13 | #26 | `flutter pub add file_selector` | Linux デスクトップのファイル選択・保存ダイアログ |

### Google Sign-In / Drive 同期の開発者設定（T-188）

実機で Google 連携・Drive 同期を試す前に、Google Cloud Console で OAuth クライアントを作成する。

1. [Google Cloud Console](https://console.cloud.google.com/) でプロジェクトを作成（または既存を選択）
2. **API とサービス → ライブラリ** で **Google Drive API** を有効化
3. **API とサービス → OAuth 同意画面** を設定（テスト段階は「外部」＋テストユーザー追加で可）
4. **認証情報 → 認証情報を作成 → OAuth クライアント ID**
   - **Android**: パッケージ名 `com.example.musical_note_training`（`android/app/build.gradle.kts` の `applicationId` に合わせる）＋ SHA-1（`keytool -list -v -keystore ~/.android/debug.keystore` 等）
   - **iOS**: Bundle ID（`ios/Runner/Info.plist` の `CFBundleIdentifier`）＋必要なら URL スキーム
5. Android は `android/app/build.gradle.kts` の default 設定で `google-services` 不要（`google_sign_in` 7.x はクライアント ID をプラットフォーム設定から読む）。iOS は `ios/Runner/Info.plist` に `GIDClientID`（または `GoogleService-Info.plist`）を追加
6. スコープ: `https://www.googleapis.com/auth/drive.appdata`（アプリ専用の非表示フォルダ）

ローカル検証は **Android 実機 / エミュレータ** または **iOS 実機** を推奨（Linux デスクトップは Google Sign-In 非対応のため Drive 同期 UI は無効化されないが動作しない）。

### コード生成（drift スキーマ変更時）

```bash
dart run build_runner build
```

`lib/shared/data/database/app_database.dart` のテーブル定義を変えたら上記を実行する。

## 関連

- [github-setup.md](./github-setup.md) — ラベル・Milestone・Project 初期設定
- [tasks.md](./tasks.md) — タスク一覧
- [architecture.md](./architecture.md) — ディレクトリ構成