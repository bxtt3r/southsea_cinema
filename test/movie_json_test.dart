import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie JSON conversion', () {
    test('fromJson builds a Movie and toJson returns the same map', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'test-movie',
        'title': 'Test Movie (2026)',
        'synopsis': 'A test movie for JSON conversion.',
        'ageRating': '12A',
        'runtime': '2h 00m',
        'screeningTime': 'Friday 27 Nov 2026, 18:00',
        'posterImagePath': 'assets/images/black_panther_wakanda_forever.jpg',
        'ticketPrice': 8.50,
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.id, 'test-movie');
      expect(movie.title, 'Test Movie (2026)');
      expect(movie.synopsis, 'A test movie for JSON conversion.');
      expect(movie.ageRating, '12A');
      expect(movie.runtime, '2h 00m');
      expect(movie.screeningTime, 'Friday 27 Nov 2026, 18:00');
      expect(
        movie.posterImagePath,
        'assets/images/black_panther_wakanda_forever.jpg',
      );
      expect(movie.ticketPrice, 8.50);

      expect(movie.toJson(), json);
    });

    test('fromJson converts a whole-number price to a double', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'test-movie-2',
        'title': 'Another Test Movie',
        'synopsis': 'Another test movie.',
        'ageRating': '15',
        'runtime': '1h 50m',
        'screeningTime': 'Saturday 28 Nov 2026, 20:00',
        'posterImagePath': 'assets/images/black_panther_wakanda_forever.jpg',
        'ticketPrice': 9,
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.ticketPrice, isA<double>());
      expect(movie.ticketPrice, 9.0);
    });
  });
}
