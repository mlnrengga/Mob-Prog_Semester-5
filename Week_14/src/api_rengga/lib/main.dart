import 'package:flutter/material.dart';
import 'httphelper.dart';
import 'model/pizza.dart';
// Langkah 13: Import pizza_detail
import 'pizza_detail.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pizza JSON API - Rengga'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // Langkah 8: Method callPizzas
  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Langkah 9: FutureBuilder untuk menampilkan data
      body: FutureBuilder(
        future: callPizzas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data == null) ? 0 : snapshot.data!.length,
            itemBuilder: (BuildContext context, int position) {
              // Langkah 5: Refactor menggunakan Dismissible
              return Dismissible(
                key: Key(snapshot.data![position].id.toString()),
                onDismissed: (item) {
                  HttpHelper helper = HttpHelper();
                  // Panggil API delete
                  helper.deletePizza(snapshot.data![position].id);
                  // Hapus item dari list lokal agar UI update tanpa refresh
                  snapshot.data!.removeAt(position);
                  // Opsional: Tampilkan snackbar konfirmasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pizza deleted')),
                  );
                },
                background: Container(color: Colors.red), // Warna latar saat digeser
                child: ListTile(
                  title: Text(snapshot.data![position].pizzaName),
                  subtitle: Text(
                    '${snapshot.data![position].description} - € ${snapshot.data![position].price}'
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetailScreen(
                          pizza: snapshot.data![position],
                          isNew: false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      // Langkah 9: Update FloatingActionButton untuk Tambah Baru (isNew: true)
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PizzaDetailScreen(
                // Kirim objek Pizza kosong untuk data baru
                pizza: Pizza(
                  id: 0, 
                  pizzaName: '', 
                  description: '', 
                  price: 0, 
                  imageUrl: '', 
                  topping: ''
                ),
                isNew: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
