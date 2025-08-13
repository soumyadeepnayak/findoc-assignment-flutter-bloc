// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:findoc_assign/main.dart';

void main() {
  testWidgets('Login screen renders and validates inputs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

    // Enter invalid email and password to trigger validation messages
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'invalid');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'short');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();

    // Since validation is in BLoC on change, errors should be visible
    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.textContaining('Min 8 chars'), findsOneWidget);
  });
}
