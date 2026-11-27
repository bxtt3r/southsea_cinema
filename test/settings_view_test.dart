import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('SettingsView displays heading, fields, switch and buttons', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

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

  testWidgets('Saving stores the profile and it is loaded when reopened', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Alex Smith');
    await tester.enterText(
      find.byType(TextField).at(1),
      '10 Elm Road, Portsmouth',
    );
    await tester.enterText(find.byType(TextField).at(2), 'alex@example.com');

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pumpAndSettle();

    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefName), 'Alex Smith');
    expect(await prefs.getString(prefAddress), '10 Elm Road, Portsmouth');
    expect(await prefs.getString(prefEmail), 'alex@example.com');
    expect(await prefs.getBool(prefNewsletter), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Alex Smith'), findsOneWidget);
    expect(find.text('10 Elm Road, Portsmouth'), findsOneWidget);
    expect(find.text('alex@example.com'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('SettingsView pre-fills saved settings on open', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefName: 'Abdul Kadir',
      prefAddress: 'Portsmouth Guildhall, PO1 2AJ',
      prefEmail: 'abdul.kadir@example.com',
      prefNewsletter: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Abdul Kadir'), findsOneWidget);
    expect(find.text('Portsmouth Guildhall, PO1 2AJ'), findsOneWidget);
    expect(find.text('abdul.kadir@example.com'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('Cancel clears the form, the switch and the message', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Alex Smith');
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pumpAndSettle();

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
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Alex Smith');
    await tester.enterText(find.byType(TextField).at(2), 'alex@example.com');

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pump();

    expect(find.text('Alex Smith'), findsNothing);
    expect(find.text('alex@example.com'), findsOneWidget);
  });
}
