import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/repositories/Utility.dart';
import 'package:firestore/views/updateScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


import '../models/users.dart';

class chartScreen extends StatefulWidget {
  @override
  _chartScreenState createState() => _chartScreenState();
}

class _chartScreenState extends State<chartScreen> {

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

            Text("Chart Users Wight",
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

                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      child: LineChart(
                        LineChartData(borderData: FlBorderData(show: false), lineBarsData: [
                          LineChartBarData(spots: users.asMap().entries.map((e) {
                            return FlSpot(e.key.toDouble(), e.value.height.toDouble());
                          }).toList())
                        ]),
                      ),
                    );
                  }
                  else return Center(child: CircularProgressIndicator(),);
                }
            )),
            Padding(padding: EdgeInsets.only(left: 20,top: 20, bottom: 5),child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Name User",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue)),
            ),),
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
