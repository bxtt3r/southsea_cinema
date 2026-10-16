import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository', () {
    final repository = MovieRepository();

    test('returns two movies with distinct IDs and details', () {
      final movies = repository.getMovies();

      expect(movies.length, 2);
      expect(movies[0].id, isNot(movies[1].id));
      expect(movies[0].title, 'Black Panther: Wakanda Forever (2022)');
      expect(movies[1].title, 'The Batman (2022)');
      expect(movies[0].posterImagePath, 'assets/images/black_panther.png');
      expect(movies[1].posterImagePath, 'assets/images/the_batman.png');
      expect(movies[0].ticketPrice, 7.50);
      expect(movies[1].ticketPrice, 7.50);
    });

    test('finds a movie when its ID exists', () {
      final movie = repository.getMovieById('the-batman');

      expect(movie, isNotNull);
      expect(movie!.title, 'The Batman (2022)');
    });

    test('returns null when the ID does not exist', () {
      expect(repository.getMovieById('missing-film'), isNull);
    });
  });
}
