import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List ColorList = [
  Color(0xFFF8F1E4),
  Color(0xFFFE9574),
  Colors.blue[300], 
  Colors.amber[300], 
  Colors.green[200]
];

const loadingSnackBar = SnackBar(
                 content: Text('Loading...', 
                 style: TextStyle(
                   fontWeight: FontWeight.bold, 
                   color: Colors.white
                 )),
                 backgroundColor: Color(0xFFFE9574),
               );

const successSnackBar = SnackBar(
  content: Text('Success!', 
  style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold, 
  )),
  backgroundColor: Colors.greenAccent,
);

const failureSnackBar = SnackBar(
  content: Text('Sorry there was an error', 
  style: TextStyle(
      color: Colors.white, 
      fontWeight: FontWeight.bold
  )), 
  backgroundColor: Colors.red,
);

