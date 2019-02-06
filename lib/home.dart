import 'package:flutter/material.dart';
import 'package:tech_fest_app/auth/auth.dart';
import 'package:tech_fest_app/common/primary_button.dart';
import 'package:tech_fest_app/events/events_list.dart';
import 'package:tech_fest_app/Fault Reporting/pageone.dart';
import 'package:tech_fest_app/classes/classes.dart';
import 'package:tech_fest_app/todolistv2/todomain.dart';
import 'package:tech_fest_app/getfood//SelectPlace.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tech_fest_app/campusbus/bus_tracker.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
];

class Home extends StatelessWidget {
  Home({this.auth, this.onSignOut, this.userId ,this.email});
  final BaseAuth auth;
  final String userId, email;
  final VoidCallback onSignOut;



  @override
  Widget build(BuildContext context) {

    List<Widget> _tiles = <Widget>[
      new InkWell(
        child: _Example01Tile(Colors.green, Icons.search, "Find Classes"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
      ),
      new InkWell(
        child: _Example01Tile(Colors.lightBlue, Icons.directions_bus, "Bus Tracker"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BusPage()),
          );
        },
      ),
      new InkWell(
        child: _Example01Tile(Colors.amber, Icons.star, "Events"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventsList(auth: auth, userId: userId, email: email)),
          );
        },
      ),
      new InkWell(
        child: _Example01Tile(Colors.brown, Icons.help_outline, "Report a Fault"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageOne()),
          );
        },
      ),
      new InkWell(
        child: _Example01Tile(Colors.deepOrange, Icons.view_list, "To-do List"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePageToDo()),
          );
        },
      ),
      new InkWell(
        child: _Example01Tile(Colors.indigo, Icons.fastfood, "Order Food"),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlacePage()),
          );
        },
      ),
    ];

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }

    return new SafeArea(
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Home"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: _signOut,
                  child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
              )
            ],
          ),
          body: new Center(
            child:new SingleChildScrollView(child: new Container(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                    children: <Widget>[
                      new Image.asset(
                          'img/ntu.png',
                      height: 200.0,
                      width: 200.0),
                      new Padding(
                        padding: const EdgeInsets.only(bottom:10.0),
                      child: Text(
                        'Welcome to NTYou!',
                        style: new TextStyle(fontSize: 32.0),
                      )),
                      new Container(
                        height: 400,
                      child: StaggeredGridView.count(
                        crossAxisCount: 4,
                        staggeredTiles: _staggeredTiles,
                        children: _tiles,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        padding: const EdgeInsets.all(4.0),
                      )),

                    ]
                )
            )
          ),

      )),
    );

  }
}



class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData, this.name);

  final Color backgroundColor;
  final IconData iconData;
  final String name;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
        child: new Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          Expanded(child:new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
            ),
          ))
          ],
          ),
        ),

    );
  }
}
