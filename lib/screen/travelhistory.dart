import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'start.dart';
import 'package:flutter_trial_three/database/DatabaseHelper.dart';
import 'data.dart';
import 'welcome.dart';

class TravelHistoryPage extends StatefulWidget {
  static const routeName = '/travelhistory';
  @override
  _TravelHistoryPageState createState() => _TravelHistoryPageState();
}

class _TravelHistoryPageState extends State<TravelHistoryPage> {
  FocusNode myFocusNode = new FocusNode();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;

  DateTime _setDate = DateTime.now();
  int selectitem = 1;
  String dateTime;
  String valueChoose;

  List country = [
    "Algeria",
    "Philippines",
    "Indonesia",
    "Malaysia",
    "Sri Lanka",
    "Japan",
    "South Korea"
  ];

  //    function signUp btn
  void insert() async{
    Map<String, dynamic> row = {
      DatabaseHelper.c_travel_arrival_date : travelData.travel_arrival_date,
      DatabaseHelper.c_travel_departure_country : travelData.travel_country,
    };

    final id = await dbHelper.submitTravel(row);
    print("pasok na database: Id is:  $id");

  }
//  validation function
  void validation(){
    if(formkey.currentState.validate()){
      Navigator.of(context)
          .pushReplacementNamed(WelcomePage.routeName);
      insert();
    }else{
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {

    String dateTime;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,

        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Text(
                              "Travel \nHistory",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: formkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Arrival Date',
                              filled: true,
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Colors.blue
                                      : Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey[400])),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey[400])),
                            ),
                            validator: (value) {
                              if(value.toString().isEmpty){
                                return 'INVALID DATE';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              travelData.travel_arrival_date = value;
                            },
                          ),
                          //DATE PICER INSERT HERE

                          SizedBox(
                            height: 30.0,
                          ),
                          //dropdown
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Port of departure(Country)",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF8A8A8A),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 200.0),
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.black12, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField(
                              validator: (newValue) {
                                if(newValue.toString().isEmpty){
                                  return 'INVALID COUNTRY';
                                }
                                return null;
                              },
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                  travelData.travel_country = newValue;
                                });
                              },
                              items: country.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {
                            validation();
                          },
                          color: Color(0xFFFF5555),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Next",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
