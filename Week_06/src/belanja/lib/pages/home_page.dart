import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';
import 'package:belanja/widgets/item_card.dart';

class HomePage extends StatelessWidget {
  final List<Item> items = [
    Item(name: 'Sugar', price: 5000, photo: 'images/sugar.jpg', stock: 50, rating: 4.5),
    Item(name: 'Salt', price: 2000, photo: 'images/salt.jpg', stock: 100, rating: 4.8),
    Item(name: 'Flour', price: 10000, photo: 'images/flour.png', stock: 75, rating: 4.2),
    Item(name: 'Oil', price: 18000, photo: 'images/oil.avif', stock: 30, rating: 4.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Belanja'),
        backgroundColor: Colors.brown[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return ItemCard(item: items[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Maulana Rengga Ramadan | 2341720160',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}