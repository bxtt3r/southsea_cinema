import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onBook;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.only(bottom: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                movie.posterImagePath,
                width: 96,
                height: 144,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 96,
                    height: 144,
                    color: cinemaBackground,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.movie,
                      color: cinemaBrand,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${movie.ageRating} • ${movie.runtime}',
                    style: const TextStyle(color: cinemaFontMuted),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.synopsis,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: cinemaFontWhite),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.screeningTime,
                    style: const TextStyle(color: cinemaFontMuted),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie.formattedPrice,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cinemaBrand,
                      foregroundColor: cinemaBackground,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('BOOK NOW'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
