import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    // langsung kembalikan warna saat tombol ditekan
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Purple'),
              onPressed: () {
                Navigator.pop(context, Colors.purple.shade700);
              },
            ),
            ElevatedButton(
              child: const Text('Cream'),
              onPressed: () {
                Navigator.pop(context, const Color(0xFFFFFDD0)); // cream
              },
            ),
            ElevatedButton(
              child: const Text('Orange'),
              onPressed: () {
                Navigator.pop(context, Colors.orange.shade700);
              },
            ),
          ],
        ),
      ),
    );
  }
}