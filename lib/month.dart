import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'new_event.dart';
import 'day.dart';
import 'package:intl/intl.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({super.key});

  @override
  State<MonthPage> createState() => _MonthPage();
}

class _MonthPage extends State<MonthPage> {
    DateTime currDate = DateTime.now();
    List<Widget> tiles = [];

    @override
    void initState(){
        super.initState();
        createTiles();
    }

    void createTiles(){
        setState((){
            tiles = [];
            DateTime thisMonth =  currDate.subtract(Duration(days:currDate.day));
            for (var i=1;i<=DateTime(currDate.year, currDate.month + 1, 0).day;i++){
                thisMonth = thisMonth.add(Duration(days:1));
                tiles.add(tile(i,thisMonth));
            }
        });
    }

    void nextMonth() {
        var daysMonth = DateTime(currDate.year, currDate.month + 1, 0).day - currDate.day + 1;
        setState((){currDate = currDate.add(Duration(days:daysMonth));});
        createTiles();
    }

    void previousMonth() {
        var daysMonth = DateTime(currDate.year, currDate.month, 0).day + currDate.day - 1;
        setState((){currDate = currDate.subtract(Duration(days:daysMonth));});
        createTiles();
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

    Widget tile(int no, DateTime date) {
        var formatter = new DateFormat('yyyy-MM-dd');
        String tileDate = formatter.format(date);
        String curDate = formatter.format(DateTime.now());
        return GestureDetector(
            onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => DayPage(date),
                );
            },
            child: Container(
                    width:55,
                    height:80,
                    child:Card(
                    color: tileDate == curDate? Colors.white:Colors.grey[700],
                    child:Text(no.toString()),
                )
            ),
        );
    } 

  Widget row(List<Widget> rowTiles) {
    return Container(
        height:80,
        child:Row(
            children:rowTiles
        )
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            children:[
                titleSection(),
                Column(
                    children:[
                        row(tiles.sublist(0,7)),
                        row(tiles.sublist(7,14)),
                        row(tiles.sublist(14,21)),
                        row(tiles.sublist(21,28)),
                        row(tiles.sublist(28))
                    ]
                )
            ]
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF343A40),
            onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => NewEventPage(),
                );
            },
            child: const Icon(Icons.add, color:Colors.white),
        ),
    );
  }
}
