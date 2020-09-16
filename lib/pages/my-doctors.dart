import 'dart:convert';

import 'package:digitAT/api/doctors.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/data/app_database.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/doctor.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:digitAT/widgets/myDoctorsWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class MyDoctorsList extends StatefulWidget {
 
  @override
  _MyDoctorsListState createState() => _MyDoctorsListState();
}

class _MyDoctorsListState extends State<MyDoctorsList> {
  model.DoctorsList doctorsList;
  List<int> list=[];
  List myDocs=[];

 Future<List> _getList()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String list= preferences.getString('docs');
    List result= jsonDecode(list);
    return result;
  }
  @override
  void initState() {
    super.initState();
    _getList().then((value) {
      print(value);
      setState(() {
        myDocs.addAll(value);
      });
      
    });
  
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(16.0),bottomRight: Radius.circular(16.0)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'My Doctors',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body:   SingleChildScrollView(
        child: Column(
          children: <Widget>[
               SizedBox(height: 20,),
                FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot){
       
       if(snapshot.hasData){
      return Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child:   Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(            
               color: Colors.transparent,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.length,
                separatorBuilder: (context,index){
                  return SizedBox(height: 4.0);
                },
                itemBuilder: (context,index){
                  return MyDoctorsCardWidget(
                    doctors: snapshot.data[index],
                  );
                },
              ),
            ),
          
        );      
       
       }
      else{
       return Center(child:CircularProgressIndicator(backgroundColor: Theme.of(context).accentColor,));
      }
      
      },
     future: _fetchDoctors() ,
    ), 

    Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(            
               color: Colors.transparent,
              ),
              child: Container(
                    margin: EdgeInsets.only(right:30.0,left: 30.0 ),
                    height: 60,
                                            
                              child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: (){
                      Navigator.of(context).pushNamed('/doctorcategories', arguments: pageNavDoc);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(child:Container(
                        child:  Center(
                          child:Text(
                            'Add Doctors', 
                            style:  TextStyle(
                              fontSize: 18.0, 
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),  
                        ),
                      )
                      ),   
                    ),
                            ),
            )
              ])
     ));
  
  }
  List<Doctor> _doctorsList;
 
  Future<List<Doctor>> _fetchDoctors() async {
//  showAlertDialog(context);
 List serverResponse = [];
 _doctorsList = [];
        
  for(int i=0; i<myDocs.length;i++){
   final http.Response response = await http
        .get(
      '${webhook}user.get.json?&ID=${myDocs[i]}',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
   
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        
          //DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          
          //serverResponse = doctors_list.result;
          responseBody['result'].forEach((user) {
            print("/*/*/*/*/*/*/*/*/*/*/*/* user");
            print("------\n");
            print(user['NAME']);
            print("------\n");
            if(user['PERSONAL_PHOTO']==null){
              user['PERSONAL_PHOTO']="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
           _doctorsList.add(
                Doctor.min(user['NAME']+' '+user['LAST_NAME'], user['WORK_POSITION'], user['PERSONAL_PHOTO'], "4.2", Colors.transparent, user['ID'], user['PERSONAL_PROFESSION'],false,'')
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
  }
  serverResponse = _doctorsList;
  print('*************************response'+serverResponse.toString());
    return serverResponse;
  }
 /* final database= AppDatabase();
 Future<List<int>> getDoctors() async{
 var list ;
  list= await database.getList();
  print('***********************************************************'+list);
  return jsonDecode(list);
  }*/
  
  
}
