import 'dart:async';
import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore/repositories/Utility.dart';
import 'package:firestore/views/homeScreen.dart';
import 'package:firestore/views/updateScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../models/users.dart';

class registerScreen extends StatefulWidget {
  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {

  String email='';
  String password='';
  String confirmpassword='';

  register()async{

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
          msg: 'Account Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          homeScreen()), (Route<dynamic> route) => false);


      log('userCredential '+userCredential.user.toString());



    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
      log('userCredential0 '+e.toString());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/edenfarmlogo.png'
              ,height:125,width: 125,),

            Text("Register User",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue)),
            Container(height: 25,),

            Utility().textFieldCard(context, 'Email', false, '',true, (p0) => setState((){
              email=p0;
            })),

            Utility().textFieldCard(context, 'Password', true, '',true, (p0) => setState((){
              password=p0;
            })),

            Utility().textFieldCard(context, 'Confirm Password', true, '',true, (p0) => setState((){
              confirmpassword=p0;
            })),

            Utility().buttonFull(context, 'Create Account', 20, (p0) {

              password==confirmpassword?
              register():
              Fluttertoast.showToast(
                  msg: 'Your password do not match',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }),
          ],
        ),
      ),
    );




  }


}
