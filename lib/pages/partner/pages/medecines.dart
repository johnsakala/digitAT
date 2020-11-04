import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/partner/models/medecine.dart';
import 'package:digitAT/models/partner/models/medicine_list.dart';
import 'package:digitAT/models/partner/models/pharmacist.dart';
import 'package:digitAT/models/partner/models/medecine.dart';
import 'package:digitAT/models/partner/models/medicine_list.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/medecine.dart' as model;
import 'package:digitAT/models/partner/models/user.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gradual_stepper/gradual_stepper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Medecines extends StatefulWidget {
  final MedList value;
  const Medecines({Key key, this.value}) : super(key: key);
  @override
  _MedecinesState createState() => _MedecinesState();
}

class _MedecinesState extends State<Medecines> {
  final TextEditingController _typeAheadController = TextEditingController();

  String number, aid;
  User currentUser = User.init().getCurrentUser();
  //model.MedecinesList medecinesList;
  List<Medecine> medicines = [];
  List<dynamic> allmeds = [];
  double bill = 0.0;
  List<dynamic> medicalAids = [];
  int _quantity = 0;
  int _counter = 0;

  Future<List<dynamic>> _fetchMedicines() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
          '${webhook}crm.product.list?filter[SECTION_ID]=$medId',
        )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    List<dynamic> result = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
          result = responseBody["result"];
        } else {
          print('-----------------' + response.body);
        }
      } catch (error) {
        print('-----------------' + error);
      }
    } else {
      print("Please check your internet connection ");
      Fluttertoast.showToast(
          msg: "Please check your internet connection ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 4,
          fontSize: ScreenUtil(allowFontScaling: false).setSp(16));
    }
    final http.Response aids = await http
        .get(
          '${webhook}department.get?PARENT=72',
        )
        .catchError((error) => print(error));
    Map<String, dynamic> aidsBody = jsonDecode(aids.body);
    if (aids.statusCode == 200) {
      try {
        if (aidsBody["result"] != null) {
          setState(() {
            medicalAids = aidsBody["result"];
          });
        } else {
          print('-----------------' + response.body);
        }
      } catch (error) {
        print('-----------------' + error);
      }
    } else {
      print("Please check your internet connection ");
      Fluttertoast.showToast(
          msg: "Please check your internet connection ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 4,
          fontSize: ScreenUtil(allowFontScaling: false).setSp(16));
    }
    setState(() {
      allmeds = result;
    });

    return result;
  }

  Future<List<dynamic>> _suggestMedicines(String pattern) async {
    List<dynamic> result = [];

    for (int i = 0; i < allmeds.length; i++) {
      print(pattern);
      print(allmeds[i]['NAME']);
      print(allmeds[i]['NAME'].contains(pattern, 1));

      if (allmeds[i]['NAME']
          .toLowerCase()
          .contains(pattern.toLowerCase().trim())) {
        result.add(allmeds[i]);
      }
    }
    return result;
  }

  Future<Pharmacist> _fetchPharmacist() async {
//  showAlertDialog(context);
    Pharmacist pharmacist;
    final http.Response response = await http
        .get(
          '${webhook}user.get?UF_DEPARTMENT=${widget.value.pid}',
        )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    List<dynamic> result = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
          result = responseBody["result"];
          pharmacist = Pharmacist(
              result[0]["ID"], result[0]["NAME"], result[0]["LAST_NAME"]);
          print("-----------------------------pid" + pharmacist.id);
        } else {
          print('-----------------' + response.body);
        }
      } catch (error) {
        print('-----------------' + error);
      }
    } else {
      print("Please check your internet connection ");
      Fluttertoast.showToast(
          msg: "Please check your internet connection ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 4,
          fontSize: ScreenUtil(allowFontScaling: false).setSp(16));
    }
    return pharmacist;
  }

  Pharmacist _pharmacist, officer;
  void getPharmacist() async {
    _pharmacist = await _fetchPharmacist();
  }

  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();

    setState(() {
      bill = widget.value.bill;
      medicines = widget.value.list;
      getPharmacist();
      _quantity = widget.value.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
         actions: <Widget>[
      IconButton(icon: Icon(Icons.content_paste),
      tooltip: 'Paste presciption',
      color: Theme.of(context).primaryColor,
       onPressed: (){
        Navigator.of(context).pushNamed('/prescription', arguments: _pharmacist.id);
      })
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pushNamed('/home', arguments:[currentUser.name,currentUser.phoneNumber]);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          '${widget.value.pharmacy}',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 20,
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 12.0, right: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.10),
                                    offset: Offset(0, 4),
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(children: <Widget>[
                              TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: this._typeAheadController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: 'Find medicines',
                                    hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: 'Poppins'),
                                    prefixIcon: Icon(Icons.search,
                                        size: 20,
                                        color: Theme.of(context).hintColor),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await _suggestMedicines(pattern);
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                noItemsFoundBuilder: (Object error) => ListTile(
                                    title: Text('No medicine(s) match ',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).errorColor))),
                                itemBuilder: (context, suggestion) {
                                  return 
                                      SingleChildScrollView(
                                       
                                               child:ListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  
                                                  trailing: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      IconButton(
                                                    icon: Icon(Icons.info,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                    onPressed: () async {
                                                      await confirmDialog(context,
                                                          'Approved ${suggestion["NAME"]} consumption information ');
                                                    },
                                                  ),
                                                      IconButton(
                                                        onPressed: () {
                                                          print(_pharmacist.id);
                                                          quantityDialog(
                                                              context,
                                                              suggestion['NAME'],
                                                              suggestion);
                                                        },
                                                        icon: Icon(
                                                            Icons.add_circle_outline),
                                                        color: Theme.of(context)
                                                            .accentColor
                                                            .withOpacity(0.8),
                                                        iconSize: 30,
                                                      ),
                                                    ],
                                                  ),
                                                  title: Text(
                                                    suggestion['NAME'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle:
                                                      Text(suggestion['PRICE']),
                                                )
                                      );
                                            
                                    
                                },
                                onSuggestionSelected: (suggestion) {
                                  //Navigator.of(context).pushNamed('/doctorProfil', arguments: suggestion);
                                },
                              ),
                            ]),
                          ))
                    ],
                  ),
                  /*Container(
                    padding: EdgeInsets.only(
                        top: 12.0, right: 12.0, left: 12.0, bottom: 12.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add Prescription :',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Theme.of(context).focusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 7,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${snapshot.data[index]['NAME']}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                          color: Theme.of(context).focusColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data[index]['PRICE']}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print(_pharmacist.id);
                                      setState(() {
                                        bill = bill +
                                            double.parse(
                                                snapshot.data[index]['PRICE']);
                                        medicines.add(model.Medecine(
                                            snapshot.data[index]['NAME'],
                                            snapshot.data[index]['PRICE']));
                                      });
                                    },
                                    icon: Icon(Icons.add_circle_outline),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.8),
                                    iconSize: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                              child: Center(
                                child: Container(
                                  height: 1.0,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),*/
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: _fetchMedicines(),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
            padding:
                EdgeInsets.only(right: 0.0, left: 30.0, bottom: 0.0, top: 0),
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.6)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '$_quantity medecine Added',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey),
                    ),
                    Text(
                      '\$ $bill',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RaisedButton(
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    print(_pharmacist.id);
                    MedList list = MedList.psecond(widget.value.pid, medicines,
                        bill, widget.value.pharmacy, _pharmacist.id, _quantity, widget.value.pageNav);
                    Navigator.of(context)
                        .pushNamed("/medecinesSeconde", arguments: list);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Theme.of(context).accentColor,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 45.0, right: 45.0, top: 12, bottom: 12),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<bool> confirmDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Alert'),
            content: Container(
              height: 40,
              child: Text('$message'),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).accentColor,
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> quantityDialog(
      BuildContext context, String message, dynamic suggestion) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('$message'),
            content: Container(
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Add quantity'),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GradualStepper(
                          initialValue: 0,
                          minimumValue: 0,
                          maximumValue: 100,
                          stepValue: 1,
                          onChanged: (int value) {
                            setState(() {
                              _counter = value;
                            });
                          },
                        ),
                      ),
                    ])),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).accentColor,
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).accentColor,
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    _quantity += _counter;
                  });
                  for (int i = 0; i < _counter; i++) {
                    setState(() {
                      bill = bill + double.parse(suggestion['PRICE']);
                      Medecine medecine = model.Medecine(
                          suggestion['NAME'], suggestion['PRICE']);

                      if (medicines.contains(medecine) == false) {
                        medicines.add(medecine);
                      }
                    });
                  }
                  setState(() {
                    _counter = 0;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

}
