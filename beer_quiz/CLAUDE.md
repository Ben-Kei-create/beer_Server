# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application named "beer_quiz" - a beer trivia quiz app with 50 questions across three difficulty levels (Easy, Medium, Hard). The app randomly selects 10 questions per quiz session with a 30-second timer per question.

## Development Commands

### Running the App

```bash
# Run on default device
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d macos           # macOS
flutter run -d android         # Android
flutter run -d ios             # iOS

# List available devices
flutter devices

# Hot reload: press 'r' in terminal
# Hot restart: press 'R' in terminal
# Quit: press 'q' in terminal
```

### Testing

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality

```bash
# Run static analysis
flutter analyze

# Format code
dart format .

# Check formatting without modifying files
dart format --set-exit-if-changed .
```

### Dependencies

```bash
# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

### Building

```bash
# Build for production (specific platform)
flutter build apk              # Android APK
flutter build appbundle        # Android App Bundle
flutter build ios              # iOS
flutter build web              # Web
flutter build macos            # macOS
flutter build windows          # Windows
flutter build linux            # Linux
```

## Project Structure

### Core Files
- `lib/main.dart` - Application entry point with Material 3 theme (golden/white colors)
- `pubspec.yaml` - Dependencies including `google_mobile_ads: ^5.3.1`
- `analysis_options.yaml` - Dart analyzer configuration using flutter_lints

### Models
- `lib/models/quiz_question.dart` - Quiz question data model with difficulty field
- `lib/models/quiz_result.dart` - Quiz result with score calculation and title system

### Screens
- `lib/screens/home_screen.dart` - Home screen with start button
- `lib/screens/quiz_screen.dart` - Quiz screen with 4 choices, timer, difficulty badge
- `lib/screens/result_screen.dart` - Result screen with score, title, and trivia list

### Assets
- `assets/data/beer_quiz.json` - 50 quiz questions with difficulty levels

### Platform-specific Configuration

#### iOS (ios/Runner/Info.plist)
- ATT (App Tracking Transparency) permission text configured
- AdMob App ID: `ca-app-pub-3940256099942544~1458002511` (test ID)
- SKAdNetwork configured

#### Android (android/app/src/main/AndroidManifest.xml)
- INTERNET and AD_ID permissions
- AdMob App ID: `ca-app-pub-3940256099942544~3347511713` (test ID)

## Application Architecture

### Quiz Flow
1. Home screen displays beer emoji and start button
2. Quiz screen loads 50 questions from JSON, randomly selects 10
3. Each question has:
   - 30-second countdown timer (red when ≤5 seconds)
   - Difficulty badge (Easy: green, Medium: orange, Hard: red)
   - 4 multiple-choice answers
   - Visual feedback (green for correct, red for wrong)
4. After all questions, navigate to result screen

### Scoring & Title System
- 0-3 correct: "ビール初心者（まずは一杯！）"
- 4-7 correct: "中堅ビアラバー（通の入り口）"
- 8-10 correct: "伝説のビアマスター（乾杯の神）"

### Theme
- Material 3 with golden amber primary color (#FFB300)
- White surface with light golden background gradient
- Card-based UI with rounded corners and elevation

## Code Standards

The project uses `flutter_lints` package for enforcing Flutter best practices. Lint rules are defined in `analysis_options.yaml`.

## Important Notes for Development

### AdMob Integration
- Currently using **test App IDs** - must be replaced before production release
- AdMob is initialized in `main.dart` but no ads are displayed yet
- See `STORE_RELEASE_NOTES.md` for production setup instructions

### Store Release Requirements
- **Age rating**: 17+ (Apple), 18+ (Google Play)
- Must include "お酒は20歳になってから" in store description
- See `STORE_RELEASE_NOTES.md` for keyword strategy and ATT details

### Quiz Data
- JSON format in `assets/data/beer_quiz.json`
- Each question requires: question, choices (array of 4), correctAnswerIndex (0-3), trivia, difficulty (Easy/Medium/Hard)
- App randomly selects 10 questions on each quiz start
