import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firestore/model/users.dart';
import 'package:firestore/repositories/Utility.dart';
import 'package:firestore/repositories/fire_auth.dart';
import 'package:firestore/views/chartScreen.dart';
import 'package:firestore/views/homeScreen.dart';
import 'package:firestore/views/inputScreen.dart';
import 'package:firestore/views/listScreen.dart';
import 'package:firestore/views/loginScreen.dart';
import 'package:firestore/views/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/users.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String email='';
  String password='';


  void initState() {
    checkStatus();
  }

  checkStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      log('login first0 '+prefs.getString('login').toString());
      if(prefs.getString('login').toString()=='yes'){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            homeScreen()), (Route<dynamic> route) => false);
      }
    }
    catch(e){
      log('login first');
    }
  }

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
    return loginScreen();


  }




 

}


