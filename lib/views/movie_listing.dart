import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: cinemaBrand),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.title,
              key: const Key('movie-listing-title'),
              style: const TextStyle(
                color: cinemaFontWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.movie.synopsis,
              style: const TextStyle(color: cinemaFontWhite),
            ),
            const SizedBox(height: 32),
            Container(
              color: cinemaSurface,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Southsea Cinema Room',
                    style: TextStyle(color: cinemaFontWhite),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.movie.screeningTime,
                    style: const TextStyle(color: cinemaFontWhite),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          children: [
                            Text(
                              'Runtime: ${widget.movie.runtime}',
                              style: const TextStyle(color: cinemaFontMuted),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Age rating: ${widget.movie.ageRating}',
                              style: const TextStyle(color: cinemaFontMuted),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Runtime: ${widget.movie.runtime}',
                            style: const TextStyle(color: cinemaFontMuted),
                          ),
                          Text(
                            'Age rating: ${widget.movie.ageRating}',
                            style: const TextStyle(color: cinemaFontMuted),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Select Quantities (Up to 5 in total)',
                    style: TextStyle(color: cinemaFontMuted),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tickets',
                    style: TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      DropdownMenu<int>(
                        initialSelection: _ticketQuantity,
                        onSelected: (int? value) {
                          if (value != null) {
                            setState(() {
                              _ticketQuantity = value;
                            });
                          }
                        },
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: 1, label: '1'),
                          DropdownMenuEntry(value: 2, label: '2'),
                          DropdownMenuEntry(value: 3, label: '3'),
                          DropdownMenuEntry(value: 4, label: '4'),
                          DropdownMenuEntry(value: 5, label: '5'),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Adult (${widget.movie.formattedPrice})',
                        style: const TextStyle(color: cinemaFontWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _feedbackMessage =
                        '$_ticketQuantity ticket(s) added to your order.';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: cinemaBackground,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Add to order'),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                _feedbackMessage,
                key: const Key('booking-feedback'),
                style: const TextStyle(color: cinemaFontWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
