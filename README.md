# beer_Server

`beer_Server`は「ビール雑学クイズ」アプリの開発・公開用リポジトリです。  
現在のApp Store申請対象はSwiftUI版（`BeerQuizSwift/`）です。

## 現在の構成（整理）

- `BeerQuizSwift/`  
  SwiftUIネイティブ版。App Store申請対象のXcodeプロジェクト、問題データ、テストを含む。
- `beer_quiz/`  
  旧Flutter版の作業フォルダ。Swift版リリースでは参照用として扱う。
- `privacy-policy.html` / `index.html`  
  プライバシーポリシーの公開HTML（同内容）。
- `support.html`  
  App Store ConnectのSupport URL向けページ。
- `new_questions.json`  
  問題データのソースJSON（編集用）。Swift版には `BeerQuizSwift/BeerQuiz/Resources/beer_quiz.json` として同梱。

## アプリ概要

- アプリ名: ビール雑学クイズ
- 技術: Swift / SwiftUI
- 主な機能:
  - 4択クイズ
  - 難易度（Easy / Medium / Hard）
  - 問題ごとの制限時間
  - スコア結果表示
- 広告連携:
  - Google AdMobバナー広告
  - DebugはGoogle公式テスト広告ID、Releaseは本番広告ユニットIDを使用

## 開発環境

- Xcode 26以降
- iOS 26 SDK以降
- XcodeGen

## セットアップ

```bash
cd BeerQuizSwift
xcodegen generate
xcodebuild test -scheme BeerQuiz -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.4.1'
```

## ビルド手順

```bash
cd BeerQuizSwift
xcodegen generate
xcodebuild -scheme BeerQuiz -configuration Release -destination 'generic/platform=iOS' build
```

## 注意事項

- App Store申請前にApple Developer Team IDをXcodeのSigningへ設定してください。
- AdMobの本番配信前に、App Store ConnectのApp Privacy回答をAdMob利用分に合わせて更新してください。
- プライバシーポリシー更新時は`privacy-policy.html`と`index.html`を同時更新してください。
