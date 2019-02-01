import 'package:flutter/material.dart';
import 'package:tech_fest_app/common/primary_button.dart';

class EventsCard extends StatefulWidget {
  @override
  _EventsCardState createState() => _EventsCardState();
  String eventName;
  EventsCard({this.eventName});
}

class _EventsCardState extends State<EventsCard> {



  //TODO: Make fields as props
  //TODO: Solve text field overflow problem
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
          child: new Column(
        children: <Widget>[
          Image.network(
            "https://cdn.vox-cdn.com/thumbor/GMaMT9KjmKYzSsV4qylbE3aSHgM=/0x0:1720x1160/1200x800/filters:focal(723x443:997x717)/cdn.vox-cdn.com/uploads/chorus_image/image/51234963/Events-Hero.0.jpg",
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
                    "18/2/19",
                    style: new TextStyle(fontSize: 22.0, color: Colors.red[600]),
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
                              "NTUOSS",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(fontSize: 18.0, color: Colors.black54),
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
                              child: new Text("More", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0 / 2))),
                              color: Colors.blue,
                              textColor: Colors.black87,
                              onPressed: (){print("pressed");}),
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
                  "This will be a small description of the thing so that people know what will happen",
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: new TextStyle(fontSize: 18.0, color: Colors.black),
                )),
          )
        ],
      )),
    );
  }
}
