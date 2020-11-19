import 'package:Cafe_Coffee/Shared/Constant.dart';
import 'package:Cafe_Coffee/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text(
            'Register',
        ),
        elevation: 0.0,
        actions: <Widget>[
            IconButton(icon: Icon(Icons.person), onPressed: () => widget.toggleView(),),
//          FlatButton.icon(onPressed: (){
//            widget.toggleView();
//          },
//              icon: Icon(Icons.person),
//              label: Text('SignIn'))
        ],
      ),
      body:Container(
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
            child:Card(
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
                    SizedBox(height: 30,),
                    TextFormField(
                      cursorColor: Theme.of(context).cursorColor,
                      decoration:
                      TextInputDecoration.copyWith(labelText: 'Email',prefixIcon: Icon(Icons.mail,color: Colors.black,)),
                      onChanged: (val){
                        setState(() {
                          return email = val;
                        });
                      },
                      validator: (val){
                        return val.isEmpty? "Email Required":null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: true,
                      decoration:
                      TextInputDecoration.copyWith(labelText: 'Password',prefixIcon: Icon(Icons.vpn_key,color:Colors.black)),
                      onChanged: (val){
                        setState(() {
                          return password = val ;
                        });
                      },
                      validator: (val){
                        return val.length < 6 ? "Password Required":null;
                      },
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(

                      child:Text('Register'),
                      onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                          if(result==null){
                              setState(() {
                                return error="Invalid User";
                              });
                          }
                        }
                      },
                      color: Colors.pink[400],
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}