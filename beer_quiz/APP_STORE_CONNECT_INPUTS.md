# App Store Connect 入力メモ

## App Information
- Name: ビール雑学クイズ
- Bundle ID: `io.github.benkeicreate.beerquiz`
- Category: 教育ゲーム（既存Xcode設定と整合）

## App Privacy（AdMob利用あり）
- Third-Party Advertising: `Yes`
- Advertising Data / Device ID など、AdMobで使用される項目を申告
- Data Linked to User / Not Linked は実際のAdMob設定に合わせて回答

## Privacy Policy URL
- `https://ben-kei-create.github.io/beer_Server/privacy-policy.html`

## Support URL
- 公開されている問い合わせ先ページURLを設定
- 未作成なら、同リポジトリ内に連絡先付きページを用意して公開後に設定

## Age Rating
- アルコール関連コンテンツに該当する設問を適切に `Yes`
- 説明文に「お酒は20歳になってから」を含める運用を継続

## ATT
- `NSUserTrackingUsageDescription` は実装済み
- 審査時に広告表示導線（クイズ画面でバナー表示）を確認できるようにしておく
