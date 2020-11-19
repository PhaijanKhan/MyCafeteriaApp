import 'package:Cafe_Coffee/models/Coffee.dart';
import 'package:Cafe_Coffee/screens/home/CoffeeTile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}
class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<Coffee>>(context) ?? [];
    return ListView.builder(
        itemCount: coffee.length,
        itemBuilder: (context,index){
          return CoffeeTile(coffee: coffee[index],);
        }
    );
  }
}
