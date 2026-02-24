# App Store 申請チェックリスト（2026-02-23時点）

## 実装済み（このリポジトリで対応済み）

- [x] クイズプレイ中のみ広告表示（結果画面のインタースティシャル広告を削除）
- [x] ATT許可リクエストを広告表示前（クイズ開始時）に実行
- [x] アプリ内からプライバシーポリシーへ遷移可能
- [x] プライバシーポリシーに「保持期間・同意撤回・削除依頼」を追記
- [x] ホーム画面に「お酒は20歳になってから」表記を追加

## 実施が必要（App Store Connect / 設定）

- [x] **Bundle ID** を本番用に確定（`io.github.benkeicreate.beerquiz`）
- [ ] App Store Connect の **App Privacy** 回答を最新化（AdMob利用分を反映）
- [ ] App Store Connect の **Privacy Policy URL** を設定
- [ ] App Store Connect の **Support URL** を設定（連絡先情報を含むページ）
- [ ] App Store Connect の **年齢制限（Age Rating）質問票** を最新形式で再回答
- [ ] 2026年4月28日以降の提出は **iOS 26 SDK / Xcode 26** でビルド

## 補足

- iPadサポートを残す場合は、iPad向けの表示崩れ確認とスクリーンショット準備を推奨。
- URL（Privacy Policy / Support）は、公開後も常時アクセス可能であることを確認する。
