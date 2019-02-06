import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_fest_app/Fault%20Reporting/pagetwo.dart';

class PageOne extends StatefulWidget {
  @override
  PageOneState createState() => PageOneState();
}

class Issue {
  Issue(this.name);

  String name = "Other";
}


class PageOneState extends State<PageOne> {
  Issue selectedIssue;
  List<Issue> issues = <Issue>[ Issue('Lost and Found'),  Issue('Cleanliness'),  Issue('IT Problems'),  Issue('Miscellaneous')];

  final formKey = GlobalKey<FormState>();
  String yourname;
  String number;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(title: new Text("Fault Reporting"),),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: this.formKey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(bottom: 32.0),
                    child: Text("Please fill in your personal details", style: new TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center, ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    validator: (val) => val.isEmpty ? 'Name can\'t be empty.' : null,
                    onSaved: (val) => yourname = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    validator: (val) => val.isEmpty ? 'Phone number can\'t be empty.' : null,
                    onSaved: (val) => number = val,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new Padding(padding: const EdgeInsets.only(bottom: 32.0, top: 32.0),
                    child: Text("What type of issue do you want to report?", style: new TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center, ),
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.help),
                          labelText: 'Issues',
                        ),
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<Issue>(
                            hint: new Text("Select an issue"),
                            value: selectedIssue,
                            onChanged: (Issue newValue) {
                              setState(() {
                                selectedIssue = newValue;
                              });
                            },
                            items: issues.map((Issue user) {
                              return new DropdownMenuItem<Issue>(
                                value: user,
                                child: new Text(
                                  user.name,
                                  style: new TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(onPressed: next, child: Text("Next", style: new TextStyle(color: Colors.white)),shape: new RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0 / 2))),),
                      )
                    ],
                  )],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void next() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(yourname);
      print(number);
      if(selectedIssue == null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              PageTwo(
                yourname: yourname, number: number, issue: "Other",)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              PageTwo(
                yourname: yourname,
                number: number,
                issue: selectedIssue.name,)),
        );
      }

    }
  }
}
