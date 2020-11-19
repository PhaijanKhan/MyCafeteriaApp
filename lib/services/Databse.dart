import 'package:Cafe_Coffee/models/Coffee.dart';
import 'package:Cafe_Coffee/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference coffeeCollection = Firestore.instance.collection('Coffee');

  Future updateUserData(String name,String sugars,int strength) async{
    return await coffeeCollection.document(uid).setData(
  {
    'name' : name,
    'sugars' : sugars,
    'strength' : strength,
  }
  );
  }
  UserData _settingFormSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(uid:uid,sugar: snapshot.data['sugar'],name:snapshot.data['name'],
        strength: snapshot.data['strength'] );
  }
 //model
  List<Coffee> _coffeeListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return
        Coffee(name:doc.data['name'],
            sugar:doc.data['sugars'],
            strength:doc.data['strength'],
        );
    }).toList();
  }
  //database stream
 Stream<List<Coffee>> get coffee{
    return coffeeCollection.snapshots().map(_coffeeListSnapshot);
 }
 //document with uid
  Stream<UserData> get userData{
    return coffeeCollection.document(uid).snapshots().map(_settingFormSnapshot);
  }
}