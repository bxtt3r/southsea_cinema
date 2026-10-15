import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model', () {
    test('stores the supplied movie details', () {
      const movie = Movie(
        id: 'test-film',
        title: 'Test Film (2026)',
        synopsis: 'A short test synopsis.',
        ageRating: '12A',
        runtime: '100 minutes',
        screeningTime: 'Saturday 17 October 2026, 18:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/black_panther.png',
      );

      expect(movie.id, 'test-film');
      expect(movie.title, 'Test Film (2026)');
      expect(movie.synopsis, 'A short test synopsis.');
      expect(movie.ageRating, '12A');
      expect(movie.runtime, '100 minutes');
      expect(movie.screeningTime, 'Saturday 17 October 2026, 18:00');
      expect(movie.ticketPrice, 7.50);
      expect(movie.posterImagePath, 'assets/images/black_panther.png');
    });

    test('formats a whole-pound price with two decimal places', () {
      const movie = Movie(
        id: 'whole-pound',
        title: 'Whole Pound Film',
        synopsis: 'Test synopsis.',
        ageRating: 'PG',
        runtime: '90 minutes',
        screeningTime: 'Saturday 17 October 2026, 18:00',
        ticketPrice: 8,
        posterImagePath: 'assets/images/black_panther.png',
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('formats a price with pence to two decimal places', () {
      const movie = Movie(
        id: 'price-with-pence',
        title: 'Pence Film',
        synopsis: 'Test synopsis.',
        ageRating: 'PG',
        runtime: '90 minutes',
        screeningTime: 'Saturday 17 October 2026, 18:00',
        ticketPrice: 7.5,
        posterImagePath: 'assets/images/black_panther.png',
      );

      expect(movie.formattedPrice, '£7.50');
    });
  });
}
