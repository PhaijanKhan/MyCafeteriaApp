import 'package:flutter/material.dart';

const TextInputDecoration = InputDecoration(
//  icon: Icon(Icons.mail),
  fillColor: Colors.black,
  border: OutlineInputBorder(
  ),
 focusedBorder: OutlineInputBorder(
   borderRadius:BorderRadius.all(Radius.circular(8.0)),
   borderSide: BorderSide(
     color: Colors.black,
     width: 2.0,
   ),
 ),
  labelStyle: TextStyle(
    color: Colors.black,
  ),
//  helperText: 'Helper text',
//  suffixIcon: Icon(
//    Icons.check_circle,
//  ),
//  enabledBorder: UnderlineInputBorder(
//    borderSide: BorderSide(color: Colors.black),
//  ),
);