import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton shows its label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(label: 'Hello', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('PrimaryButton runs callback when tapped',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
              label: 'Sleep',
              onPressed: () {
                wasPressed = true;
              }),
        ),
      ),
    );

    await tester.tap(find.text('Sleep'));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
