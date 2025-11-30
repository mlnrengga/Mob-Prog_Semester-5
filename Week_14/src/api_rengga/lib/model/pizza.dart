const String keyId = 'id';
const String keyName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImage = 'imageUrl';
// 1. Tambahkan Key Baru
const String keyTopping = 'topping';

class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;
  // 2. Tambahkan Properti Baru
  final String topping;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
    // 3. Tambahkan ke Constructor (default value agar aman)
    this.topping = '',
  });

  Pizza.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json[keyId].toString()) ?? 0,
        pizzaName = json[keyName] != null ? json[keyName].toString() : 'No name',
        description = json[keyDescription] != null ? json[keyDescription].toString() : 'No description',
        price = double.tryParse(json[keyPrice].toString()) ?? 0.0,
        imageUrl = json[keyImage] != null ? json[keyImage].toString() : '',
        // 4. Ambil data topping dari JSON
        topping = json[keyTopping] != null ? json[keyTopping].toString() : 'No topping';

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
      // 5. Masukkan data topping ke JSON saat dikirim (POST)
      keyTopping: topping,
    };
  }
}