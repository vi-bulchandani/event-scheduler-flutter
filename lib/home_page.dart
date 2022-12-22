import 'package:event_scheduler/create_event.dart';
import 'package:event_scheduler/event.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  var db = Hive.box<MyEvent?>('events list');

  List<MyEvent> _eventList = [];

  List<MyEvent> _GetDataFromStorage() {
    int i = 0;
    List<MyEvent> l = [];
    while (db.get(i) != null) {
      l.add(db.get(i)!);
      i++;
    }
    return l;
  }

  void _StoreDateIntoStorage() {
    for (int i = 0; i < _eventList.length; i++) {
      db.put(i, _eventList[i]);
    }
    db.put(_eventList.length, null);
    db.flush();
  }

  _MyHomePageState() {
    _eventList = _GetDataFromStorage();
    print('retrieved');
  }
  //void _incrementCounter() {}

  Widget _RightSlideBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _LeftSlideBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

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
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_eventList[index].toString()),
            background: _RightSlideBackground(),
            secondaryBackground: _LeftSlideBackground(),
            child: InkWell(
              child: _eventList[index].toWidget(context),
            ),
            onDismissed: (direction) => {
              setState(() {
                _eventList.removeAt(index);
                _StoreDateIntoStorage();
              })
            },
          );
        },
        itemCount: _eventList.length,
        separatorBuilder: (context, index) => SizedBox(height: 30),
        padding: EdgeInsets.all(40),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          MyEvent? e = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateEventScreen(title: "Create Event")));

          if (e != null)
            setState(() {
              _eventList.add(e);

              _StoreDateIntoStorage();
            });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
