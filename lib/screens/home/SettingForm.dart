import 'package:Cafe_Coffee/Shared/Constant.dart';
import 'package:Cafe_Coffee/Shared/Loading.dart';
import 'package:Cafe_Coffee/models/user.dart';
import 'package:Cafe_Coffee/services/Databse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}
class _SettingFormState extends State<SettingForm> {

  final _formkey=GlobalKey<FormState>();

 final List<String> sugars=['0','1','2','3'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
           UserData userData=snapshot.data;
           return Form(
             key: _formkey,
             child: Column(
               children: <Widget>[
                 Text("Update your Coffee settings"),
                 SizedBox(
                   height: 20,
                 ),
                 TextFormField(
                   initialValue: userData.name,
                   decoration: TextInputDecoration,
                   validator: (value){
                     return value.isEmpty ? "Required Field" : null;
                   },
                   onChanged: (val){
                     return setState((){
                       return _currentName=val;
                     }
                     );
                   },
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 //dropdown
                 DropdownButtonFormField(
                   decoration: TextInputDecoration,
                   value:_currentSugars ?? userData.sugar,
                   items:sugars.map((sugar){
                     return DropdownMenuItem(
                       value: sugar,
                       child: Text('$sugar sugars'),
                     );
                   }).toList(),
                   validator: (value){
                     return value.isEmpty ? "Required Field" : null;
                   },
                   onChanged: (val){
                     setState(() {
                       return _currentSugars=val;
                     });
                   },
                 ),
                 SizedBox(height: 20,),

                 SizedBox(height: 20,),
                 // slider
                 Slider(
                   value: (_currentStrength ??  userData.strength).toDouble(),
                   activeColor: Colors.brown[_currentStrength ??100],
                   inactiveColor:Colors.brown[_currentStrength ?? 100],
                   min: 100.0,
                   max: 900.0,
                   divisions: 8,

                   onChanged: (val){
                     setState(() {
                       return _currentStrength=val.round();
                     });
                   },
                 ),
                 RaisedButton(
                   color: Colors.pink[400],
                   onPressed: () async{
                     if(_formkey.currentState.validate()){
                       await DatabaseServices(uid: user.uid).updateUserData(
                          _currentName ?? userData.name, _currentSugars ?? userData.sugar,_currentStrength ?? userData.strength
                       );
                       Navigator.pop(context);
                     }
                         },
                   child: Text(
                     'update',
                     style: TextStyle(
                         color: Colors.white
                     ),
                   ),
                 ),
               ],
             ),
           );
        }else{
           return Loading();
        }
      }
    );
  }
}
