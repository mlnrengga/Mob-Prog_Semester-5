import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io'; 
import 'package:flutter/services.dart';
import 'model/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Path Provider - Rengga'),
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
  List<Pizza> myPizzas = [];
  
  String documentsPath = '';
  String tempPath = '';
  late File myFile;
  String fileText = '';

  final pwdController = TextEditingController();
  String myPass = '';

  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';

  Future<List<Pizza>> readJsonFile() async {
    try {
      String myString = await rootBundle.loadString('assets/pizzalist.json');
      List pizzaMapList = jsonDecode(myString);
      
      setState(() {
        myPizzas = [];
        for (var pizza in pizzaMapList) {
          Pizza myPizza = Pizza.fromJson(pizza);
          myPizzas.add(myPizza);
        }
      });
      return myPizzas;
    } catch (e) {
      print('Error loading JSON: $e');
      return [];
    }
  }

  Future getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString('Rengga - 2341720160'); 
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String> readFromSecureStorage() async {
    String secret = await storage.read(key: myKey) ?? '';
    return secret;
  }

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
    
    getPaths().then((_) {
      myFile = File('$documentsPath/pizzas.txt');
      writeFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: pwdController,
                decoration: const InputDecoration(labelText: 'Enter Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Save Value'),
                onPressed: () {
                  writeToSecureStorage();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Read Value'),
                onPressed: () {
                  readFromSecureStorage().then((value) {
                    setState(() {
                      myPass = value;
                    });
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                myPass,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}