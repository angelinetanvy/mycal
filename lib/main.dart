import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  var uuid = Uuid();

  void createEvent(){
    var url = "http://127.0.0.1/mycal/create_event.php";
    http.post(Uri.parse(url),body: {
      "id": "2222222222222222",
      "title": "go to sleep",
      "start": "1974-03-20 12:00:00",
      "end": "2022-03-20 12:00:00",
      "location": "bedroom",
      "detail": "8 hours",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createEvent(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
