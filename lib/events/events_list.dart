import 'package:flutter/material.dart';
import 'package:tech_fest_app/events/event_card.dart';

class EventsList extends StatefulWidget{
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList>{

  List<Widget> _events = [
    new EventsCard(eventName: "TGIFHacks",),
    new EventsCard(eventName: "HackOSS",),
    new EventsCard(eventName: "Speaker Sharing",),
  ];

  //TODO: Add search filters

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          appBar: new AppBar(title: new Text("Events")
          ),
          body: new Center(
            child: new ListView.builder(
              itemCount: _events.length,
                itemBuilder: (BuildContext context, int index){
                  return new Container(
                    child: _events[index]
                  );
                }
            ),
          )
        )
    );
  }
}