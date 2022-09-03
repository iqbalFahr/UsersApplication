import 'dart:async';
import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore/repositories/Utility.dart';
import 'package:firestore/views/homeScreen.dart';
import 'package:firestore/views/registerScreen.dart';
import 'package:firestore/views/updateScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/users.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  String email='';
  String password='';



  checkLogin()async{

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
          msg: 'Succesfully Login',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          homeScreen()), (Route<dynamic> route) => false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('login', 'yes');


      log('userCredential '+userCredential.toString());


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

            Text("Login",
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

            Utility().buttonFull(context, 'Login', 20, (p0) {

              checkLogin();

            }),

            Utility().buttonFullOutlineBlue(context, 'Register', 20, (p0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => registerScreen()));
            }),
          ],
        ),
      ),
    );


  }


}
