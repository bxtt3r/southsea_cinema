import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
            ],
          ),
        ));
  }
}
