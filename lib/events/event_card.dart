import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import "package:tech_fest_app/auth/auth_details.dart";

class EventsCard extends StatefulWidget {
  @override
  _EventsCardState createState() => _EventsCardState();
  String eventName,
      eventHolder,
      eventDate,
      eventDescription,
      eventImage,
      eventPrice,
      eventLocation,
  eventCreator,
  eventTime,
  eventLink,
  email;
  EventsCard(
      {this.eventName,
      this.eventHolder,
      this.eventDate,
      this.eventDescription,
      this.eventImage,
      this.eventPrice,
      this.eventLocation,
      this.eventCreator,
      this.eventTime,
      this.eventLink,
      this.email});
}

class _EventsCardState extends State<EventsCard> {

  static AuthDetails authDetails = new AuthDetails();
  static String password = authDetails.getSenderPassword();
  static String username = authDetails.getSenderEmail();
  final smtpServer = gmail(username, password);

  _launchURL() async {
    String url = widget.eventLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.access_time),
                    new Text(widget.eventTime)
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
                          _launchURL();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _sendReminder() async {
    final message = new Message()
      ..from = new Address("blinkceptionntu@gmail.com", 'Blinkception')
      ..recipients.add(widget.email)
      ..subject = 'Reminder for your upcoming event: ${new DateTime.now()}'
      ..text = 'This is an automated message for you:'
      ..html = "<h1>Event Name</h1>\n<p>${widget.eventName}</p>\n<h1>Event Date</h1>\n<p>${widget.eventDate}</p>\n<h1>Event Time</h1>\n<p>${widget.eventTime}</p>\n<h1>Event Location</h1>\n<p>${widget.eventLocation}</p>\n";

    sendDelayedEmail(message);
  }

  Future<void> sendDelayedEmail(message) async {
    return new Future.delayed(const Duration(days: 1), () async {
      final sendReports = await send(message, smtpServer);
    } );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Solve text field overflow problem
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
          child: Stack(
            children: <Widget>[
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
                    Column(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                              child: new Text(
                                widget.eventTime,
                                style:
                                new TextStyle(fontSize: 15.0, color: Colors.black87),
                              )),
                        ),
                      ],
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
                          style:
                              new TextStyle(fontSize: 18.0, color: Colors.black54),
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
                padding: const EdgeInsets.only(top: 8.0),
                child: new Align(
                  alignment: Alignment.topRight,
                  child: new RaisedButton(child: new Icon(Icons.notifications, color: Colors.white,),
                      onPressed: _sendReminder,
                  shape: CircleBorder(),),),
              )
              
            ],
          )),
    );
  }
}
