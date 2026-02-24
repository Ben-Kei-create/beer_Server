# 申請前の次アクション（オーナー実施）

## 1) GitHubでPRを作成

以下のURLを開いてPR作成:
- https://github.com/Ben-Kei-create/beer_Server/pull/new/codex/submission-readiness-audit

PRタイトル案:
- `Prepare store submission (ads/IDs/signing)`

PR本文は `../PR_BODY_submission.md` をそのまま貼り付けでOK。

## 2) Google Play Console に AAB をアップロード

アップロード対象:
- `build/app/outputs/bundle/release/app-release.aab`

確認ポイント:
- パッケージ名: `io.github.benkeicreate.beerquiz`
- AdMob App ID: `ca-app-pub-4859622277330192~4732107297`
- バナー広告ユニット: `ca-app-pub-4859622277330192/3079387929`

## 3) App Store Connect 入力（手動）

未完了項目:
- App Privacy の回答更新（AdMob利用分）
- Privacy Policy URL 設定
- Support URL 設定
- 年齢制限（Age Rating）質問票の再回答

注意:
- 2026年4月28日以降の提出は iOS 26 SDK / Xcode 26 が必要。

## 4) 秘密情報の保管

必ず保管:
- `/Users/fumiaki/upload-keystore.jks`
- `android/key.properties` の中身

紛失すると同じ署名鍵で更新配信できなくなるため、バックアップ推奨。
