import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';

class DeleteEvent extends StatefulWidget {
    Map<String, dynamic> event;
    BuildContext rootCtx,rrootCtx;
    DeleteEvent(this.event,this.rootCtx,this.rrootCtx);

  @override
  State<DeleteEvent> createState() => _DeleteEvent(this.event,this.rootCtx,this.rrootCtx);
}

class _DeleteEvent extends State<DeleteEvent> {
    Map<String, dynamic> event;
    BuildContext rootCtx,rrootCtx;

    _DeleteEvent(this.event, this.rootCtx, this.rrootCtx);

    void deleteEvent(){
        var url = "http://127.0.0.1/mycal/delete_event.php";
        http.post(Uri.parse(url),body: {
        "id": event['event_id'],
        });
    }

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: const Text('Delete this event?'),
            actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context, 'No'),
                    child: const Text('No'),
                ),
                TextButton(
                    onPressed: () {
                        deleteEvent();
                        Navigator.pop(context);
                        Navigator.pop(rootCtx);
                        Navigator.pop(rrootCtx);
                    },
                    child: const Text('Yes'),
                ),
            ],
        );
    }
}
