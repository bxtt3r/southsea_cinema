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
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        child: Column(
          children: [
            const Text('Black Panther: Wakanda Forever'),
            const Text(
              "The nation of Wakanda fights to protect its people from intervening world powers in the wake of King T'Challa's death.",
            ),
            Row(
              children: [
                const Text('Runtime: 161 minutes'),
                const SizedBox(width: 16),
                const Text('Age rating: 12A'),
              ],
            ),
            DropdownMenu<int>(
              initialSelection: 1,
              onSelected: (int? value) {
                if (value != null) {
                  setState(() {
                    _ticketQuantity = value;
                  });
                }
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 1, label: '1'),
                DropdownMenuEntry(value: 2, label: '2'),
                DropdownMenuEntry(value: 3, label: '3'),
                DropdownMenuEntry(value: 4, label: '4'),
                DropdownMenuEntry(value: 5, label: '5'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _feedbackMessage =
                      '$_ticketQuantity ticket(s) added to your order.';
                });
              },
              child: const Text('Add to order'),
            ),

            Text(_feedbackMessage),
          ],
        ),
      ),
    );
  }
}
