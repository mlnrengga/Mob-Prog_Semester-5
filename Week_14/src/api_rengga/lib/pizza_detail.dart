import 'package:flutter/material.dart';
import 'model/pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  // Langkah 5: Tambahkan properti pizza dan isNew di Constructor
  final Pizza pizza;
  final bool isNew;

  const PizzaDetailScreen({
    super.key, 
    required this.pizza, 
    required this.isNew
  });

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  final TextEditingController txtTopping = TextEditingController(); 
  
  String operationResult = '';

  // Langkah 6: Override initState untuk mengisi form jika mode Edit
  @override
  void initState() {
    if (!widget.isNew) {
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName;
      txtDescription.text = widget.pizza.description;
      txtPrice.text = widget.pizza.price.toString();
      txtImageUrl.text = widget.pizza.imageUrl;
      txtTopping.text = widget.pizza.topping;
    }
    super.initState();
  }

  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    txtTopping.dispose(); 
    super.dispose();
  }

  // Langkah 7: Ganti nama method jadi savePizza dan tambahkan logika PUT/POST
  Future savePizza() async {
    HttpHelper helper = HttpHelper();
    
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0,
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ?? 0.0,
      imageUrl: txtImageUrl.text,
      topping: txtTopping.text,
    );

    // Logika: Jika baru POST, jika lama PUT
    final result = await (widget.isNew
        ? helper.postPizza(pizza)
        : helper.putPizza(pizza));

    setState(() {
      operationResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Langkah 10 & 11: UI Form
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Detail - Rengga'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                operationResult,
                style: TextStyle(
                  backgroundColor: Colors.green[200],
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(hintText: 'Insert ID'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtName,
                decoration: const InputDecoration(hintText: 'Insert Pizza Name'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtDescription,
                decoration: const InputDecoration(hintText: 'Insert Description'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtPrice,
                decoration: const InputDecoration(hintText: 'Insert Price'),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(hintText: 'Insert Image Url'),
              ),
              // 3. Tambahkan Input Field Topping di UI
              const SizedBox(height: 24),
              TextField(
                controller: txtTopping,
                decoration: const InputDecoration(hintText: 'Insert Topping'),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                child: const Text('Save Pizza'), // Ubah teks tombol
                onPressed: () {
                  savePizza(); // Panggil method savePizza
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}