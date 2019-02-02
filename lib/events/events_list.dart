import 'package:flutter/material.dart';
import 'package:tech_fest_app/events/event_card.dart';

class EventsList extends StatefulWidget{
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList>{

  List<Widget> _events = [
    new EventsCard(
      eventName: "TGIFHacks",
    eventDate: "19/2/19",
    eventHolder: "NTUOSS",
    eventDescription: "This is an event that will be held in NTU by us so pls atted yay",
      eventImage: "http://fiscalsystems.wpengine.com/wp-content/uploads/2013/10/EVENTS.png",
      eventPrice: "FREE",
      eventLocation: "LT2A",
    ),
    new EventsCard(
      eventName: "TGIFHacks",
      eventDate: "19/2/19",
      eventHolder: "NTUOSS",
      eventDescription: "This is an event that will be held in NTU by us so pls atted yay",
      eventImage: "http://fiscalsystems.wpengine.com/wp-content/uploads/2013/10/EVENTS.png",
      eventPrice: "FREE",
      eventLocation: "LT2A",
    ),
    new EventsCard(
      eventName: "TGIFHacks",
      eventDate: "19/2/19",
      eventHolder: "NTUOSS",
      eventDescription: "This is an event that will be held in NTU by us so pls atted yay",
      eventImage: "http://fiscalsystems.wpengine.com/wp-content/uploads/2013/10/EVENTS.png",
      eventPrice: "FREE",
      eventLocation: "LT2A",
    ),

  ];

  //TODO: Add search filters

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          appBar: new AppBar(title: new Text("Events"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: null,
                  child: new Text('Add Event', style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              )
            ],
          ),
          body: new Center(
            child: new ListView.builder(
              itemCount: _events.length,
                itemBuilder: (BuildContext context, int index){

                   return Container(child: _events[index]);

                }
            ),
          ),
        )
    );
  }
}