
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Utility {
  static Utility? utility = null;

  static Utility? getInstance() {
    if (utility == null) {
      utility = Utility();
    }
    return utility;
  }

  Widget textFieldCard(
      BuildContext context,
      String label,
      bool password,
      String initial,
      bool isText,
      Function(String) onChange,
      ) {
    TextEditingController controller = TextEditingController(text: initial);

    // onChange(label);
    return Container(
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
            child: TextFormField(
              onChanged: (value) {
                onChange(value);
              },
              obscureText: password,
              keyboardType: isText?TextInputType.text:TextInputType.number,
              initialValue: initial,
              decoration: InputDecoration(
                labelText: label,
                fillColor: Colors.white,
                filled: true, // dont forget this line
                focusColor: Colors.blue,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),

              ),
            )));
  }

  Widget styleCard(
      BuildContext context,
      String label,
      Widget widget,
      Function(String) onChange,
      ) {

    // onChange(label);
    return Container(
        // height: 75,
        // margin: new EdgeInsets.only( bottom: 10),
        child:
        GestureDetector(
          onTap: (){
            onChange(label);
          },
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: widget,
              )),
        )
        );
  }

  Widget listCard(
      BuildContext context,
      String label,
      Widget widget,
      Function(String) onChange,
      ) {

    // onChange(label);
    return Container(
      // height: 75,
      // margin: new EdgeInsets.only( bottom: 10),
        child:
        GestureDetector(
          onTap: (){
            onChange(label);
          },
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: widget,
              )),
        )
    );
  }

  Widget buttonFull(
      BuildContext context,
      String title,
      double horizontal,
      Function(String) onPress,
      ) {
    return Padding(padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
    child: ConstrainedBox(

      constraints: BoxConstraints.tightFor(height: 50),
      child: ElevatedButton(

          onPressed: () {
            // Respond to button press
            onPress('pressed');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            // side:
          ),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width,
              margin: new EdgeInsets.symmetric(horizontal: horizontal),
              child: Center(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white))
              ))),
    ),
    );
  }


  Widget buttonFullOutline(
      BuildContext context,
      String title,
      double horizontal,
      Function(String) onPress,
      ) {

    return Padding(padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: 50),
        child: ElevatedButton(
            onPressed: () {
              // Respond to button press
              onPress('pressed');
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                width: 2.0,
                color: Colors.redAccent,
              ),
              primary: Colors.white,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              // side:
            ),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                margin: new EdgeInsets.symmetric(horizontal: horizontal),
                child: Center(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.redAccent)),
                ))),
      ),
    );
  }

  Widget buttonFullOutlineBlue(
      BuildContext context,
      String title,
      double horizontal,
      Function(String) onPress,
      ) {

    return Padding(padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: 50),
        child: ElevatedButton(
            onPressed: () {
              // Respond to button press
              onPress('pressed');
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(
                width: 2.0,
                color: Colors.blue,
              ),
              primary: Colors.white,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              // side:
            ),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                margin: new EdgeInsets.symmetric(horizontal: horizontal),
                child: Center(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue)),
                ))),
      ),
    );
  }

  selectDate(BuildContext context, Function(String) onChange) {

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

      onChange(args.value.toString().substring(0,10));
      log(args.value.toString().substring(0,10));

    }


    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                // title: const Text('Popup example'),
                content: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // margin: new EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          // margin: new EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text("CHOOSE DATE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.blue)),),
                              Container(
                                margin: new EdgeInsets.only(top: 10),
                                height: 400,
                                child: SfDateRangePicker(
                                  view: DateRangePickerView.month,
                                  onSelectionChanged: _onSelectionChanged,
                                  selectionMode: DateRangePickerSelectionMode.single,
                                  // selectionShape: DateRangePickerSelectionShape.rectangle,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Text('Save',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.w100,
                                        fontSize: 16,
                                        color: Colors.blue)),
                              )


                            ],
                          ),
                        )
                    )
                  ],
                ),

              );
            }
        );
      },
    );

  }

}