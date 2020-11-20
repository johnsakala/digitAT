import 'dart:convert';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:digitAT/models/medecine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/doctor.dart' as model;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScanPrescription extends StatefulWidget{

  @override
  ScanPrescriptionState createState()=> ScanPrescriptionState();
}

class ScanPrescriptionState extends State<ScanPrescription>{

  TextEditingController searchDoctorController = new TextEditingController();
String searchString, id;
   @override
  void initState(){
  super.initState();
   SharedPreferences.getInstance().then((SharedPreferences sp) {
     setState(() {
     id= sp.getString('id');
     });
   });
  }
    
    model.DoctorsList doctorsList;
  

  String number, aid;
  
  //model.MedecinesList medecinesList;
  List<Medecine> medicines = [];
  List<dynamic> allmeds = [];
  double bill = 0.0;
  List<dynamic> medicalAids = [];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Presciptions',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 20,
                  padding:
                  const EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                    color: Theme.of(context).accentColor,
                  ),
                ),
               
              ],
            ),
            Container(
                  margin: EdgeInsets.only(top: 5.0,bottom: 10.0,right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 20)
                    ],
                  ),
                  child: Center(
                    child:Text('My Prescriptions ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.underline
                  ),))
                ),
          
            Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: FutureBuilder<List<Doctor>>(
                    future: _fetchPrescriptions(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Doctor> data = snapshot.data;
                        print("*-*-*-*-*-*-*-*-*-*-*-*-"+snapshot.data[0].resId);
                        return _jobsListView(data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(child:CircularProgressIndicator());
                    })),
                
          ],
        ),
      ),
    );
  }
   Future<List<Doctor>> _fetchPrescriptions() async {

    final http.Response response = await http
        .get(
          
      '${webhook}tasks.task.list?filter[UfAuto831530867848]=$id&filter[TITLE]="Scan Prescription"',
    )
             .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List serverResponse = [];
    List<Doctor> _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        
          //DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          
          //serverResponse = doctors_list.result;
          responseBody['result'].forEach((user) {
            print("/*/*/*/*/*/*/*/*/*/*/*/* prescription");
            print("------\n");
            print(user['TITLE']);
            print("------\n");
           
            
            _doctorsList.add(
              new Doctor(
                  user['TITLE'] ,
                  " ",
                  user['TITLE'],
                  "",
                  Colors.green,
                  user['ID'],false,
                  '1'),
            );
          });

          serverResponse = _doctorsList;
          
        } else {
          serverResponse = [];
          print(response.body);
        }
      } catch (error) {
        print(error);
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
    return serverResponse;
  }
}

ListView _jobsListView(data) {
  return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 4.0);
      },
      
      itemBuilder: (context, index) {

 return  GestureDetector(
   onTap: (){
     Navigator.of(context).pushNamed('/imagingcentres', arguments: pageNav);
   },
    child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 12.0,right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${data.elementAt(index).name}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            color: Theme.of(context).focusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                      ],
                    ),
                    Text(
                      'Prescription',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: (){
                   confirmDialog( context, "Prescription created by ${data.elementAt(index)['RESPONSIBLE_ID']}!");
                  },
                  icon: Icon(Icons.info),
                  color: Colors.blue.withOpacity(0.8),
                  iconSize: 30,

                )
              ],
            ),
          ),
          SizedBox(height: 15.0,child: Center(child: Container(height: 1.0,color: Colors.grey.withOpacity(0.1),),),),
        ],
      ),
 );
        
       


      });

}
  Future<bool> confirmDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Message'),
            content: Container(
              height: 60,
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
