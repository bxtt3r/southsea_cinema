import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  group('Southsea Cinema home page', () {
    testWidgets('shows the app title, movie cards and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.text(appTitle), findsOneWidget);
      expect(find.byType(MovieCard), findsNWidgets(2));
      expect(find.text('Black Panther: Wakanda Forever (2022)'), findsOneWidget);
      expect(find.text('The Batman (2022)'), findsOneWidget);
      expect(find.text('BOOK NOW'), findsNWidgets(2));
    });

    testWidgets('booking opens the selected film and add-to-order shows feedback',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      final bookingButton = find.text('BOOK NOW').first;
      await tester.ensureVisible(bookingButton);
      await tester.tap(bookingButton);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(
        find.byKey(const Key('movie-listing-title')),
        findsOneWidget,
      );
      expect(
        find.text('Black Panther: Wakanda Forever (2022)'),
        findsOneWidget,
      );

      await tester.tap(find.text('Add to order'));
      await tester.pump();

      expect(
        find.text('1 ticket(s) added to your order.'),
        findsOneWidget,
      );
    });
  });
}
