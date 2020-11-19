import 'package:Cafe_Coffee/models/user.dart';
import 'package:Cafe_Coffee/services/Databse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFiresbaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return
      //_auth.onAuthStateChanged.map((FirebaseUser user)=>_userFromFiresbaseUser(user));
      _auth.onAuthStateChanged.map(_userFromFiresbaseUser);
  }
  signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFiresbaseUser(user);
        }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
       AuthResult result=await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
       FirebaseUser user=result.user;
       await DatabaseServices(uid: user.uid).updateUserData('new Coffee ${user.email}', '0', 100);
       return _userFromFiresbaseUser(user);
    }catch(e){
      print(e.toString());
    return null;
  }

}  //sigin in with email and password

Future signInWithEmailAndPassword(@required String email,@required String password) async{
  try{
    AuthResult result=await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    FirebaseUser user=result.user;
    return _userFromFiresbaseUser(user);

  }catch(e){
    print(e.toString());
    return null;
  }
}}








