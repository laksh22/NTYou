import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tech_fest_app/getfood/SelectDish1.dart';

final List<String> imgList = [
  'https://lh5.googleusercontent.com/p/AF1QipNBRRDOZmQFplhhq4yLtVGgLqcauAVggg3aBpHG=w204-h336-p-k-no',
  'http://www.jayyeo.com/projects/nanyangchronicle/wp-content/uploads/2013/08/KW_9179_RS.jpg',
  'http://www.ntu.edu.sg/has/FnB/SiteAssets/Pages/HallCanteens/NorthHIllFC_280x180.jpg',
  'https://pic.sgchinese.net/attachments/forum/201508/19/113839h24fzyztfmm6iid7.png'
  'https://pic.sgchinese.net/attachments/forum/201508/19/113839h24fzyztfmm6iid7.png',
  'http://1.bp.blogspot.com/-YO6qZgyktUs/Um_E-YhopuI/AAAAAAAAKQs/1R9fc56wmd4/s1600/2.+NTU+Hall+13+%2528Hong+Yun%2529.JPG',
];

final List<String> nameList = [
  "Canteen A",
  "Canteen B",
  "Canteen North Hill Court",
  "Canteen 1",
  "Canteen 2",
  "Canteen 13",
];

final Widget placeholder = new Container(color: Colors.blue);

final List child = map<Widget>(imgList, (index, i) {
  return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(i,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )
                      ),
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                      child: Text('${nameList[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  )
              ),
            ],
          )
      )
  );
}).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class PlacePage extends StatefulWidget {
  PlacePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  PlacePageState createState() => new PlacePageState();
}

class PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text('Get Food from Canteens')),
        body: new ListView(
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: CarouselSlider(
                  items: child,
                  autoPlay: false,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HeroPage()),
                      );
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    elevation: 2.0,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Select",
                      style: new TextStyle(
                          color: Colors.white, fontSize: 20.0)),
                )
              ],
            ),
          ],
        )
    );
  }
}