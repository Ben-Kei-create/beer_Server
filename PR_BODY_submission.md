## Summary
- added a native SwiftUI App Store submission target under `BeerQuizSwift/`
- redesigned the SwiftUI screens with a bright beer-inspired theme, frothy panels, and floating pop icons
- added a quiz-screen AdMob banner using test ads in Debug and the configured production unit in Release
- bundled the 75-question beer quiz JSON into the Swift app
- added Swift unit tests for question data validation and quiz scoring
- updated privacy/support pages for the current no-ads, no-tracking Swift release
- documented App Store Connect inputs and remaining owner-side submission steps

## Validation
- `xcodegen generate`
- `xcodebuild test -scheme BeerQuiz -destination 'platform=iOS Simulator,id=19C3D85B-012E-4BD8-832C-A8B92AE64EEF'`
- `xcodebuild -scheme BeerQuiz -configuration Release -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build`
- simulator launch smoke test with home-screen screenshot

## Build Output
- Debug simulator app launches and loads 75 questions.
- Release iOS build compiles with Xcode 26.4.1 / iOS SDK 26.4.

## Notes
- Final App Store archive/upload still requires an Apple Developer Team ID and valid signing profile in Xcode.
- App icon assets were generated from the existing 640x640 source image; a fresh 1024x1024 source icon is recommended before final submission.
