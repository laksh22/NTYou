import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    'Chicken Rice',
    'Chinese Cuisine',
    'Western Food',
    'Indian Food'
    'Korean',
    'Japanese',
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new DragAndDropList<String>(
        items,
        itemBuilder: (BuildContext context, item) {
          return new SizedBox(
            child: new Card(
              child: new ListTile(
                title: new Text(item),
              ),
            ),
          );
        },
        onDragFinish: (before, after) {
          String data = items[before];
          items.removeAt(before);
          items.insert(after, data);
        },
        canBeDraggedTo: (one, two) => true,
        dragElevation: 8.0,
      ),
    );
  }
}