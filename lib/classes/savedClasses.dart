import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(new MyClassApp());
}
class MyClassApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NTYou!',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MySavedHomePage(),
    );
  }
}

class MySavedHomePage extends StatefulWidget { //https://stackoverflow.com/questions/45970979/flutter-appbar-backbutton-doesnt-appear - how i solved back button not appearing
  var savedItems;
  MySavedHomePage({Key key, @required this.savedItems}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MySavedHomePage> {
  var dayDict={'MON':'Monday','TUE':'Tuesday','WED':'Wednesday','THU':'Thursday','FRI':'Friday','SAT':'Saturday','SUN':'Sunday'};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SavedLectures'),

      ),
      backgroundColor: Color(0xFFF5F5F5),
      body:
      new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
                child:new Container(
                  child: new Center(
                    // Use future builder and DefaultAssetBundle to load the local JSON file
                    child: new FutureBuilder(
                        future: DefaultAssetBundle.of(context).loadString('data_repo/structuredDataV2.json'),//http.get("https://www.jasonbase.com/things/jYBa/")
                        builder: (context, snapshot) {
                          // Decode the JSON
                          var new_data =  json.decode(snapshot.data.toString());
                          return new ListView.builder(
                            // Build the ListView
                            itemBuilder: (BuildContext context, int index) {
                              // r1<= _sliderValue && _sliderValue<=r2
                              // print(_sliderValue);
                              if (widget.savedItems.contains(index) && (new_data[index]['day'].length==1)){
                                return new Card(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      // first column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
                                              child:Container(
                                                height: 30.0,
                                                width: 50.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.green,
                                                ),
                                                child: Text('LEC',style: TextStyle(fontSize: 17,)),
                                              ),
                                            ),
                                            new Expanded(
                                              child: new Center(
                                                  child:Text(
                                                    new_data[index]['module'].replaceAll('*','').replaceAll('#',''),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,

                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                              ),
                                            ),

                                          ]
                                      ),
                                      //second column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //first row element
                                            new Tab(
                                              icon:Icon(Icons.location_on),
                                            ),
                                            //second row element
                                            new Text(
                                              new_data[index]['venue'][0],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),

                                          ]
                                      ),
                                      //third column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Tab(
                                              icon:Icon(Icons.access_time),
                                            ),
                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: new Text(
                                                new_data[index]['time'][0],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),),
                                            ),


                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                              child:new Tab(
                                                icon:Icon(Icons.calendar_today),
                                              ),
                                            ),


                                            new Text(
                                                dayDict[new_data[index]['day'][0]],
                                                style:TextStyle(
                                                  fontSize: 16,
                                                ))


                                          ]

                                      ),
                                    ],
                                  ),
                                );
                              }//end of if
                              else if(widget.savedItems.contains(index)&&(new_data[index]['day'].length==2)){
                                return new Card(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      // first column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
                                              child:Container(
                                                height: 30.0,
                                                width: 50.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.green,
                                                ),
                                                child: Text('LEC',style: TextStyle(fontSize: 17,)),
                                              ),
                                            ),
                                            new Expanded(
                                              child: new Center(
                                                  child:Text(
                                                    new_data[index]['module'].replaceAll('*','').replaceAll('#',''),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,

                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )
                                              ),
                                            ),

                                          ]
                                      ),
                                      //second column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //first row element
                                            new Tab(
                                              icon:Icon(Icons.location_on),
                                            ),
                                            //second row element
                                            new Text(
                                              new_data[index]['venue'][0],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),

                                          ]
                                      ),
                                      //third column element
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Tab(
                                              icon:Icon(Icons.access_time),
                                            ),
                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: new Text(
                                                new_data[index]['time'][0],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),),
                                            ),


                                            new Padding(
                                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                              child:new Tab(
                                                icon:Icon(Icons.calendar_today),
                                              ),
                                            ),


                                            new Text(
                                                dayDict[new_data[index]['day'][0]],
                                                style:TextStyle(
                                                  fontSize: 16,
                                                ))


                                          ]

                                      ),
                                      new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Center(child:new Text(
                                                  'Also happens on '+ dayDict[new_data[index]['day'][1]]+', time '+new_data[index]['time'][1] + ' at '+ new_data[index]['venue'][1],
                                                  style:TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey
                                                  ))),
                                            )
                                          ]
                                      )
                                    ],
                                  ),
                                );
                              }
                              else {
                                return new Container();
                              }
                            },
                            itemCount: new_data == null ? 0 : new_data.length,
                          );//end of upper if
                        }),
                  ),
                )
            ),
          ]
      ),

    );
  }


}

