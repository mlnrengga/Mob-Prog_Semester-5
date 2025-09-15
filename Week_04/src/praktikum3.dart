void main() {
  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 1
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 2,
  };
  print(gifts);
  print(nobleGases);

  var mhs1 = Map<String, String>();
  gifts['Nama'] = 'Maulana Rengga Ramadan';
  gifts['NIM'] = '2341720160';

  var mhs2 = Map<int, String>();
  nobleGases[99] = 'Maulana Rengga Ramadan';
  nobleGases[100] = '2341720160';

  mhs1['Nama'] = 'Maulana Rengga Ramadan';
  mhs1['NIM'] = '2341720160';

  mhs2[101] = 'Nama: Maulana Rengga Ramadan';
  mhs2[102] = 'NIM: 2341720160';

  print(gifts);
  print(nobleGases);
  print(mhs1);
  print(mhs2);
}