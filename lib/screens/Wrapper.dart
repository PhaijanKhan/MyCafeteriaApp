import 'package:Cafe_Coffee/models/user.dart';
import 'package:Cafe_Coffee/screens/authenticate/Authenticate.dart';
import 'package:Cafe_Coffee/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate

    final user=Provider.of<User>(context);
      if(user==null) {
        return Authenticate();
      }else{
        return Home();
      }

  }
}
