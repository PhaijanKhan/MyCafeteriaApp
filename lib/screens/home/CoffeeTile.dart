import 'package:Cafe_Coffee/models/Coffee.dart';
import 'package:flutter/material.dart';
class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            radius: 26,
          ),
          title: Text(coffee.name),
          subtitle: Text("Takes ${coffee.sugar} sugars"),
        ),
      ),
    );
  }
}
