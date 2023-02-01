import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  String titleCont = "", detailCont = "", locationCont = "";
  String startCont = "Select Start Time";
  String endCont = "Select End Time";

  var uuid = Uuid();

  void createEvent(
      String title, String start, String end, String location, String detail) {
    var url = "http://127.0.0.1/mycal/create_event.php";
    http.post(Uri.parse(url), body: {
      "id": uuid.v1(),
      "title": title,
      "start": start,
      "end": end,
      "location": location,
      "detail": detail,
    });
  }

  Widget separator = Container(
    padding: const EdgeInsets.only(bottom: 20),
    child: Divider(color: Colors.black),
  );

  Widget titleField() {
    return SizedBox(
        width: 300,
        height: 80,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Event Title',
            hintText: 'Enter Title',
            isDense: true,
          ),
          onChanged: (title) {
            setState(() {
              titleCont = title;
            });
          },
        ));
  }

  Widget detailField() {
    return SizedBox(
        width: 300,
        height: 160,
        child: TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Event Detail',
            hintText: 'Enter Detail',
            isDense: true,
          ),
          onChanged: (title) {
            setState(() {
              detailCont = title;
            });
          },
        ));
  }

  Widget locationField() {
    return SizedBox(
        width: 300,
        height: 80,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Event Location',
            hintText: 'Enter Location',
            isDense: true,
          ),
          onChanged: (title) {
            setState(() {
              locationCont = title;
            });
          },
        ));
  }

  Widget startText = Container(
    padding: const EdgeInsets.only(bottom: 5),
    child: const Align(
      alignment: Alignment.topLeft,
      child: Text("Event Start Time"),
    ),
  );

  Widget endText = Container(
    padding: const EdgeInsets.only(top: 15, bottom: 5),
    child: const Align(
      alignment: Alignment.topLeft,
      child: Text("Event End Time"),
    ),
  );

  Widget startField(BuildContext context) {
    return TextButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
            setState(() {
              startCont = date.toString().substring(0, 19);
            });
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Text(
          "$startCont",
          style: TextStyle(color: Colors.grey[800]),
        ));
  }

  Widget endField(BuildContext context) {
    return TextButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
            setState(() {
              endCont = date.toString().substring(0, 19);
            });
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Text(
          "$endCont",
          style: TextStyle(color: Colors.grey[800]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Add Event'),
      content: Column(
        children: [
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
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            createEvent(
                titleCont, startCont, endCont, detailCont, locationCont);
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
