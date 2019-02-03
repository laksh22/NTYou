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
      Category(0, Icons.person, Colors.blue, "Personal", [
        Task(0, "Task", false),
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
         title: 'Flutter Demo',
         theme: ThemeData(
             primarySwatch: Colors.blue,
             textTheme: TextTheme(
               body1: TextStyle(color: Colors.white, fontSize: 28.0),
               body2: TextStyle(color: Colors.white54, fontSize: 14.0),
               display1: TextStyle(color: Colors.black87, fontSize: 36.0),
               caption: TextStyle(
                   color: Colors.white,
                   fontSize: 12.0,
                   fontWeight: FontWeight.bold),
               subhead: TextStyle(color: Colors.black54, fontSize: 12.0),
             )),
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