import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users.dart';
import '../repositories/Utility.dart';
import 'chartScreen.dart';
import 'inputScreen.dart';
import 'listScreen.dart';

class homeScreen extends StatefulWidget {

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {


  void initState() {

  }

  logout()async{
    FirebaseAuth.instance.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        loginScreen()), (Route<dynamic> route) => false);


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

            Text("User Form Application",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue)),
            Container(height: 25,),

            Row(
              children: [
                Expanded(child: Utility().styleCard(context, 'Input', Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_reaction,size: 40),
                    Container(height: 10,),
                    Text("Input Form User",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue)),
                  ],
                ), (p0) =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => inputScreen()))
                )),
                Expanded(child: Utility().styleCard(context, 'List', Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt,size: 40),
                    Container(height: 10,),
                    Text("List Form User",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue)),
                  ],
                ), (p0) =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => listScreen()))
                )),
              ],
            ),
            Row(
              children: [
                Expanded(child: Utility().styleCard(context, 'Input', Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart,size: 40,),
                    Container(height: 10,),
                    Text("LineChart User",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue)),
                  ],
                ), (p0) =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => chartScreen()))
                )),
                Expanded(child: Utility().styleCard(context, 'Input', Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,size: 40,color: Colors.redAccent,),
                    Container(height: 10,),
                    Text("Logout",textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.redAccent)),
                  ],
                ), (p0) {
                  logout();



                })),
              ],
            ),


          ],
        ),
      ),

    );


  }


}
