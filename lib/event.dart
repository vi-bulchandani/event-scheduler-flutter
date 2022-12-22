//import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class MyEvent {
  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  String desc;
  MyEvent(this.desc, this.date);
  MyEvent.eventWithoutDate(this.desc) {
    this.date = DateTime.now();
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${date!.toString()} - ${desc}';
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
