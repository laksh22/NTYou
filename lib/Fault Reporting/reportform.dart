import 'package:flutter/material.dart';
import 'pageone.dart';
import 'pagetwo.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ReportForm extends StatefulWidget{
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm>{

  List<Widget> myPages = [PageOne(), PageTwo()];
  //TODO: Add search filters

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
            appBar: new AppBar(title: new Text("Events")
            ),
            body: PageView.builder(
              itemBuilder: (context, position)=>myPages[position],
              itemCount: myPages.length,
            )
        )
    );
  }
}
