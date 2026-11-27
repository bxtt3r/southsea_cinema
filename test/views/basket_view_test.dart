import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

const Movie testMovie = Movie(
  id: 'test-movie',
  title: 'Test Movie (2026)',
  synopsis: 'A test movie.',
  ageRating: '12A',
  runtime: '2h 00m',
  screeningTime: 'Friday 27 Nov 2026, 18:00',
  posterImagePath: 'assets/images/black_panther_wakanda_forever.jpg',
  ticketPrice: 8.50,
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  testWidgets('BasketView shows empty message when basket has no items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('BUY TICKETS'), findsNothing);
  });

  testWidgets('BasketView shows tickets and removes one when bin is tapped', (
    WidgetTester tester,
  ) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: testMovie, quantity: 2),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('MY ORDER'), findsOneWidget);
    expect(find.text('TEST MOVIE (2026)'), findsOneWidget);
    expect(find.text('2 x Standard · Southsea Cinema Room'), findsOneWidget);
    expect(find.text('£17.00'), findsOneWidget);
    expect(find.text('Service Charge'), findsOneWidget);
    expect(find.text('Total Due'), findsOneWidget);
    expect(find.text('£20.00'), findsOneWidget);
    expect(find.text('BUY TICKETS'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });

  testWidgets('Tapping BUY TICKETS clears the basket and thanks the customer', (
    WidgetTester tester,
  ) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: testMovie, quantity: 1),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.text('BUY TICKETS'));
    await tester.pump();

    expect(find.text('Thanks, your tickets are booked'), findsOneWidget);
    expect(BasketRepository.instance.getItems(), isEmpty);
  });
}
