//import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class MyEvent {
  DateTime? date;
  String desc;
  MyEvent(this.desc, this.date);
  MyEvent.eventWithoutDate(this.desc) {
    this.date = DateTime.now();
  }

  Widget toWidget(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      leading: Icon(
        Icons.event,
        color: Colors.deepPurpleAccent,
      ),
      title: Text(desc),
      subtitle: Text(date!.toLocal().toString().split(" ")[0]),
      tileColor: Colors.white,
      dense: false,
    );
  }
}
