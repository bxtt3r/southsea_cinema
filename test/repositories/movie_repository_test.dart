import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns three movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 3);
    });

    test('getMovies contains valid movie entries', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie blackPanther = movies[0];
      expect(blackPanther.id, 'black-panther-wakanda-forever');
      expect(blackPanther.title, 'Black Panther: Wakanda Forever (2022)');
      expect(blackPanther.ticketPrice, 8.50);
      expect(blackPanther.posterImagePath, isNotEmpty);

      final Movie darkKnight = movies[1];
      expect(darkKnight.id, 'the-dark-knight');
      expect(darkKnight.title, 'The Dark Knight (2008)');
      expect(darkKnight.ticketPrice, 8.50);
      expect(darkKnight.posterImagePath, isNotEmpty);

      final Movie jaws = movies[2];
      expect(jaws.id, 'jaws');
      expect(jaws.title, 'Jaws (1975)');
      expect(jaws.ticketPrice, 8.50);
      expect(jaws.posterImagePath, isNotEmpty);
    });

    test('getMovieById returns matching movie when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie =
          repository.getMovieById('black-panther-wakanda-forever');

      expect(movie, isNotNull);
      expect(movie?.title, 'Black Panther: Wakanda Forever (2022)');
      expect(movie?.ticketPrice, 8.50);
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}
