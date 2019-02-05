import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import "package:mailer/mailer.dart";
import 'package:mailer/smtp_server.dart';
import 'package:tech_fest_app/auth/auth_details.dart';
import 'package:tech_fest_app/home.dart';
import 'dart:io';
import 'globals.dart' as globals;
import 'success.dart';


class PageThree extends StatefulWidget {
  @override
  PageThreeState createState() => PageThreeState();
  final String yourname, hallName, number, issue;
  PageThree({this.yourname, this.hallName, this.number, this.issue});
}

class PageThreeState extends State<PageThree> {


  final formKey = GlobalKey<FormState>();

  static AuthDetails authDetails = new AuthDetails();

  static String email = authDetails.getReportingEmail();

  BuildContext context;
  String _platformMessage = 'No Error';
  List images;
  int maxImageNo = 10;
  bool selectSingleImage = false;
  String description;
  bool _visible = false;

  @override
  initState() {
    super.initState();
  }

  static String password = 'intuition2018';
  static String username = "blinkceptionntu@gmail.com";

  final smtpServer = gmail(username, password);

  void _sendReminder() async {
    final message = new Message()
      ..from = new Address("blinkceptionntu@gmail.com", 'Blinkception')
      ..recipients.add(email)
      ..subject = 'NEW ERROR REPORT: ${new DateTime.now()}'
      ..text = 'This is an automated error message:'
      ..html = "<h1>Name</h1>\n<p>${widget.yourname}</p>\n<h1>Contact:</h1>\n<p>${widget.number}</p>\n<h1>Description:</h1>\n<p>${description}</p>\n<h1>Hall:</h1>\n<p>${widget.hallName == null ? "None" : widget.hallName}</p>\n";

    final sendReports = await send(message, smtpServer);
    print(email);
    print(sendReports.toString());
  }

  initMultiPickUp() async {
    setState(() {
      images = null;
      _platformMessage = 'No Error';
    });
    List resultList;
    String error;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(
          maxImageNo, selectSingleImage);
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _platformMessage = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: new AppBar(title: new Text("Fault Reporting"),),
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Form(
                key: this.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("Please describe the issue in prompt", style: new TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center, ),
                      ),
                  new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300.0,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: new TextFormField(
                          maxLines: null,
                          validator: (val) => val.isEmpty ? 'Description can\'t be empty.' : null,
                          onSaved: (val) => description = val,
                        ),
                      ),
                    ),
                      ),
                    ],
                  ),
                ),
              ),
              images == null
                  ? new Container(
                height: 300.0,
                width: 400.0,
                child: new Icon(
                  Icons.image,
                  size: 250.0,
                  color: Theme.of(context).primaryColor,
                ),
              )
                  : new SizedBox(
                height: 300.0,
                width: 400.0,
                child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) =>
                  new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Image.file(
                      new File(images[index].toString()),
                    ),
                  ),
                  itemCount: images.length,
                ),
              ),
              new RaisedButton.icon(
                  onPressed: initMultiPickUp,
                  icon: new Icon(Icons.image),
                  label: new Text("Pick-Up Images")
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(onPressed: submit, child: Text("Submit"),),
                  )
                ],
              ),
              new Opacity(opacity: _visible ? 1.0 : 0.0,
                child: Padding(padding: const EdgeInsets.only(bottom: 32.0, top: 32.0),
                  child: Text("Success!", style: new TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center, ),
                ),
              )
            ],
          ),
        ),
      );
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(description);
      _sendReminder();
      this.setState((){_visible=true;});

    }
  }
}