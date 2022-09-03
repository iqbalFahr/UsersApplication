import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/users.dart';
import '../repositories/Utility.dart';

class inputScreen extends StatefulWidget {
  @override
  _inputScreenState createState() => _inputScreenState();
}

class _inputScreenState extends State<inputScreen> {

  String gender="Male";
  List _listGender = ["Male", "Female"];
  String name='';
  int height=0;
  String dateofbirth=DateTime.now().toString().substring(0,10);

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

            Text("Form Input Users",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue)),
            Container(height: 25,),
            Utility().textFieldCard(context, 'Input Name', false, '',true, (p0) => setState((){
              name=p0;
            })),
            Container(
                height: 75,
                // margin: new EdgeInsets.only( bottom: 10),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      margin: new EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                width: 1000,
                                child: DropdownButton(
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                  iconSize: 0.0,
                                  underline: SizedBox(),
                                  hint: Text("Select role"),
                                  value: gender,
                                  items: _listGender.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                ),
                              )
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Container(
                height: 75,
                // margin: new EdgeInsets.only( bottom: 10),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex:5,
                          child: Container(
                              margin: new EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: (){
                                  Utility.getInstance()!.selectDate(context, (p0) => setState(()=> dateofbirth=p0) );


                                },
                                child:  Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    margin: new EdgeInsets.symmetric(horizontal: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                    ),
                                    child: Container(
                                      margin: new EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(dateofbirth,
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.w100,
                                                    fontSize: 16,
                                                    color: Colors.black87)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(Icons.calendar_month),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                          ),
                        ),

                      ],
                    )
                )),
            Utility().textFieldCard(context, 'Input Height', false, '',false, (p0) => setState((){
              height=int.parse(p0);
            })),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          createUser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  Future createUser() async {
    final submit= FirebaseFirestore.instance.collection('users').doc();

    final user = Users(
        submit.id,
        name,
        gender,
        dateofbirth,
        height
    );
    final json = user.toJson();

    await submit.set(json);


  }
}
