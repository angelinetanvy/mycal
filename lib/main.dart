import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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

  void updateEvent(){
    var url = "http://127.0.0.1/mycal/update_event.php";
    http.post(Uri.parse(url),body: {
      "id": "2222222222222222",
      "title": "go to gym",
      "start": "1974-03-20 12:00:00",
      "end": "2022-03-20 12:00:00",
      "location": "gym",
      "detail": "2 hours",
    });
  }

  void deleteEvent(){
    var url = "http://127.0.0.1/mycal/delete_event.php";
    http.post(Uri.parse(url),body: {
      "id": "2222222222222222",
    });
  }

  Future<List> getEvent() async{
    final params = {
      "id": "2222222222222222",
    };
    final uri = Uri.https("127.0.0.1","/mycal/get_event.php", params);

    try {
      final res = await http.get(uri);  
      // print(jsonDecode(res.body.substring(16)));
      return jsonDecode(res.body.substring(16));
    } catch (e) {
      print(e);
      return [];
    }  
    
  }

  Future<List> getEvents() async{
    final params = {
      "date": "1974-03-20",
    };
    
    final uri = Uri.https("127.0.0.1","/mycal/get_events.php", params);
    try {
        final res = await http.get(uri);  
        print(jsonDecode(res.body.substring(10)));
        return jsonDecode(res.body.substring(10));
    } catch (e) {
      print(e);
      return [];
    }  

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
        onPressed: () => getEvents(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
