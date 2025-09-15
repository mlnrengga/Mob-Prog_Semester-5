void main() {
  // var record = ('first', a: 2, b: true, 'last');
  // print(record);

  // var angka = (10, 20);
  // print("Sebelum ditukar: $angka");

  // var hasil = tukar(angka);
  // print("Sesudah ditukar: $hasil");
  // Record type annotation in a variable declaration:
  // (String, int) mahasiswa = ('Maulana', 2341720160);
  // print(mahasiswa);
  var mahasiswa2 = ('Maulana Rengga Ramadan', a: 2341720160, b: true, 'last');

  print(mahasiswa2.$1); // Prints 'first'
  print(mahasiswa2.a); // Prints 2
  print(mahasiswa2.b); // Prints true
  print(mahasiswa2.$2); // Prints 'last'
}

// (int, int) tukar((int, int) record) {
//   var (a, b) = record;
//   return (b, a);
// }