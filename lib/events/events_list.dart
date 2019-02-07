import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:tech_fest_app/events/add_event.dart';
import 'package:tech_fest_app/events/event_card.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:tech_fest_app/events/event_card_delete.dart';

class EventsList extends StatefulWidget{
  @override
  _EventsListState createState() => _EventsListState();
  EventsList({this.auth, this.userId, this.email});
  final BaseAuth auth;
  final String userId, email;
}

class _EventsListState extends State<EventsList>{

  //TODO: Add search filters

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          appBar: new AppBar(title: new Text("Events"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEvent(auth: widget.auth,)),
                  );
                },
                child: new Text('Add Event', style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              )
            ],
          ),
          body: new Center(
              child: new StreamBuilder(
                  stream: Firestore.instance.collection("events_data").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) return CircularProgressIndicator();
                    return FirestoreListView(documents: snapshot.data.documents, auth: widget.auth, userId: widget.userId, email: widget.email,);
                  })
          ),
        )
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final BaseAuth auth;
  final String userId, email;
  FirestoreListView({this.documents, this.auth, this.userId, this.email});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index){

          void _deleteEvent(int i) {
            Firestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
              await transaction.get(documents[i].reference);
              await transaction.delete(snapshot.reference);
            });
            Navigator.pop(context);
          }

          String eventName = documents[index].data["name"].toString();
          String   eventHolder = documents[index].data["holder"].toString();
          String  eventDate = documents[index].data["date"].toString();
          String  eventDescription = documents[index].data["description"].toString();
          String   eventImage = documents[index].data["image"].toString();
          String   eventPrice = documents[index].data["price"].toString();
          String   eventLocation = documents[index].data["location"].toString();
          String eventCreator = documents[index].data["creator"].toString();
          String eventTime = documents[index].data["time"].toString();
          String eventLink = documents[index].data["link"].toString();

          if(eventCreator == userId){
            return Container(
              child :new EventsCardDelete(
                eventName: eventName,
                eventDate: eventDate,
                eventHolder: eventHolder,
                eventDescription: eventDescription,
                eventImage: eventImage,
                eventPrice: eventPrice,
                eventLocation: eventLocation,
                eventCreator: eventCreator,
                deleteFunc: _deleteEvent,
                index: index,
                eventTime: eventTime,
                eventLink: eventLink,
                email: email
              ),
            );
          } else {
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
                eventTime: eventTime,
                  eventLink: eventLink,
                email: email
              ),
            );
          }
        }
    );
  }
}


