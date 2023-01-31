import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'delete_event.dart';

class EventPage extends StatefulWidget {
    Map<String, dynamic> event;
    BuildContext rootCtx;

    EventPage(this.event, this.rootCtx);

  @override
  State<EventPage> createState() => _EventPage(this.event, this.rootCtx);
}

class _EventPage extends State<EventPage> {
    Map<String, dynamic> event;
    BuildContext rootCtx;
    String titleCont = "",detailCont="",locationCont="";
    String startCont = "";
    String endCont = "Select End Time";
    bool editing = false;

    final TextEditingController titleController = new TextEditingController();
    final TextEditingController detailController = new TextEditingController();
    final TextEditingController locationController = new TextEditingController();

    _EventPage(this.event, this.rootCtx);

    @override
    void initState() {
        titleController.text = event['event_title'];
        detailController.text = event['event_detail'];
        locationController.text = event['event_location'];
        startCont = event['event_start'];
        endCont = event['event_end'];
        return super.initState();
    }

    void updateEvent(){
        var url = "http://127.0.0.1/mycal/update_event.php";
        http.post(Uri.parse(url),body: {
            "id": event['event_id'],
            "title": titleCont == ""? titleController.text : titleCont,
            "start": startCont,
            "end": endCont,
            "location": locationCont == ""? locationController.text : locationCont,
            "detail": detailCont == ""? detailController.text : detailCont,
        });
    }

    Future<List> getEvent() async{
        final params = {
            "id": event['event_id'],
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

    Widget separator = Container(
        padding:const EdgeInsets.only(bottom:20),
        child:Divider(color: Colors.black),
    );

    Widget titleField(){
        return SizedBox(
            width:300,
            height:80,
            child:TextField(   
                decoration: InputDecoration(  
                    border: OutlineInputBorder(),  
                    labelText: 'Event Title',  
                    hintText: 'Enter Title',  
                    isDense:true,
                ),
                onChanged: (title) {
                    setState((){titleCont = title;});
                },
                controller:titleController,
                enabled:editing
            )  
        );
    }

    Widget detailField() {
        return SizedBox(
            width:300,
            height:160,
            child:TextField(  
                maxLines:5,
                decoration: InputDecoration(  
                    border: OutlineInputBorder(),  
                    labelText: 'Event Detail',  
                    hintText: 'Enter Detail',  
                    isDense:true,
                ),
                onChanged: (title) {
                    setState((){detailCont = title;});
                },
                controller:detailController,
                enabled:editing
            )  
        );
    }

    Widget locationField() {
        return SizedBox(
            width:300,
            height:80,
            child:TextField(  
                decoration: InputDecoration(  
                    border: OutlineInputBorder(),  
                    labelText: 'Event Location',  
                    hintText: 'Enter Location',  
                    isDense:true,
                ),
                onChanged: (title) {
                    setState((){locationCont = title;});
                },
                controller:locationController,
                enabled:editing
            )  
        );
    }

    Widget startText = Container(
        padding: const EdgeInsets.only(bottom:5),
        child: const Align(
            alignment: Alignment.topLeft,
            child: Text("Event Start Time"),
        ),
    );

    Widget endText = Container(
        padding: const EdgeInsets.only(top:15,bottom:5),
        child: const Align(
            alignment: Alignment.topLeft,
            child: Text("Event End Time"),
        ),
    );

    Widget startField(BuildContext context) {
        return 
        TextButton(
            onPressed: () {
                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    onChanged: (date) {}, 
                                    onConfirm: (date) {
                                        setState((){startCont = date.toString().substring(0,19);});
                                    }, 
                                    currentTime: DateTime.now(), 
                                    locale: LocaleType.en);
            },
            child: Text(
                "$startCont",
                style: TextStyle(color: Colors.grey[800]),
        ));
    }

    Widget endField(BuildContext context) {
        return 
        TextButton(
            onPressed: () {
                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    onChanged: (date) {}, 
                                    onConfirm: (date) {
                                        setState((){endCont = date.toString().substring(0,19);});
                                    },
                                    currentTime: DateTime.now(), 
                                    locale: LocaleType.en);
            },
            child: Text(
                "$endCont",
                style: TextStyle(color: Colors.grey[800]),
        ));
    }

    List<Widget> botButtons() {
        if (editing){
            return [                
                TextButton(
                    onPressed: () {
                        setState((){editing = false;});
                        Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () {
                        updateEvent();
                        Navigator.pop(context);
                        Navigator.pop(rootCtx);
                    },
                    child: const Text('OK'),
                ),];
        } else {
            return [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => DeleteEvent(event,context,rootCtx),
                        );
                    },
                    child: const Text('Delete'),
                ),
                TextButton(
                    onPressed: () {
                        setState((){editing = true;});
                    },
                    child: const Text('Edit'),
                ),
            ];
        }
    }

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: const Text('Event'),
            content: Column(
                children:[
                    separator,
                    titleField(),
                    detailField(),
                    locationField(),
                    startText,
                    startField(context),
                    endText,
                    endField(context),
                ],                    
            ),
            actions: botButtons()
        );
    }
}