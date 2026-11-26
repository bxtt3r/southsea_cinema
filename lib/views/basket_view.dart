import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  String _feedbackMessage = '';

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          'Your basket is empty',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLineItem(BasketItem item, int index) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.movie.posterImagePath,
              width: 60,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.movie.title.toUpperCase(),
                    style: const TextStyle(
                      color: cinemaBrand,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.movie.screeningTime,
                    style: const TextStyle(color: cinemaFontWhite),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.quantity} x Standard · Southsea Cinema Room',
                    style: const TextStyle(color: cinemaFontMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '£${item.lineTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.delete),
                  style: IconButton.styleFrom(
                    backgroundColor: cinemaBrand,
                    foregroundColor: cinemaFontWhite,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      BasketRepository.instance.removeItem(index);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = const TextStyle(
        color: cinemaFontWhite,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      );
    } else {
      style = const TextStyle(color: cinemaFontWhite);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _buildBasketList(BasketRepository repository, List<BasketItem> items) {
    final List<Widget> children = [];

    children.add(const Text('MY ORDER', style: cinemaHeaderStyle));
    children.add(const SizedBox(height: 16));

    for (int index = 0; index < items.length; index++) {
      children.add(_buildLineItem(items[index], index));
    }

    children.add(const SizedBox(height: 16));
    children.add(
      _buildTotalRow(
        'Service Charge',
        '£${repository.getServiceFee().toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Total Due',
        '£${repository.getTotalDue().toStringAsFixed(2)}',
        emphasise: true,
      ),
    );
    children.add(const SizedBox(height: 24));

    children.add(
      SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          label: 'BUY TICKETS',
          onPressed: () {
            setState(() {
              repository.clear();
              _feedbackMessage = 'Thanks, your tickets are booked';
            });
          },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketRepository repository = BasketRepository.instance;
    final List<BasketItem> basketItems = repository.getItems();

    final Widget content;
    if (basketItems.isEmpty) {
      if (_feedbackMessage.isNotEmpty) {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmptyState(),
            const SizedBox(height: 12),
            Center(
              child: Text(
                _feedbackMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        content = _buildEmptyState();
      }
    } else {
      content = _buildBasketList(repository, basketItems);
    } 
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}