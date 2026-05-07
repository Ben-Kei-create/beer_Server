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

## 広告

クイズ画面の下部にAdMobバナー広告を表示します。

- Debug: Google公式テスト広告ユニット
- Release: `ca-app-pub-4859622277330192/3079387929`

App Store提出前に、App Store ConnectのApp Privacy回答をAdMob利用分に合わせて更新してください。パーソナライズ広告やEEA/UK配信を行う場合は、UMP/ATT同意導線も別途確認してください。
