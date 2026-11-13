import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Creates Movie instance with given properties', () {
        const movie = Movie(
        id: 'sinners',
        title: 'sinners',
        synopsis: 'Ryan Coogler\’s horror-thriller Sinners (2025) follows '
          'twin brothers who return to the Jim Crow-era Mississippi '
          'Delta to escape their criminal past, only to encounter a '
          'terrifying supernatural threat.',
        ageRating: '12A',
        runtime: '2h 50m',
        screeningTime: 'Friday 2 Oct 2026, 19:00',
        posterImagePath: 'assets/images/sinners.jpg',
        ticketPrice: 9.25,
      );

    expect(movie.id, 'sinners');
    expect(movie.title, 'sinners');
    expect(movie.synopsis, 'Ryan Coogler\’s horror-thriller Sinners (2025) follows '
          'twin brothers who return to the Jim Crow-era Mississippi '
          'Delta to escape their criminal past, only to encounter a '
          'terrifying supernatural threat.');
    expect(movie.ageRating, '12A');
    expect(movie.runtime, '2h 50m');
    expect(movie.screeningTime, 'Friday 2 Oct 2026, 19:00');
    expect(movie.posterImagePath, 'assets/images/sinners.jpg');
    expect(movie.ticketPrice, 9.25);
    });

    test('formatted Price returns price prefixed with pound sign and two decimals', () {
      const movie = Movie(
      id: 'sinners',
      title: 'sinners',
      synopsis: 'Ryan Coogler\’s horror-thriller Sinners (2025) follows '
        'twin brothers who return to the Jim Crow-era Mississippi '
        'Delta to escape their criminal past, only to encounter a '
        'terrifying supernatural threat.',
      ageRating: '12A',
      runtime: '2h 50m',
      screeningTime: 'Friday 2 Oct 2026, 19:00',
      posterImagePath: 'assets/images/sinners.jpg',
      ticketPrice: 9.25,
      );

      expect(movie.formattedPrice, '£9.25');
    });

    test('formatted Price returns whole number price prefixed with pound sign and two decimals', () {
      const movie = Movie(
      id: 'sinners',
      title: 'sinners',
      synopsis: 'Ryan Coogler\’s horror-thriller Sinners (2025) follows '
        'twin brothers who return to the Jim Crow-era Mississippi '
        'Delta to escape their criminal past, only to encounter a '
        'terrifying supernatural threat.',
      ageRating: '12A',
      runtime: '2h 50m',
      screeningTime: 'Friday 2 Oct 2026, 19:00',
      posterImagePath: 'assets/images/sinners.jpg',
      ticketPrice: 9,
      );

      expect(movie.formattedPrice, '£9.00');
    });

  }
  );
}