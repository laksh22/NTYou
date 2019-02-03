import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:tech_fest_app/events/event_card.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
  AddEvent({this.auth});
  final BaseAuth auth;
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  String name, holder, date, price, location, image, description, time, link;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      String creator = await widget.auth.currentUser();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference =
            Firestore.instance.collection("events_data");

        await reference.add({
          "creator": creator,
          "date": date,
          "description": description,
          "holder": holder,
          "image": image,
          "location": location,
          "name": name,
          "price": price,
          "time": time,
          "link": link
        });
      });
      Navigator.pop(context);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
            resizeToAvoidBottomPadding: true,
            appBar: new AppBar(
              title: new Text("Add Event"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('name'),
                          decoration: InputDecoration(
                            hintText: 'Event Name',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) => val.isEmpty
                              ? 'Event name can\'t be empty.'
                              : null,
                          onSaved: (val) => name = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('holder'),
                          decoration: InputDecoration(
                            hintText: 'Organiser',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) => val.isEmpty
                              ? 'Organiser name can\'t be empty.'
                              : null,
                          onSaved: (val) => holder = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('date'),
                          decoration: InputDecoration(
                            hintText: 'Date',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) =>
                              val.isEmpty ? 'Date can\'t be empty.' : null,
                          onSaved: (val) => date = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('time'),
                          decoration: InputDecoration(
                            hintText: 'Time',
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) =>
                          val.isEmpty ? 'Time can\'t be empty.' : null,
                          onSaved: (val) => time = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('price'),
                          decoration: InputDecoration(
                            hintText: 'Price',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) =>
                              val.isEmpty ? 'Price can\'t be empty.' : null,
                          onSaved: (val) => price = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('location'),
                          decoration: InputDecoration(
                            hintText: 'Location',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) =>
                              val.isEmpty ? 'Location can\'t be empty.' : null,
                          onSaved: (val) => location = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('image'),
                          decoration: InputDecoration(
                            hintText: 'Image address',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) => val.isEmpty
                              ? 'Image address can\'t be empty.'
                              : null,
                          onSaved: (val) => image = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: new Key('link'),
                          decoration: InputDecoration(
                            hintText: 'Registration Link',
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) => val.isEmpty
                              ? 'Registration address can\'t be empty.'
                              : null,
                          onSaved: (val) => link = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 5,
                          key: new Key('description'),
                          decoration: InputDecoration(
                            hintText: 'Description',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          autocorrect: false,
                          validator: (val) => val.isEmpty
                              ? 'Description can\'t be empty.'
                              : null,
                          onSaved: (val) => description = val,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: new RaisedButton(
                              child: new Text("Submit",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0 / 2))),
                              color: Colors.blue,
                              textColor: Colors.black87,
                              onPressed: validateAndSubmit),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
