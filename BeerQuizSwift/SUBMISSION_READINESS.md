# Swift版 App Store申請準備メモ

確認日: 2026-05-08

## 現在の状態

- リリース対象: `BeerQuizSwift/BeerQuiz.xcodeproj`
- Bundle ID: `io.github.benkeicreate.beerquiz`
- Version: `1.0.0`
- Build: `1`
- 最低対応OS: iOS 17.0
- 対応端末: iPhone / iPad
- 広告SDK: なし
- ATT: 不要
- サーバー通信: なし
- 問題データ: アプリ内JSONに75問同梱

## App Store Connect入力方針

- App名: ビール雑学クイズ
- カテゴリ候補: 教育 / トリビアゲーム
- Privacy Policy URL: `https://ben-kei-create.github.io/beer_Server/privacy-policy.html`
- Support URL: `https://ben-kei-create.github.io/beer_Server/support.html`
- App Privacy: データ収集なし
- 年齢制限: アルコール関連コンテンツありとして回答

## 申請前に人の手で必要なもの

- Apple Developer Team IDをXcodeのSigningに設定
- 実機またはTestFlightで最終操作確認
- App Store用スクリーンショットの作成
- App Store Connectで年齢制限、カテゴリ、価格、配信地域を入力
- App Iconの元画像を1024x1024以上で再作成推奨

## 確認したApple要件

- 2026年4月28日以降、iOSアプリはXcode 26以降かつiOS 26 SDK以降でのビルドが必要。
- App Privacyでは、アプリ本体または第三者SDKが収集するデータをApp Store Connectで回答する必要がある。

参考:
- https://developer.apple.com/news/upcoming-requirements/?id=02032026a
- https://developer.apple.com/app-store/app-privacy-details/
