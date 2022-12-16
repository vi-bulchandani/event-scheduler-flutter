import 'package:event_scheduler/event.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key, required this.title});
  final String title;
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _controller = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2012),
        lastDate: DateTime(2200));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitEvent(BuildContext context) {
    if (_controller.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                "Please enter Event Description",
              ),
              actions: [
                MaterialButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else {
      MyEvent e = MyEvent(_controller.text.trim(), _selectedDate);
      Navigator.pop(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[100],
      appBar: AppBar(title: Text("New Event")),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.deepPurpleAccent,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent[700],
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: EdgeInsets.all(20),
              child: Row(children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red)
                      ))),
                  onPressed: () => _selectDate(context),
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.deepPurpleAccent[700],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  _selectedDate.toLocal().toString().split(" ")[0],
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _controller,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                contentPadding: EdgeInsets.all(20),
                hintText: "eg. Sam's Birthday Party",
                labelText: "Event Description",
                fillColor: Colors.deepPurpleAccent[700],
                icon: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurpleAccent[700]!),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              cursorColor: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Text(
                "ADD EVENT",
                style: TextStyle(
                    fontSize: 20, color: Colors.white.withOpacity(0.8)),
              ),
              style: TextButton.styleFrom(
                  padding: (EdgeInsets.all(30)),
                  backgroundColor: (Colors.white.withOpacity(0.2)),
                  minimumSize: (Size.fromHeight(60)),
                  shape: StadiumBorder()),
              //foregroundColor: ,

              onPressed: () => {_submitEvent(context)},
            )
          ],
        ),
      ),
    );
  }
}
