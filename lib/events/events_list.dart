import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:tech_fest_app/events/event_card.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class EventsList extends StatefulWidget{
  @override
  _EventsListState createState() => _EventsListState();
  EventsList({this.auth});
  final BaseAuth auth;
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
            child: new StreamBuilder(
              stream: Firestore.instance.collection("events_data").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData) return CircularProgressIndicator();
                  return FirestoreListView(documents: snapshot.data.documents);
                })
          ),
        )
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index){

          String eventName = documents[index].data["name"].toString();
          String   eventHolder = documents[index].data["holder"].toString();
          String  eventDate = documents[index].data["date"].toString();
          String  eventDescription = documents[index].data["description"].toString();
          String   eventImage = documents[index].data["image"].toString();
          String   eventPrice = documents[index].data["price"].toString();
          String   eventLocation = documents[index].data["location"].toString();
          String eventCreator = documents[index].data["creator"].toString();

          return Container(
            child :new EventsCard(
              eventName: eventName,
              eventDate: eventDate,
              eventHolder: eventHolder,
              eventDescription: eventDescription,
              eventImage: eventImage,
              eventPrice: eventPrice,
              eventLocation: eventLocation,
              eventCreator: eventCreator,
            ),
          );

        }
    );
  }
}


