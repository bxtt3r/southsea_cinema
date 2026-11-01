import 'package:southsea_cinema/models/movie.dart';
class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'black-panther-wakanda-forever',
        title: 'Black Panther: Wakanda Forever (2022)',
        synopsis: 'Following the death of King T\'Challa, Queen Ramonda, Shuri, '
          'M\'Baku, Okoye and the Dora Milaje fight to protect the nation of Wakanda ' 
          'from intervening world powers. As the Wakandans struggle to protect their ' 
          'home, they must also face a new threat from the underwater kingdom of '
          'Talokan and its ruler, Namor.',
          ageRating: '12A',
          runtime: '2h 41m',
          screeningTime: 'Friday 2 Oct 2026, 18:00',
          posterImagePath: 'assets/images/black_panther_wakanda_forever.jpg',
          ticketPrice: 8.50,
      ),

      Movie(
        id: 'the-dark-knight',
        title: 'The Dark Knight (2008)',
        synopsis: 'Christopher Nolan\'s The Dark Knight (2008) continues the '
          'story from Batman Begins, with Gotham City seeing progress in its '
          'fight against crime thanks to the combined efforts of Batman, '
          'James Gordon, and newly elected District Attorney Harvey Dent. '
          'Their alliance threatens the mob\'s power, prompting crime bosses '
          'to turn to a mysterious and sadistic criminal mastermind known as the Joker.',
          ageRating: '12A',
          runtime: '2h 32m',
          screeningTime: 'Friday 2 Oct 2026, 21:00',
          posterImagePath: 'assets/images/the_dark_knight.jpeg',
          ticketPrice: 8.50,
      ),
    ];
  }
}