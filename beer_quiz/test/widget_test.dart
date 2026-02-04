// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:beer_quiz/main.dart';

void main() {
  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home screen shows the app title
    expect(find.text('ビール雑学クイズ'), findsAtLeastNWidgets(1));

    // Verify that the start button is present
    expect(find.text('スタート'), findsOneWidget);

    // Verify that the beer emoji is present
    expect(find.text('🍺'), findsOneWidget);
  });
}
