import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
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
        return new AlertDialog(
            title: const Text('Popup example'),
            content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text("Hello"),
            ],
            ),
        );
    }
}
