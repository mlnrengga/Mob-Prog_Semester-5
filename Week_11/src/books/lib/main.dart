import 'dart:async';
import 'package:http/http.dart'; // Catatan: Import tidak diperlukan
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import untuk package http
import 'package:async/async.dart';
// import 'geolocation.dart';
// import 'navigation_first.dart';
import 'navigation_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo - Rengga',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NavigationDialogScreen(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  bool isLoading = false;
  late Completer completer;

  void returnFG() {
    // nyalakan loading sebelum operasi async
    setState(() {
      isLoading = true;
      result = '';
    });

    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);

    futures.then((List<int> values) {
      final total = values.fold<int>(0, (p, e) => p + e);
      setState(() {
        result = total.toString();
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        result = 'Error: $e';
        isLoading = false;
      });
    });
  }

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  // Future calculate() async {
  //   await Future.delayed(const Duration(seconds : 5));
  //   completer.complete(42);
  // }
  // Ganti method calculate() di dalam class _FuturePageState

  Future calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    if (result.contains('42')) {
      completer.complete(42);
    } else {
      completer.completeError('Completer Error');
    }
  }

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/gXS6CgAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future<int> count() async {
    int total = 0;

    total = total + await returnOneAsync();
    total = total + await returnTwoAsync();
    total = total + await returnThreeAsync();
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A Clash of Kings')),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                // nyalakan loading
                setState(() {
                  isLoading = true;
                  result = '';
                });

                returnError()
                    .then((value) {
                      setState(() {
                        result = 'Success';
                      });
                    })
                    .catchError((onError) {
                      setState(() {
                        result = onError.toString();
                      });
                    })
                    .whenComplete(() {
                      setState(() {
                        isLoading = false;
                      });
                      print('Complete');
                    });
              },
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            if (isLoading) const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
