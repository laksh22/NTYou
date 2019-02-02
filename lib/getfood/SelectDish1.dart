import 'package:flutter/material.dart';
import 'package:tech_fest_app/layout.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

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
      imageUrl: '3050_noodles.jpg'
  ),
  Dish(
    name: 'Beef Fried Rice',
    price: '5',
    calories: '500k',
    imageUrl:'201205-xl-beef-fried-rice.jpg',
  ),
  Dish(
    name: 'Fried Fillet Rice',
    price: '5',
    calories: '500k',
    imageUrl: 'crispy-fish-Greek-rice-bowls-1.jpg',
  ),
  Dish(
    name: 'Chicken Fillet Rice',
    price: '5',
    calories: '600k',
    imageUrl:'92122816-chicken-fillet-with-fried-rice-on-white-plate-.jpg',
  ),
];
class HeroHeader implements SliverPersistentHeaderDelegate {
  HeroHeader({
    this.layoutGroup,
    this.onLayoutToggle,
    this.minExtent,
    this.maxExtent,
  });
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/BackGround.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(layoutGroup == LayoutGroup.nonScrollable
                  ? Icons.filter_1
                  : Icons.filter_2),
              onPressed: onLayoutToggle,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Hero Image',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class HeroPage extends StatelessWidget implements HasLayoutGroup {
  HeroPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: HeroHeader(
              layoutGroup: layoutGroup,
              onLayoutToggle: onLayoutToggle,
              minExtent: 150.0,
              maxExtent: 250.0,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: _edgeInsetsForIndex(index),
                  child: Image.asset(
                    "assets/${_dishes[index].imageUrl}",
                  ),
                );
              },
              childCount: _dishes.length * 2,
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}