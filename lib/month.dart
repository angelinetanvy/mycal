import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'new_event.dart';
import 'package:intl/intl.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({super.key});

  @override
  State<MonthPage> createState() => _MonthPage();
}

class _MonthPage extends State<MonthPage> {
    DateTime currDate = DateTime.now();

    void nextMonth() {
        var daysMonth = DateTime(currDate.year, currDate.month + 1, 0).day - currDate.day + 1;
        setState((){ currDate = currDate.add(Duration(days:daysMonth));});
    }

    void previousMonth() {
        var daysMonth = DateTime(currDate.year, currDate.month, 0).day + currDate.day - 1;
        setState((){currDate = currDate.subtract(Duration(days:daysMonth));});
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

  Widget titleSection() {
    final DateFormat formatter = DateFormat('yMMMM');
    var newDate = formatter.format(currDate);
    return Container(
        color:Colors.grey[900],
        height: 170,
        padding: const EdgeInsets.only(left:35,right:35,bottom:10),
        child: Column(
            children:[
                Container(
                    height:100
                ),
                Container(
                    child:
                        Row(
                            children:[
                                Expanded(
                                    child: Text(newDate,style: TextStyle(fontSize: 25, color:Colors.white),)
                                ),
                                IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    onPressed: (){ previousMonth();}
                                ),
                                IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    color: Colors.white,
                                    onPressed: (){ nextMonth();}
                                ),
                            ]
                        )
                )
            ]
        )
    );
  }

  Widget grid = SizedBox(
    height:300,
    child:ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('One-line ListTile'))),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),

      ],
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            children:[
                titleSection(),
                grid
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
