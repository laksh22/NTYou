import 'package:flutter/material.dart';
import 'root_page.dart';
import 'package:tech_fest_app/auth/auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Osmosis',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightBlue[700],
        accentColor: Colors.lightBlue[700],
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        buttonTheme: new ButtonThemeData(
          buttonColor: Colors.lightBlue[700],
        )
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}