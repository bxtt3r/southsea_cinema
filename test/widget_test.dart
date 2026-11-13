import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

void main() {
  group('Southsea Cinema widget tests', () {
    testWidgets('SouthseaCinemaApp displays HomeView as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('Home page displays all movie cards and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      // Check the first movie.
      expect(
        find.textContaining(
          'BLACK PANTHER: WAKANDA FOREVER (2022)',
          findRichText: true,
        ),
        findsOneWidget,
      );

      // Scroll to the second movie.
      await tester.scrollUntilVisible(
        find.textContaining(
          'THE DARK KNIGHT (2008)',
          findRichText: true,
        ),
        300,
      );

      expect(
        find.textContaining(
          'THE DARK KNIGHT (2008)',
          findRichText: true,
        ),
        findsOneWidget,
      );

      // Scroll to the third movie.
      await tester.scrollUntilVisible(
        find.textContaining(
          'JAWS (1975)',
          findRichText: true,
        ),
        300,
      );

      expect(
        find.textContaining(
          'JAWS (1975)',
          findRichText: true,
        ),
        findsOneWidget,
      );

      expect(find.text('BOOK NOW'), findsAtLeastNWidgets(1));
    });

    testWidgets(
        'Opening a second film shows its own listing with fresh feedback',
        (WidgetTester tester) async {
      // Make the test screen tall enough that all three cards are built
      await tester.binding.setSurfaceSize(const Size(800, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const SouthseaCinemaApp());

      // 1. Open Black Panther (first BOOK NOW button)
      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();
      expect(find.byType(MovieListing), findsOneWidget);
      expect(
          find.text('Black Panther: Wakanda Forever (2022)'), findsOneWidget);

      // 2. Add to order and check the confirmation
      final Finder addToOrder = find.text('Add to order');
      await tester.ensureVisible(addToOrder);
      await tester.pumpAndSettle();
      await tester.tap(addToOrder);
      await tester.pump();
      expect(find.text('1 ticket(s) added to your order.'), findsOneWidget);

      // 3. Go back to the home page
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(MovieListing), findsNothing);

      // 4. Open The Dark Knight (second BOOK NOW button)
      await tester.tap(find.text('BOOK NOW').at(1));
      await tester.pumpAndSettle();

      // 5. Check the correct film opened with fresh feedback
      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('The Dark Knight (2008)'), findsOneWidget);
      expect(find.text('1 ticket(s) added to your order.'), findsNothing);
    });
  });
}
