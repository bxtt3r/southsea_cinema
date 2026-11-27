import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets('SettingsView displays heading, fields, switch and buttons', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    expect(find.text('My Settings'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Receive news by email'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('Entering details, toggling the switch and saving shows feedback',
      (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    final Finder nameField = find.byType(TextField).at(0);
    final Finder addressField = find.byType(TextField).at(1);
    final Finder emailField = find.byType(TextField).at(2);

    await tester.enterText(nameField, 'Alex Smith');
    await tester.enterText(addressField, '10 Elm Road, Portsmouth');
    await tester.enterText(emailField, 'alex@example.com');

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pump();

    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);
  });

  testWidgets('Cancel clears the form, the switch and the message', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    await tester.enterText(find.byType(TextField).at(0), 'Alex Smith');
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pump();

    expect(find.text('Alex Smith'), findsOneWidget);
    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);

    await tester.tap(find.text('CANCEL'));
    await tester.pump();

    expect(find.text('Alex Smith'), findsNothing);
    expect(find.text('Settings saved for Alex Smith'), findsNothing);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });

  testWidgets('The clear button empties only its own field', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    await tester.enterText(find.byType(TextField).at(0), 'Alex Smith');
    await tester.enterText(find.byType(TextField).at(2), 'alex@example.com');

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pump();

    expect(find.text('Alex Smith'), findsNothing);
    expect(find.text('alex@example.com'), findsOneWidget);
  });
}
