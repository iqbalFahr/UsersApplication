import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/repositories/Utility.dart';
import 'package:firestore/views/updateScreen.dart';
import 'package:flutter/material.dart';


import '../models/users.dart';

class listScreen extends StatefulWidget {
  @override
  _listScreenState createState() => _listScreenState();
}

class _listScreenState extends State<listScreen> {

  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(height: 100,),
            Image.asset('assets/edenfarmlogo.png'
              ,height:125,width: 125,),

            Text("List Users",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue)),
            Container(height: 25,),

            Expanded(child: StreamBuilder<List<Users>>(
                stream: readUsers(),
                builder: (context, snapshot){
                  if(snapshot.hasError){

                    return Text(snapshot.error.toString());
                  }
                  else if (snapshot.hasData){
                    final users = snapshot.data!;

                    return ListView(
                      children: users.map(buildUser).toList(),
                    );
                  }
                  else return Center(child: CircularProgressIndicator(),);
                }
            ))
           

          ],
        ),
      ),

    );



  }

  Widget buildUser (Users users) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,),
    child: Utility().listCard(context, '',
        ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => updateScreen(data: Users(users.id, users.name, users.gender, users.dateofbirth, users.height))));
            },
            leading: Icon(Icons.person,color: users.gender=='Male'?Colors.blue:Colors.pinkAccent,size: 50,),
            title: Text(users.name),
            subtitle: Text(users.dateofbirth),
        )
            , (p0) => null),
  );

}
