import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.movie.title,
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Image.asset(
                widget.movie.posterImagePath,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 12),

              Text(
                widget.movie.synopsis,
                style: TextStyle(
                  color: cinemaFontWhite,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                color: cinemaSurface,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Southsea Cinema Room',
                      style: TextStyle(
                        color: cinemaFontWhite,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      widget.movie.screeningTime,
                      style: TextStyle(
                        color: cinemaFontWhite,
                      ),
                    ),

                    const SizedBox(height: 12),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return Row(
                            children: [
                              Text(
                                'Runtime: ${widget.movie.runtime}',
                                style: TextStyle(color: cinemaFontMuted),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Age rating: ${widget.movie.ageRating}',
                                style: TextStyle(color: cinemaFontMuted),
                              ),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Runtime: ${widget.movie.runtime}',
                              style: TextStyle(color: cinemaFontMuted),
                            ),
                            Text(
                              'Age rating: ${widget.movie.ageRating}',
                              style: TextStyle(color: cinemaFontMuted),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 18),

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
                          'Adult (£${widget.movie.ticketPrice.toStringAsFixed(2)})',
                          style: TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _feedbackMessage =
                        '$_ticketQuantity ticket(s) added to your order.';
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: cinemaFontWhite,
                ),
                child: const Text('Add to order'),
              ),

              const SizedBox(height: 12),

              Text(
                _feedbackMessage,
                style: const TextStyle(color: cinemaFontWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}