import 'package:Cafe_Coffee/Shared/Constant.dart';
import 'package:Cafe_Coffee/Shared/Loading.dart';
import 'package:Cafe_Coffee/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  bool loading = false;
  AuthServices _auth = new AuthServices();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.brown[400],
              title: Text('SignIn',style:  GoogleFonts.staatliches(fontStyle: FontStyle.normal,color: Colors.white)),
              elevation: 0.0,
//              actions: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.person),
//                  padding:EdgeInsets.all(8.0,),
//                  tooltip: "Sign Up",
//                  onPressed: () => widget.toggleView(),
//                ),
////                FlatButton.icon(
////                    onPressed: () {
////                      widget.toggleView();
////                    },
////                    icon: Icon(Icons.person),
////                    label: Text('SignUp'),
////                ),
//              ],
            ),
            body: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/coffee.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Color(0xb8ffffff),
                    elevation: 8.0,
                    margin:EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[

                          TextFormField(
                            cursorColor: Theme.of(context).cursorColor,
                            decoration:
                                TextInputDecoration.copyWith(labelText: 'Email',prefixIcon: Icon(Icons.mail,color: Colors.black,)),
                            validator: (val) {
                              return val.isEmpty ? "Email Required" : null;
                            },

                            onChanged: (val) {
                              setState(() {
                                return email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration:
                                TextInputDecoration.copyWith(labelText: 'Password',prefixIcon: Icon(Icons.vpn_key,color:Colors.black)),
                            validator: (val) {
                              return val.length < 6 ? "Password Required" : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                return password = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RaisedButton(
                            child: Text('SignIn', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  return loading = true;
                                });
                                dynamic result = await _auth
                                    .signInWithEmailAndPassword(email, password);
                                if (result == null) {
                                  error = 'invalid email and password';
                                  loading = false;
                                }
                              }
                            },
                            color: Colors.pink[400],
                          ),
                          error != null ? Text(error,style: TextStyle(
                            color: Colors.white,
                          ),) : SizedBox(height: 1.0,),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),
                            onPressed: () => widget.toggleView(),
                            //child: Text("Sign up".toUpperCase(), style:  GoogleFonts.oswald(fontStyle: FontStyle.normal,color: Colors.white),),
                            child: Text("Sign up".toUpperCase(), style:  GoogleFonts.oswald(fontStyle: FontStyle.normal,color: Colors.white),),
                            color: Colors.cyan,
                            padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
                          )
                        ],// ye impliment kr ki yadi phone yadevice data off hota h ya device offline hota h toh kya represent krna h app m or shat m
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
