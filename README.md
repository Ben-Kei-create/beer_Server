# beer_Server

`beer_Server`は「ビール雑学クイズ」アプリの開発・公開用リポジトリです。  
Flutterアプリ本体（`beer_quiz/`）と、公開用のプライバシーポリシーページを同梱しています。

## 現在の構成（整理）

- `beer_quiz/`  
  Flutterアプリ本体。クイズ画面、結果画面、問題データ、各プラットフォーム設定を含む。
- `privacy-policy.html` / `index.html`  
  プライバシーポリシーの公開HTML（同内容）。
- `new_questions.json`  
  問題データのソースJSON（編集用）。

## アプリ概要

- アプリ名: ビール雑学クイズ
- 技術: Flutter / Dart
- 主な機能:
  - 4択クイズ
  - 難易度（Easy / Medium / Hard）
  - 問題ごとの制限時間
  - スコア結果表示
- 広告連携:
  - `google_mobile_ads`
  - iOS向けに`app_tracking_transparency`

## 開発環境

- Flutter SDK（`beer_quiz/pubspec.yaml`の`environment.sdk: ^3.10.4`に対応する環境）
- Xcode（iOSビルド時）
- Android Studio / Android SDK（Androidビルド時）

## セットアップ

```bash
# 1) 依存取得
cd beer_quiz
flutter pub get

# 2) 端末確認
flutter devices

# 3) 実行例
flutter run -d chrome
```

## ビルド手順

```bash
cd beer_quiz

# Web
flutter build web

# Android
flutter build apk

# iOS
flutter build ios
```

## 注意事項

- AdMobは環境ごとにID管理が必要です（テストID/本番IDの切り替え確認）。
- プライバシーポリシー更新時は`privacy-policy.html`と`index.html`を同時更新してください。

