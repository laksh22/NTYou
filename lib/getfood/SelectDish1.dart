import "package:flutter/material.dart";
import 'package:tech_fest_app/getfood/payment1.dart';

class Dish{
  const Dish({this.name, this.price, this.calories, this.imageUrl});
  final String name;
  final String price;
  final String calories;
  final String imageUrl;
}

final List<Dish> _dishes = <Dish>[
  Dish(
      name: 'Veg Noodles',
      price: '4 SGD',
      calories: '400k',
      imageUrl: 'one.jpg'
  ),
  Dish(
      name: 'Beef Fried Rice',
      price: '5',
      calories: '500k',
      imageUrl:'201205-xl-beef-fried-rice.jpg'),
  Dish(
    name: 'Chicken Fillet Rice',
    price: '5',
    calories: '500k',
    imageUrl: '92122816-chicken-fillet-with-fried-rice-on-white-plate-.jpg',
  ),
  Dish(
    name: 'Fish Fillet Rice',
    price: '5',
    calories: '600k',
    imageUrl:'crispy-fish-Greek-rice-bowls-1.jpg',
  ),
];
class HeroPage extends StatefulWidget {
  HeroPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HeroPageState createState() => new HeroPageState();
}

class HeroPageState extends State<HeroPage>
{
  List<String> itemData = ["one","two","three","four"];

  Widget _dialogBuilder(BuildContext context, Dish dish){
    ThemeData localTheme = Theme.of(context);
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        Image.network(
            dish.imageUrl,
            fit: BoxFit.fill),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Text(dish.name,
                style: localTheme.textTheme.display1,
              ),
              Text(dish.price,
                  style: localTheme.textTheme.subhead.copyWith(
                    fontStyle: FontStyle.italic,
                  )),
              SizedBox(height: 16.0),
              Text(dish.calories,
                  style: localTheme.textTheme.body1),
              SizedBox(height: 16.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                      children:[
                        FlatButton(
                          onPressed: (){},
                          child: const Text('Back'),
                          color: Colors.white,
                          textColor: Colors.blue,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>PayPage()),
                            );
                          },
                          child: const Text('Check out'),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ]
                  )
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () =>
          showDialog(
              context: context,
              builder: (context) => _dialogBuilder(context, _dishes[index])
          ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(_dishes[index].name,
            style: Theme
                .of(context)
                .textTheme
                .headline),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Canteens'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 350.0,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text("Sliver title"),
                  background: Image.asset("assets/veg_rice.jpg",fit: BoxFit.cover,)
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context,index){
                return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
//                          color: Colors.grey,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            width: 100.0,
                            height: 100.0,
                            child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(new PageRouteBuilder(
                                    opaque: false,
                                    barrierDismissible:true,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.zero,
                                        children: [
                                          Image.asset("assets/${_dishes[index].imageUrl}",fit: BoxFit.fill),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children:[
                                                Text(_dishes[index].name,
//                                                  style: localTheme.textTheme.display1,
                                                ),
                                                Text(_dishes[index].price,

                                                   ),
                                                SizedBox(height: 16.0),
                                                Text(_dishes[index].calories,
                                                   ),
                                                SizedBox(height: 16.0),
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Wrap(
                                                        children:[
                                                          FlatButton(
                                                            onPressed: (){
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) =>HeroPage()),
                                                              );
                                                            },
                                                            child: const Text('Back'),
                                                            color: Colors.white,
                                                            textColor: Colors.blue,
                                                          ),
                                                          RaisedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) =>PayPage()),
                                                              );
                                                            },
                                                            child: const Text('Add to order'),
                                                            color: Colors.blue,
                                                            textColor: Colors.white,
                                                          )
                                                        ]
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }));
                              },
                              child: Hero(
                                tag: "image_$index",
                                child: Material(
                                  borderRadius: BorderRadius.circular(5.0),
                                  elevation: 5.0,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Image.asset("assets/${_dishes[index].imageUrl}",fit: BoxFit.fill),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text("${_dishes[index].name}",style: TextStyle(fontSize: 16.0),),
                                  Text("Price: ${_dishes[index].price}    Calories: 400k",style: TextStyle(fontSize: 13.0),),

                                ],
                              ),
                            )
                        ),

                      ],
                    )
                );
              },
                  childCount: itemData.length
              ),
            )
          ],
        )
    );
  }
}