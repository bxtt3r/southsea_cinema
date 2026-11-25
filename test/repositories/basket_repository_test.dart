import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie movie1 = Movie(
  id: 'test-movie',
  title: 'Test movie (2026)',
  synopsis: 'A test movie for widget testing.',
  ageRating: '12A',
  runtime: '2h 00m',
  screeningTime: 'Friday 27 Nov 2026, 18:00',
  posterImagePath: 'assets/images/black_panther_wakanda_forever.jpg',
  ticketPrice: 8.50,
);

const Movie movie2 = Movie(
  id: 'test-movie-2',
  title: 'The Midnight Chase (2026)',
  synopsis: 'A detective races against time to solve a mysterious disappearance.',
  ageRating: '15',
  runtime: '1h 55m',
  screeningTime: 'Saturday 28 Nov 2026, 20:00',
  posterImagePath: 'assets/images/jaws.jpg',
  ticketPrice: 9.50,
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    test('starts with empty basket and zero totals', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(basket.getItems().length, 0);
      expect(basket.getTotalItems(), 0);
      expect(basket.totalItemCount, 0);
      expect(basket.getSubtotal(), 0.0);
      expect(basket.getServiceFee(), 0.0);
      expect(basket.getTotalDue(), 0.0);
    });

    test('adds items and calculates subtotal and service fee correctly', () {
      final BasketRepository basket = BasketRepository.instance;

      const BasketItem item1 = BasketItem(movie: movie1, quantity: 3);
      const BasketItem item2 = BasketItem(movie: movie2, quantity: 5);

      basket.addItem(item1);
      basket.addItem(item2);

      expect(basket.getItems().length, 2);
      expect(basket.getTotalItems(), 8);
      expect(basket.totalItemCount, 8);
      expect(basket.getSubtotal(), 73.0);
      expect(basket.getServiceFee(), 3.0);
      expect(basket.getTotalDue(), 76.0);
    });

    test('removes items correctly', () {
      final BasketRepository basket = BasketRepository.instance;

      const BasketItem item = BasketItem(movie: movie1, quantity: 1);

      basket.addItem(item);

      expect(basket.getItems().length, 1);

      basket.removeItem(0);

      expect(basket.getItems().length, 0);
      expect(basket.getTotalDue(), 0.0);
    });
  });
}