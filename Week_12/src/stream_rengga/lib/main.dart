import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Soal 1: Tambahkan nama panggilan dan ganti tema
      title: 'Stream App - Rengga', 
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, 
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  int lastNumber = 0;
  late StreamController<int> numberStreamController;
  late Stream<int> numberStream;
  late NumberStream _numberStream;
  late StreamSubscription subscription;
  late StreamSubscription subscription2;
  String values = '';

  @override
  void initState() {
    _numberStream = NumberStream();
    numberStreamController = _numberStream.controller;
    numberStream = numberStreamController.stream.asBroadcastStream();

    subscription = numberStream.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });

    subscription2 = numberStream.listen((event) {
      setState(() {
        values += '$event - ';
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    subscription2.cancel();
    numberStreamController.close();
    super.dispose();
  }

  void stopStream() {
    numberStreamController.close();
  }

  void addRandomNumber() {
    final random = Random();
    final myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      _numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream - Rengga')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(values),
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: const Text('New Random Number'),
            ),
            ElevatedButton(
              onPressed: () => stopStream(),
              child: const Text('Stop Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}