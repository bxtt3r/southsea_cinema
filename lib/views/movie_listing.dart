import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Black Panther: Wakanda Forever (2022)',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12), //sized box for spacing

            const Text(
              "Following the death of King T'Challa, Queen Ramonda, Shuri, M'Baku, Okoye and the Dora Milaje fight to protect the nation of Wakanda from intervening world powers. As the Wakandans struggle to protect their home, they must also face a new threat from the underwater kingdom of Talokan and its ruler, Namor.",
              style: TextStyle(
                color: cinemaFontWhite,
              ),
            ),

            const SizedBox(height: 50),

            Container(
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

                  const Text(
                    'Friday 2 Oct 2026, 18:00',
                    style: TextStyle(
                      color: cinemaFontWhite,
                    ),
                  ),

                  const SizedBox(height: 12), //sized box for spacing

                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          children: [
                            const Text(
                              'Runtime: 161 minutes',
                              style: TextStyle(color: cinemaFontMuted),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Age rating: 12A',
                              style: TextStyle(color: cinemaFontMuted),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Runtime: 161 minutes',
                            style: TextStyle(color: cinemaFontMuted),
                          ),
                          const Text(
                            'Age rating: 12A',
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

                      const Text(
                        'Adult (£7.50)',
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
    );
  }
}