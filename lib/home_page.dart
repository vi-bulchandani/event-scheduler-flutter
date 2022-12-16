import 'package:event_scheduler/create_event.dart';
import 'package:event_scheduler/event.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyEvent> _event_list = [
    // MyEvent("Event1", DateTime.now()),
    // MyEvent("Event2", DateTime.now()),
    // MyEvent("Event3", DateTime.now()),
  ];

  //void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _event_list[index].toWidget(context),
        itemCount: _event_list.length,
        separatorBuilder: (context, index) => SizedBox(height: 30),
        padding: EdgeInsets.all(40),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          MyEvent e = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateEventScreen(title: "Create Event")));

          setState(() {
            _event_list.add(e);
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
