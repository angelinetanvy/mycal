import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'new_event.dart';
import 'event.dart';

class DayPage extends StatefulWidget {
    final DateTime thisDate;
    const DayPage(this.thisDate);

  @override
  State<DayPage> createState() => _DayPage(thisDate);
}

class _DayPage extends State<DayPage> {
    late DateTime thisDate;
    List events = [];
    List<Widget> cards = [];

    _DayPage(this.thisDate);

    @override
    void initState(){
        super.initState();
        getAndCreate();
    }

    void getAndCreate() async{
        var ev = getEvents();
        var newEvs = await ev;

        newEvs.sort((m1, m2) {
            return m1["event_start"].compareTo(m2["event_start"]);
        });

        setState((){
            events = newEvs;
            createCards();
        });
    }

    void createCards(){
        setState((){
            cards = [];
            for (var e in events){
                cards.add(eventCard(e));
            }
        });
    }

    Future<List> getEvents() async{
        events = [];
        var formatter = new DateFormat('yyyy-MM-dd');
        String curDate = formatter.format(thisDate);
        final params = {
            "date": curDate,
        };
        
        final uri = Uri.https("127.0.0.1","/mycal/get_events.php", params);
        try {
            final res = await http.get(uri);  
            // print(jsonDecode(res.body.substring(10)));
            events =  jsonDecode(res.body.substring(10));
            return events;
        } catch (e) {
            print(e);
            return [];
        }  

    }

    Widget separator = Container(
        padding:const EdgeInsets.only(bottom:20),
        child:Divider(color: Colors.black),
    );

    Widget titleHeader = Text("Events",textAlign: TextAlign.center,style: TextStyle(color: Colors.black));

    Widget eventCard(Map<String, dynamic> e) {
        var timeStamp = DateFormat.jm().format(DateTime.parse(e['event_start']));
        return GestureDetector(
            onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => EventPage(e,context),
                );
            },
            child: Container(
                margin: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                width:280,
                height:50,
                child:Card(
                    color:Colors.grey[300],
                    child:Row(
                        children:[
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left:15,right:15),
                                    child: Text(e['event_title'],textAlign: TextAlign.left,style: TextStyle(color: Colors.black)),
                                ),
                            ),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left:15,right:15),
                                    child: Text(timeStamp.toString(),textAlign: TextAlign.right,style: TextStyle(color: Colors.black)),
                                ),
                            ),
                        ]
                    )
                )
            ),
        );
    }

    Widget eventList() {
        return Container(
            height:550,
            width:300,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children:cards
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: Text(DateFormat.MMMMEEEEd().format(thisDate)),
            content: Column(
                children:[
                    separator,
                    titleHeader,
                    eventList()
                ],                    
            ),
            actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Close'),
                ),
                TextButton(
                    onPressed: () {
                        Navigator.pop(context, 'OK');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => NewEventPage(),
                        );
                    },
                    child: const Text('Add'),
                ),
            ],
        );
    }
}
