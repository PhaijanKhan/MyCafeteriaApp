import 'package:Cafe_Coffee/models/Coffee.dart';
import 'package:Cafe_Coffee/screens/home/CoffeeList.dart';
import 'package:Cafe_Coffee/screens/home/SettingForm.dart';
import 'package:Cafe_Coffee/services/Databse.dart';
import 'package:Cafe_Coffee/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel(){
        showModalBottomSheet(context:context, builder:(context){
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(

            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingForm(),
          ),
        );
      });
    }
    return StreamProvider<List<Coffee>>.value(
        value: new DatabaseServices().coffee,
        child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text("Cafe Coffee"),
            backgroundColor: Colors.brown[400],
            elevation: 0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("Sign Out"),
                onPressed: ()async{
                  await _auth.signOut();
                },

              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label:Text('setting'),
                onPressed: (){
                  return _showSettingPanel();

                },

              ),
            ],
          ),
         body: Container(

             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage(
                   'assets/coffee.jpg'
                 ),
                 fit:BoxFit.cover,
               ),
             ),

             child: CoffeeList()
         ),
        ),
    );
  }

}
