# BeerQuizSwift

SwiftUI版「ビール雑学クイズ」のApp Store申請用プロジェクトです。

## 構成

- `BeerQuiz.xcodeproj`: `xcodegen generate` で生成します。
- `BeerQuiz/`: SwiftUIアプリ本体、問題データ、アイコン素材。
- `BeerQuizTests/`: 問題データ検証とクイズ進行ロジックのユニットテスト。
- `SUBMISSION_READINESS.md`: 申請前の確認事項。

## 開発

```bash
xcodegen generate
xcodebuild test -scheme BeerQuiz -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.4.1'
```

## リリース方針

初回Swift版は広告SDKなし、ログインなし、サーバー通信なしのオフラインクイズとして構成しています。App Store ConnectのApp Privacyは、このSwift版に合わせて「データ収集なし」で回答する想定です。
