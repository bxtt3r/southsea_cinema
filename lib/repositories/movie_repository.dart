import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'wakanda-forever',
        title: 'Black Panther: Wakanda Forever (2022)',
        synopsis:
            "Following the death of King T'Challa, the people of Wakanda must protect their home from outside powers and a new threat from the underwater kingdom of Talokan.",
        ageRating: '12A',
        runtime: '161 minutes',
        screeningTime: 'Saturday 17 October 2026, 18:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/black_panther.png',
      ),
      Movie(
        id: 'the-batman',
        title: 'The Batman (2022)',
        synopsis:
            'Batman investigates corruption in Gotham City while pursuing a mysterious killer known as the Riddler.',
        ageRating: '15',
        runtime: '176 minutes',
        screeningTime: 'Sunday 18 October 2026, 20:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/the_batman.png',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }
}
