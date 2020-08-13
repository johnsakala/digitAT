import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/payment.dart';
import 'package:digitAT/models/pharmacist.dart';
import 'package:digitAT/models/profile.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:digitAT/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Payment extends StatefulWidget {
  final Payments payment;
  const Payment({Key key,this.payment}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Pharmacist officer;
  String aid, number;
  bool _loading = false;
  Future _createPaymentOrder() async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 //int result=0;
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":widget.payment.title,
   "DESCRIPTION":widget.payment.description+" medical aid number"+number,
   "CREATED_BY":id,
   "RESPONSIBLE_ID":officer.id
  }

}),).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           
        print('//////////////////////////////zvaita');
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }
  Future< List< dynamic >> _fetchAids() async {

    final http.Response response = await http
        .get('${webhook}department.get?PARENT=72',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
     List<dynamic> medicalAids=[]; 
    if (response.statusCode == 200) {
    

      try {
        if (responseBody["result"] != null) {
          
            medicalAids = responseBody["result"];
        
          print('********************'+medicalAids.toString());     
            
        } else {
          
          print('-----------------'+response.body);
        }
      } catch (error) {
        print('-----------------'+error);
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
    return medicalAids;
  }
    Future<Pharmacist> _fetchAidOfficer(String id) async {
//  showAlertDialog(context);
Pharmacist officer;
 
    final http.Response response = await http
        .get('${webhook}user.get?UF_DEPARTMENT=$id',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
               result = responseBody["result"];
                  officer= Pharmacist(result[0]["ID"], result[0]["NAME"], result[0]["LAST_NAME"]);            
        print('zvaita');
        } else {
          
          print('-----------------'+response.body);
        }
      } catch (error) {
        print('-----------------'+error);
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
    print('response //////////////////////////////'+result.toString());
    return officer;
  }
   Future _createTask() async {
setState(() {
  _loading=true;
});
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":widget.payment.title,
   "DESCRIPTION":widget.payment.description+" "+"payment $aid $number",
   "CREATED_BY":id,
   "RESPONSIBLE_ID":widget.payment.responsibleID
  }

}),).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           print('***********************zvaita');
        
 
       }
       else{
         print(response.statusCode);
       }
      
  }

  User currentUser=new User.init().getCurrentUser();
  Doctor currentDoctor = new Doctor.init().getCurrentDoctor();
  TextEditingController emailController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController phoneNumberController= new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Payment',
          style: TextStyle(
            fontSize:20.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body: FutureBuilder(
        future: _fetchAids(),
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData){
          return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
                
                Container(
                    padding:EdgeInsets.only(top:20.0,right: 12.0,left: 12.0,bottom: 12.0),
                    margin:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0,top: 0),
                  
                    decoration: BoxDecoration(            
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                           
                        Container(
                            height: 100.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.withOpacity(0.4)                           
                            ),
                            child:DropDownFormField(
                  titleText: 'Medical Aid',
                  value: aid,
                  onSaved: (value)async {
                    officer= await _fetchAidOfficer(value);
                    setState(() {
                      aid = value;
                    });
                  },
                  onChanged: (value) async {
                   officer= await _fetchAidOfficer(value);
                    setState(() {
                     aid = value;
                    });
                  },
                  dataSource: [
                         {
                          "display": "${snapshot.data[0]['NAME']}",
                      "value": "${snapshot.data[0]['ID']}",
                         },
                           {
                          "display": "${snapshot.data[1]['NAME']}",
                      "value": "${snapshot.data[1]['ID']}",
                         }
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
                          ),
                
      Container(
                            height: 100.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.withOpacity(0.4)                          
                            ),
                            child:
                            
                            TextFormField(
                                  decoration: InputDecoration(
                               labelText: 'Medical aid Number'
                                            ),
                                            
                             onChanged: (value){
                               setState(() {
                                 number=value;
                               });  
                               },     
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'Number can not be empty!';
                         }
                             return null;
                                  },
                            )),
                        SizedBox(height: 25.0,),
                      
                  
                      ]),
                )],
            ),
        
      );
      }
      else{
        return Center(child:CircularProgressIndicator()) ;
      }
      
        }),
        bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
              padding:EdgeInsets.only(right: 0.0,left: 50.0,bottom: 0.0,top: 0),
              margin:EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Give Feedback',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  _loading? CircularProgressIndicator(): RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async{
                       await _createTask();
                       await _createPaymentOrder();
                        SharedPreferences preferences= await SharedPreferences.getInstance();
                       int id= preferences.getInt('id');
                       String name= preferences.getString('name');
                       String city= preferences.getString('city');
                       
                       Profile profile=Profile.min(id, name, city);
                           
                       await confirmDialog(context);
                        Navigator.of(context).pushNamed("/home",arguments:[profile.name,profile.id,profile.city]);
                     /*  if(result!=null){
                       print('*********************************appointment created');
                      }*/
                      
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 55.0,right: 55.0,top: 12,bottom: 12),
                      child:Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
      ));
  }
  Future<bool> confirmDialog(BuildContext context) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Confirmation'),
            content: Container(
              height: 85,
              child:Text('${widget.payment.title} completed successfully'),
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

  Future <int>_createDeal(String g, String name, String lname, String city, String phoneNumber, DateTime dob) async {

  int result=0;
    final http.Response response = await http.post(
        '${webhook}crm.contact.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
         "fields":{  "TITLE": "digitAT", 
                    "NAME": name, 
                    "SECOND_NAME": " ", 
                    "LAST_NAME": lname, 
                     
                    "OPENED": "Y", 
                    "ASSIGNED_BY_ID": 1, 
                    "PHONE": [ { "VALUE": phoneNumber, "VALUE_TYPE": "WORK" } ] 
       }
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
        
        
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
       }
       else{
         print(response.statusCode);
       }
       return result;
  }

}