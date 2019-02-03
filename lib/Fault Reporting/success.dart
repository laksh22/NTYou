import 'package:flutter/material.dart';

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Success!',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Success!'),
        ),
        body: Container(
          color: Colors.green,
          child: Text("Success!")
        ),
      ),
    );
  }
}