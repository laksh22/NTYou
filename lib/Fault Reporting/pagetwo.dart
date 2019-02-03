import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_fest_app/Fault%20Reporting/pagethree.dart';

class PageTwo extends StatefulWidget {
  @override
  PageTwoState createState() => PageTwoState();
  final String yourname, number, issue;
  PageTwo({this.yourname, this.number, this.issue});
}

class Hall {
  const Hall(this.name);

  final String name;
}

class PageTwoState extends State<PageTwo> {



  final formKey = GlobalKey<FormState>();

  Hall selectedHall;
  List<Hall> halls = <Hall>[const Hall('Binjai Hall'), const Hall('Tamarind Hall'), const Hall('Hall 13'), const Hall('Hall 1')];

  int groupValue;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text("Fault Reporting"),),
      body: Center(
        child: Form(
          key: this.formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text("Is this issue hall-related?", style: new TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center, ),
                ),
                new Row(children: [new Radio(value: 1, groupValue: groupValue, onChanged: (int e) => trigger(e), activeColor: Colors.green,), new Text("Yes"),]),
                new Row(children: [new Radio(value: 2, groupValue: groupValue, onChanged: (int e) => trigger(e), activeColor: Colors.red,), new Text("No"),]),

                Column(
                  children: <Widget>[
                    new Opacity(
                      opacity: _visible ? 1.0 : 0.0,
                      child: Column(
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(bottom: 32.0, top: 32.0),
                          child: Text("Which hall are you located in?", style: new TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center, ),
                        ),
              new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.home),
                          labelText: 'Halls',
                        ),
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<Hall>(
                            hint: new Text("Select a Hall"),
                            value: selectedHall,
                            onChanged: (Hall newValue) {
                              setState(() {
                                selectedHall = newValue;
                              });
                            },
                            items: halls.map((Hall hall) {
                              return new DropdownMenuItem<Hall>(
                                value: hall,
                                child: new Text(
                                  hall.name,
                                  style: new TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
              ),
                      ]
                      )
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(onPressed: next, child: Text("Next"),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void next(){
    formKey.currentState.save();
    if(selectedHall == null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageThree(yourname: widget.yourname, number: widget.number, issue: widget.issue, hallName: "None")),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageThree(yourname: widget.yourname, number: widget.number, issue: widget.issue, hallName: selectedHall.name)),
      );
    }

  }
  void trigger (int e){
    setState(() {
      if (e==1){
        groupValue = 1;
        _visible = true;
      } else if (e==2){
        groupValue = 2;
        _visible = false;
      }
    });
  }
}