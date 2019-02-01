import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';

class Home extends StatelessWidget {
  Home({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
            )
          ],
        ),
        body: new Center(
          child: new Text(
            'Welcome',
            style: new TextStyle(fontSize: 32.0),
          ),
        )
    );
  }
}