import 'package:flutter/material.dart';
import 'dart:convert';
import  'my_flutter_app_icons.dart';
import 'package:http/http.dart' as http;
import 'package:tech_fest_app/classes/savedClasses.dart';


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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget { //https://stackoverflow.com/questions/45970979/flutter-appbar-backbutton-doesnt-appear - how i solved back button not appearing
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue=10;
  String amOrPm='AM';
  String dayButton="MON";
  var dayDict={'MON':'Monday','TUE':'Tuesday','WED':'Wednesday','THU':'Thursday','FRI':'Friday','SAT':'Saturday','SUN':'Sunday'};
  List data;
  var savedItems=[];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lecture Time'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: _pushSaved),
        ],
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body:
      new Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                              //if(new_data!=null){print(new_data[index]['course']);}
                              // double time = int.parse(new_data[index]['time'][0])/100;
                              String timeStr=new_data[index]['time'][0];
                              String day=new_data[index]['day'][0];
                              String day2='-1';
                              if(new_data[index]['day'].length==2){
                                String day2=new_data[index]['day'][1];
                              }
                              String s1=timeStr.split('-')[0];
                              String s2=timeStr.split('-')[1];
                              double r1=int.parse(s1)/100;
                              double r2=int.parse(s2)/100;
                              // r1<= _sliderValue && _sliderValue<=r2
                              // print(_sliderValue);
                              if (day==dayButton &&(r1<= _sliderValue && _sliderValue<=r2)&&(new_data[index]['day'].length==1)){
                                return InkWell(
                                  onDoubleTap: (){
                                    this.setState((){
                                      savedItems.contains(index)? savedItems.remove(index):savedItems.add(index);//the index instead of the whole thing
                                      print(savedItems);
                                    });

                                  },
                                  child: new Card(
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        // first column widget
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                                                child:Container(
                                                  height: 20.0,
                                                  width: 25.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: Colors.lightBlue,
                                                  ),
                                                  child: Text('LEC',style: TextStyle(fontSize: 12,color: Colors.black)),
                                                ),
                                              ),
                                              new Container(
                                                    child:Text(
                                                      ' '+new_data[index]['module'].replaceAll('*','').replaceAll('#',''),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                              ),
                                            ]
                                        ),
                                        //second column element
                                        SizedBox(height: 0),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              //first row element
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                                child: new Tab(
                                                  icon:Icon(Icons.location_on),
                                                ),
                                              ),

                                              //second row element
                                              new Text(
                                                new_data[index]['venue'][0],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(02, 02, 02, 1),
                                                ),
                                              ),
                                            ]
                                        ),
                                        //third column element
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10,0,10,0),
                                                child: new Tab(
                                                  icon:Icon(Icons.access_time),
                                                ),
                                              ),
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                                                child: new Text(
                                                  new_data[index]['time'][0],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),),
                                              ),


                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                                child:new Tab(
                                                  icon:Icon(Icons.calendar_today),
                                                ),
                                              ),
                                              new Text(
                                                  dayDict[new_data[index]['day'][0]],
                                                  style:TextStyle(
                                                    fontSize: 15,
                                                  )),
                                              Spacer(),
                                              new Container(
                                                margin: const EdgeInsets.only(right: 7.0),
                                                child: new Tab(
                                                    icon: new Icon(
                                                      savedItems.contains(index) ? Icons.favorite : Icons.favorite_border,
                                                      color: savedItems.contains(index) ? Colors.red : null,)
                                                ),
                                              ),
                                            ]

                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }//end of if
                              else if(day==dayButton &&(r1<= _sliderValue && _sliderValue<=r2)&&(new_data[index]['day'].length==2)){
                                return InkWell(
                                  onDoubleTap: (){
                                    this.setState((){
                                      savedItems.contains(index)? savedItems.remove(index):savedItems.add(index);//the index instead of the whole thing
                                      print(savedItems);
                                    });

                                  },

                                  child: new Card(
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      mainAxisSize: MainAxisSize.max,
//                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // first column widget
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
//                                            mainAxisSize: MainAxisSize.max,
//                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                                                child:Container(
                                                  height: 20.0,
                                                  width: 25.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: Colors.lightBlue,
                                                  ),
                                                  child: Text('LEC',style: TextStyle(fontSize: 12,color: Colors.black)),
                                                ),
                                              ),
                                              new Container(
                                                child:Text(
                                                  ' '+new_data[index]['module'].replaceAll('*','').replaceAll('#',''),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]
                                        ),
                                        //second column element
                                        SizedBox(height: 0),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              //first row element
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: new Tab(
                                                  icon:Icon(Icons.location_on),
                                                ),
                                              ),

                                              //second row element
                                              new Text(
                                                new_data[index]['venue'][0],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(02, 02, 02, 1),
                                                ),
                                              ),
                                            ]
                                        ),
                                        //third column element
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10,0,10,0),
                                                child: new Tab(
                                                  icon:Icon(Icons.access_time),
                                                ),
                                              ),
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                                child: new Text(
                                                  new_data[index]['time'][0],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),),
                                              ),


                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                                child:new Tab(
                                                  icon:Icon(Icons.calendar_today),
                                                ),
                                              ),
                                              new Text(
                                                  dayDict[new_data[index]['day'][0]],
                                                  style:TextStyle(
                                                    fontSize: 15,
                                                  )),
                                              Spacer(),
                                              new Container(
                                                margin: const EdgeInsets.only(right: 7.0),
                                                child: new Tab(
                                                    icon: new Icon(
                                                      savedItems.contains(index) ? Icons.favorite : Icons.favorite_border,
                                                      color: savedItems.contains(index) ? Colors.red : null,)
                                                ),
                                              ),
                                            ]

                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if (day2==dayButton &&(r1<= _sliderValue && _sliderValue<=r2)&&(new_data[index]['day'].length==2)){
                                return InkWell(
                                  onDoubleTap: (){
                                    this.setState((){
                                      savedItems.contains(index)? savedItems.remove(index):savedItems.add(index);//the index instead of the whole thing
                                      print(savedItems);
                                    });

                                  },
                                  child: new Card(
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        // first column widget
                                        new Wrap(
                                            spacing: 8.0, // gap between adjacent chips
                                            runSpacing: 4.0, // gap between lines
                                            direction: Axis.horizontal, //
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                                                child:Container(
                                                  height: 20.0,
                                                  width: 25.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: Colors.lightBlue,
                                                  ),
                                                  child: Text('LEC',style: TextStyle(fontSize: 12,color: Colors.black)),
                                                ),
                                              ),
                                              new Container(
                                                child:Text(
                                                  ' '+new_data[index]['module'].replaceAll('*','').replaceAll('#',''),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]
                                        ),
                                        //second column element
                                        SizedBox(height: 0),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              //first row element
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                                child: new Tab(
                                                  icon:Icon(Icons.location_on),
                                                ),
                                              ),

                                              //second row element
                                              new Text(
                                                new_data[index]['venue'][0],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(02, 02, 02, 1),
                                                ),
                                              ),
                                            ]
                                        ),
                                        //third column element
                                        new Row(
//                                            mainAxisAlignment: MainAxisAlignment.center,
//                                            mainAxisSize: MainAxisSize.max,
//                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10,0,10,0),
                                                child: new Tab(
                                                  icon:Icon(Icons.access_time),
                                                ),
                                              ),
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                                child: new Text(
                                                  new_data[index]['time'][0],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),),
                                              ),


                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                                child:new Tab(
                                                  icon:Icon(Icons.calendar_today),
                                                ),
                                              ),
                                              new Text(
                                                  dayDict[new_data[index]['day'][0]],
                                                  style:TextStyle(
                                                    fontSize: 15,
                                                  )),
                                              Spacer(),
                                              new Container(
                                                margin: const EdgeInsets.only(right: 7.0),
                                                child: new Tab(
                                                    icon: new Icon(
                                                      savedItems.contains(index) ? Icons.favorite : Icons.favorite_border,
                                                      color: savedItems.contains(index) ? Colors.red : null,)
                                                ),
                                              ),
                                            ]

                                        ),
                                      ],
                                    ),
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
































            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Slider(
                      key: null,
                      onChanged: sliderChanged,
                      value:_sliderValue,
                      min:0,max:24,
                      divisions:48,
                      label: '${calcTiming(_sliderValue)}',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        '${calcTiming(_sliderValue)} $amOrPm',
                        style: TextStyle(
                            fontSize: 20
                        )
                    ),
                  ),
                ]
            ),
            new Center(
              child: new Text(
                'drag slider to adjust time',
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic
                ),
              ),
            ),

            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                    icon: const Icon(MyFlutterApp.monday_calendar_page1),
                    onPressed:mondayPressed,
                    iconSize: 40.0,
                    color: Colors.blue,
                  ),

                  new IconButton(
                    icon: const Icon(MyFlutterApp.tuesday_daily_calendar_page1),
                    onPressed:tuesdayPressed,
                    iconSize: 40.0,
                    color: Colors.blue,
                  ),

                  new IconButton(
                    icon: const Icon(MyFlutterApp.wednesday_calendar_daily_page1),
                    onPressed:wednesdayPressed,
                    iconSize: 40.0,
                    color: Colors.blue,
                  ),

                  new IconButton(
                    icon: const Icon(MyFlutterApp.thursday_calendar_daily_page_interface_symbol1),
                    onPressed:thursdayPressed,
                    iconSize: 40.0,
                    color: Colors.blue,
                  ),

                  new IconButton(
                    icon: const Icon(MyFlutterApp.friday_daily_calendar_page1),
                    onPressed:fridayPressed,
                    iconSize: 40.0,
                    color: Colors.blue,
                  ),


                ]

            ),

          ]

      ),

    );
  }

  void _pushSaved(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MySavedHomePage(savedItems: savedItems)),
    );
  }

  String calcTiming(double time){
    double d=double.parse(time.toStringAsFixed(2));
    String returnTime='';
    returnTime+=(time.toStringAsFixed(0)+':');
    returnTime+=(((d%1 *0.6*100)).toStringAsFixed(0));
    returnTime+= (returnTime.split(':')[1].length==1 ? '0':'');
    return returnTime;
  }

  void sliderChanged(double value) {
    amOrPm= value<12 ? 'AM' : 'PM';
    setState(() => _sliderValue = value);
  }

  void mondayPressed(){
    setState(() {
      dayButton="MON";
    });
  }
  void tuesdayPressed(){
    setState(() {
      dayButton="TUE";
    });
  }
  void wednesdayPressed(){
    setState(() {
      dayButton="WED";
    });
  }
  void thursdayPressed(){
    setState(() {
      dayButton="THU";
    });
  }
  void fridayPressed(){
    setState(() {
      dayButton="FRI";
    });
  }

}