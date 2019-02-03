import 'package:flutter/material.dart';
import 'root_page.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tech_fest_app/todolistv2/data_provider.dart';
import 'package:tech_fest_app/todolistv2/model.dart';
import 'package:tech_fest_app/todolistv2/projects_screen.dart';
import 'package:redux/redux.dart';

final store = Store<CategoryState>(stateReducer,
    initialState: CategoryState([
      Category(0, Icons.person, Colors.blue, "CZ1007 - Data Structures", [
        Task(0, "Sumbit week 3 lams", false),
           Task(0, "Sumbit assignment 1 before 9 Feb", false),
      ]),
      Category(1, Icons.content_paste, Colors.orange, "Work", [])
    ]));

void main() => runApp(FlutterReduxApp(store: store));

 class FlutterReduxApp extends StatelessWidget {
   final Store<CategoryState> store;
   const FlutterReduxApp({Key key, this.store}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return StoreProvider<CategoryState>(
       child: MaterialApp(
         title: 'Tech Fest',
         theme: ThemeData(
             primarySwatch: Colors.blue,
             primaryColor: Colors.lightBlue[700],
        accentColor: Colors.lightBlue[700],
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        buttonTheme: new ButtonThemeData(
          buttonColor: Colors.lightBlue[700],
        ),),
         home: new RootPage(auth: new Auth()),
       ),
       store: store,
     );
   }
 }

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Tech Fest',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//        primaryColor: Colors.lightBlue[700],
//        accentColor: Colors.lightBlue[700],
//        scaffoldBackgroundColor: Color(0xFFF5F5F5),
//        buttonTheme: new ButtonThemeData(
//          buttonColor: Colors.lightBlue[700],
//        )
//      ),
//      home: new RootPage(auth: new Auth()),
//    );
//  }
//}