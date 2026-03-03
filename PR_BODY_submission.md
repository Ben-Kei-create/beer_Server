## Summary
- finalized AdMob + ATT flow for quiz play screen
- aligned package/bundle IDs to `io.github.benkeicreate.beerquiz`
- set Android AdMob App ID to production value
- added Android release signing safeguards (`key.properties` required)
- added in-app privacy policy link and updated policy pages
- updated store submission checklist/release notes

## Validation
- `flutter analyze`
- `flutter test`
- `flutter build appbundle --release` (success locally)

## Build Output
- `beer_quiz/build/app/outputs/bundle/release/app-release.aab`

## Notes
- iOS local no-codesign build is blocked by host environment extended-attribute issue during Flutter.framework codesign (`resource fork, Finder information, or similar detritus not allowed`).
