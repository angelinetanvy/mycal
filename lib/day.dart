import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DayPage extends StatefulWidget {
    final DateTime thisDate;
    const DayPage(this.thisDate);

  @override
  State<DayPage> createState() => _DayPage(thisDate);
}

class _DayPage extends State<DayPage> {
    late DateTime thisDate;
    String titleCont = "",detailCont="",locationCont="";
    String startCont = "Select Start Time";
    String endCont = "Select End Time";

    _DayPage(this.thisDate);

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

    Widget separator = Container(
        padding:const EdgeInsets.only(bottom:20),
        child:Divider(color: Colors.black),
    );

    Widget eventList = Container(
        height:300,
        width:300,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
                children:[
                    GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                            margin: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width:280,
                            height:50,
                            child:Card(
                                color:Colors.grey[500],
                                child:Text("test",textAlign: TextAlign.left,style: TextStyle(color: Colors.white)),
                            )
                        ),
                    ),
                ]
            )
        )
    );

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: Text(DateFormat.MMMMEEEEd().format(thisDate)),
            content: Column(
                children:[
                    separator,
                    eventList
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
                    },
                    child: const Text('Add'),
                ),
            ],
        );
    }
}
