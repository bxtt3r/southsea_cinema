import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

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

      expect(find.text('BOOK NOW'), findsAtLeastNWidgets(1));

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

      expect(find.byType(MovieCard), findsAtLeastNWidgets(1));
      expect(find.text('BOOK NOW'), findsAtLeastNWidgets(1));
    });

    testWidgets('Tapping BOOK NOW opens the selected movie listing',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);

      expect(
        find.text('Black Panther: Wakanda Forever (2022)'),
        findsOneWidget,
      );

      expect(find.text('Add to order'), findsOneWidget);
    });

    testWidgets('Tapping Add to order displays confirmation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Add to order'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to order'));
      await tester.pump();

      expect(
        find.text('1 ticket(s) added to your order.'),
        findsOneWidget,
      );
    });
  });
}
