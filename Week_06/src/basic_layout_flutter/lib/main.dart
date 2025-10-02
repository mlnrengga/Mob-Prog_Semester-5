import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    // Bagian Judul (titleSection)
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.red,
          ),
          const Text('41'),
        ],
      ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    // Bagian Tombol (buttonSection)
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    // Bagian Teks (textSection)
    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Oeschinen Lake Campground adalah danau yang terletak di atas Kandersteg '
        'di Bernese Oberland, Swiss. Danau ini dapat dicapai dari Kandersteg '
        'dengan gondola atau dengan berjalan kaki. Sebuah rute kabel gondola '
        'membentang dari Kandersteg ke Oeschinen, tempat danau itu berada. '
        'Aktivitas seperti berperahu dan kereta luncur musim panas dimungkinkan '
        'selama musim panas dan memancing di danau dimungkinkan selama bulan '
        'musim dingin jika danau membeku.',
        softWrap: true,
      ),
    );

    // Menggabungkan semua widget ke dalam struktur aplikasi utama.
    return MaterialApp(
      title: 'Flutter layout: Maulana Rengga Ramadan | 2341720160',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            // Penggunaan Stack untuk melapisi teks di atas gambar.
            Stack(
              children: [
                // Gambar sebagai lapisan paling bawah
                Image.asset(
                  'images/Lake.jpg',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                // Teks yang diletakkan di atas gambar
                const Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    'Danau Oeschinen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: titleSection,
            ),
            const Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Nama | NIM'),
                subtitle: Text('Maulana Rengga Ramadan | 2341720160'),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: Column(
                children: [
                  buttonSection,
                  textSection,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}