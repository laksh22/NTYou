import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsCardDelete extends StatefulWidget {
  @override
  _EventsCardDeleteState createState() => _EventsCardDeleteState();
  String eventName,
      eventHolder,
      eventDate,
      eventDescription,
      eventImage,
      eventPrice,
      eventLocation,
      eventCreator;
  Function deleteFunc;
  int index;
  EventsCardDelete({
    this.eventName,
    this.eventHolder,
    this.eventDate,
    this.eventDescription,
    this.eventImage,
    this.eventPrice,
    this.eventLocation,
    this.eventCreator,
    this.deleteFunc,
    this.index
  });
}

class _EventsCardDeleteState extends State<EventsCardDelete> {

  void _showDeleteDialog() {
    showDialog(
        context: context,
        child: new AlertDialog(
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Are you sure?",
                  style: new TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: new Align(
                    alignment: Alignment.center,
                    child: new RaisedButton(
                        child: new Text("Delete",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 20.0)),
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0 / 2))),
                        color: Colors.red,
                        textColor: Colors.black87,
                        onPressed: () {
                          widget.deleteFunc(widget.index);
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _showDialog() {
    showDialog(
        context: context,
        child: new AlertDialog(
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  widget.eventName,
                  style:
                  new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.date_range),
                    new Text(widget.eventDate)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.location_on),
                    new Text(widget.eventLocation)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.attach_money),
                    new Text(widget.eventPrice)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  widget.eventDescription,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: new TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: new Align(
                    alignment: Alignment.center,
                    child: new RaisedButton(
                        child: new Text("Register",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 20.0)),
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0 / 2))),
                        color: Colors.blue,
                        textColor: Colors.black87,
                        onPressed: () {
                          null;
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Solve text field overflow problem
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
          child: Stack(children: <Widget>[

        new Column(
          children: <Widget>[
            Image.network(
              widget.eventImage,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: new Text(
                      widget.eventDate,
                      style:
                          new TextStyle(fontSize: 22.0, color: Colors.red[600]),
                    )),
                  ),
                  new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: new Text(
                        widget.eventName,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(fontSize: 20.0),
                      ))),
                      Flexible(
                          child: Container(
                              child: new Text(
                        widget.eventHolder,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            fontSize: 18.0, color: Colors.black54),
                      )))
                    ],
                  ),
                  new Expanded(
                    child: Container(
                      child: new Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: new RaisedButton(
                              child: new Text("More",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0 / 2))),
                              color: Colors.blue,
                              textColor: Colors.black87,
                              onPressed: _showDialog),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
                  child: new Text(
                widget.eventDescription,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: new TextStyle(fontSize: 18.0, color: Colors.black),
              )),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new RaisedButton(
              child: new Text("Delete",
                  style: new TextStyle(
                      color: Colors.white, fontSize: 20.0)),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0 / 2))),
              color: Colors.red,
              textColor: Colors.black87,
              onPressed: _showDeleteDialog),
        ),
      ])),
    );
  }
}
