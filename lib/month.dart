import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'new_event.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({super.key});

  @override
  State<MonthPage> createState() => _MonthPage();
}

class _MonthPage extends State<MonthPage> {

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

  Widget titleSection = Container(
    color:Colors.grey[900],
    height: 170,
    padding: const EdgeInsets.all(35),
    child: Column(
        children:[
            Container(
                height:70
            ),
            Container(
                child:
                    Row(
                        children:[
                            Expanded(
                                child: Text("January 2023",style: TextStyle(fontSize: 25, color:Colors.white),)
                            ),
                            Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                            ),
                            Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                            ),
                        ]
                    )
            )
        ]
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            children:[
                titleSection,
            ]
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => NewEventPage(),
                );
            },
            child: const Icon(Icons.add, color:Color(0xFF343A40)),
        ),
    );
  }
}
