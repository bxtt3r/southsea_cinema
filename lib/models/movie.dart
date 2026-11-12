class Movie {
  final String id;
  final String title;
  final String synopsis;
  final String ageRating;
  final String runtime;
  final String screeningTime;
  final String posterImagePath;
  final double ticketPrice;

  const Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.runtime,
    required this.screeningTime,
    required this.posterImagePath,
    required this.ticketPrice,
  });

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}dffffcfvfv';
}