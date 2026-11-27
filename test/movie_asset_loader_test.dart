import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loadMoviesFromAsset reads every film from the bundled JSON', () async {
    final MovieRepository repository = MovieRepository();
    final List<Movie> movies = await repository.loadMoviesFromAsset();

    expect(movies.length, 3);
    expect(movies[0].id, 'black-panther-wakanda-forever');
    expect(movies[0].ticketPrice, 8.50);
    expect(movies[1].id, 'the-dark-knight');
    expect(movies[2].id, 'jaws');
    expect(repository.getMovies(), movies);
  });
}
