import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Food(),
    );
  }
}

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
      imageUrl: 'http://yesofcorsa.com/wp-content/uploads/2015/08/3050_noodles.jpg'
  ),
  Dish(
    name: 'Beef Fried Rice',
    price: '5',
    calories: '500k',
    imageUrl:'https://cdn-image.foodandwine.com/sites/default/files/styles/medium_2x/public/201205-xl-beef-fried-rice.jpg?itok=DJSuhhcl',
  )
];

class Food extends StatelessWidget {
  const Food({Key key}): super(key: key);
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
                            onPressed: (){},
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
      appBar: AppBar(
        title: Text('Menu'),
      ),

      body: ListView.builder(
        itemCount: _dishes.length,
        itemExtent: 60.0,
        itemBuilder: _listItemBuilder,
      )

    );
  }
}

