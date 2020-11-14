import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/appointment.dart';
import 'package:digitAT/widgets/my_paymentsWidget.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/appointment.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/widgets/appointmentsWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PaymentRequestList extends StatefulWidget {
  final User currentUser=User.init().getCurrentUser();
  @override
  _PaymentRequestListState createState() => _PaymentRequestListState();
}

class _PaymentRequestListState extends State<PaymentRequestList> {
  model.ApointmentList appointmentList;
  @override
  void initState() {
    this.appointmentList = new model.ApointmentList();
    super.initState();
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
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Payment Requests',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body: FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData)
      {
       
     return SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
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
                  
                  return MyPaymentsWidget(
                    appointment: snapshot.data[index],
                  );
                },
              ),
            ),
          ],
        ),      
      );
      }
      else{
        return Center(child: CircularProgressIndicator());
      }
    },
                  future: _fetchPayments()),
    );
  }
   List <Appointment>_doctorsList;
  Future<List<Appointment>> _fetchPayments() async {
//  showAlertDialog(context);
 List serverResponse = [];
 _doctorsList = [];
 SharedPreferences preferences= await SharedPreferences.getInstance();
 int id = preferences.getInt('id');
  
    final http.Response response = await http
        .get(
      '${webhook}tasks.task.list?filter[UF_AUTO_831530867848]=$id&filter[TITLE]=Appointment Confirmation&select[]=RESPONSIBLE_ID&select[]=UF_AUTO_621898573172',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
   
    var result;
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        print("**************************************"+responseBody.toString());
        
            result=responseBody['result'];
            print("/////////////////////"+result['tasks'][0]['ufAuto621898573172'].toString());
          for(int i=0;i<result['tasks'].length;i++)
          {
            Doctor doc= Doctor.app(result['tasks'][i]['responsible']['name'],result['tasks'][i]['responsible']['icon']);
            _doctorsList.add(Appointment(result['tasks'][i]['ufAuto621898573172'],doc));
          }
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
  
  serverResponse = _doctorsList;
  print(serverResponse);
    return serverResponse;
  }
  
  
}
