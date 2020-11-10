import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:digitAT/api/doctors.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/partner/models/medicine_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/models/partner/models/doctor.dart';
import 'package:digitAT/models/partner/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:digitAT/models/partner/models/payment.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookTestsOnlineThirdStep extends StatefulWidget {
  final MedList value;
  const BookTestsOnlineThirdStep( {Key key, this.value}) : super(key: key);
  @override
  _BookTestsOnlineThirdStepState createState() => _BookTestsOnlineThirdStepState();
}

class _BookTestsOnlineThirdStepState extends State<BookTestsOnlineThirdStep> {
  List<String> morningList=["08.00","09.00","10.00","11.00","12.00"];
  List<String> afternoonList=["13.00","14.00","15.00","16.00","17.00","18.00",];
  List<String> nightList=["19.00","20.00","21.00","22.00","23.00","00.00"];
  String selectedChoice = "";
  String _userId;
  var newFormat = DateFormat("dd-MMM-yyyy");
  DateTime _selectedValue = DateTime.now();
  DatePickerController _controller = DatePickerController();
  User currentUser=new User.init().getCurrentUser();
  Doctor currentDoctor = new Doctor.init().getCurrentDoctor();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(16.0),bottomRight: Radius.circular(16.0)),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor )
              
             
         ,
          onPressed: (){
            Navigator.of(context).pop();
            //Navigator.of(context).pushNamed('/secondeBookTest');
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          widget.value.pharmacy,
          style: TextStyle(
            fontSize:18.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body:FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot){
       if(snapshot.hasData){
      return  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child:Center(
                    child:Container(
                      padding: const EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0,bottom:20) ,
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 25,width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),

                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: Text(
                              "1",
                               style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 50,
                            height: 3,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Container(
                          height: 25,width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                               style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 50,
                            height: 3,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Container(
                          height: 25,width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8)),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              "3",
                               style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                            ),
                          ),
                        ),
                     
                        
                      ],
                    )),
                  ),
            ),
            Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              margin:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0),
              width: double.maxFinite,
              decoration: BoxDecoration(            
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ball(snapshot.data[0].avatar, Colors.transparent),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data[0].name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 200,
                            child:Text(
                             snapshot.data[0].profession==null?"Radiographer":snapshot.data[0].profession,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                color:Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                 
                  SizedBox(height: 15.0,),
             
              Container(
                 height: 90,
                child: DatePicker(
                  DateTime.now(),
                  width: 60,
                  height: 70,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
               
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                       
                    });
                  },
                ),
              ),
               SizedBox(height: 10.0,),
               Text('Date: '+ newFormat.format( _selectedValue),
               style: TextStyle(
            fontSize:15.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            
          ),),
               SizedBox(height: 15.0,),
                  SizedBox(height: 15.0,),
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8)),
                            color: Colors.grey[200].withOpacity(0.6),
                          ),
                          child: Wrap(
                            children: _buildChoiceList(morningList),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6,bottom: 6,left: 16,right: 16,),
                          margin: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Colors.grey,
                            gradient: LinearGradient(
                              colors: [Colors.red[200],Colors.blue[200]],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0,1.0],
                              tileMode: TileMode.clamp,
                            )
                          ),
                          child: Text(
                            "Morning",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8)),
                            color: Colors.grey[200].withOpacity(0.6),
                          ),
                          child:Wrap(
                            children: _buildChoiceList(afternoonList),
                          ), 
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6,bottom: 6,left: 16,right: 16,),
                          margin: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Colors.grey,
                            gradient: LinearGradient(
                              colors: [Colors.lightBlue[200],Colors.lightGreen[200]],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0,1.0],
                              tileMode: TileMode.clamp,
                            )
                          ),
                          child: Text(
                            "Afternoon",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: Colors.grey.withOpacity(0.8)),
                            color: Colors.grey[200].withOpacity(0.6),
                          ),
                          child:Wrap(
                            children: _buildChoiceList(nightList)
                              
                          ) 
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6,bottom: 6,left: 16,right: 16,),
                          margin: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //color: Colors.grey,
                            gradient: LinearGradient(
                             colors: [Colors.yellow[100],Colors.green[200]],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0,1.0],
                              tileMode: TileMode.clamp,
                            )
                          ),
                          child: Text(
                            "Evening & Night",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
       }
      else{
       return Center(child:CircularProgressIndicator());
      }
      },
     future: _fetchDoctors() ,
    ),
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
                        '${widget.value.list.length} test Added',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        '\$ ${widget.value.bill}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async{
                      if(selectedChoice==""){
                       await errorDialog(context);
                      }else{
                      //Navigator.of(context).pushNamed("/fourthBookTest");
                      Payments payments= Payments('Scan Prescription',widget.value.list.toString(), widget.value.pharmacistID,widget.value.list, widget.value.bill,DateTime.now(), widget.value.responsibleId);
                     await _createPresciption(payments);
                      await confirmDialog( context, 'Prescription created');
                      Navigator.of(context).pushNamed('/patientacc');  
                    
                    }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                        'Continue',
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
      ),
    );
  }
  Widget ball(String image,Color color){
    return Container(
      height: 60,width: 60.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: Image.network(image).image, fit: BoxFit.cover,)

      ),
     
    );
  }
  _buildChoiceList(List<String> list) {
    List<Widget> choices = List();    
    list.forEach((item) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(item),
            selected: selectedChoice == item,
            onSelected: (selected) {
                setState(() {
                selectedChoice = item;
              });
            },
            
          ),
        )
      );
    }
    );return choices;
  }
  List<Doctor> _doctorsList;
  Future<List<Doctor>> _fetchDoctors() async {
//  showAlertDialog(context);
 List serverResponse = [];
 _doctorsList = [];
 
  
    final http.Response response = await http
        .get(
      '${webhook}user.get.json?UF_DEPARTMENT=${widget.value.pid}',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
   
    
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
       print(responseBody);
          DepartmentUsers doctorsList = DepartmentUsers.fromJson(responseBody);
          serverResponse = doctorsList.result;
          doctorsList.result.forEach((user) {
            print("------\n");
            print(user.nAME);
            
            print("------\n");
            if(user.pERSONALPHOTO==null){
              user.pERSONALPHOTO="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            setState(() {
              _userId=user.iD;
            });
            _doctorsList.add(
                Doctor.min(user.nAME+' '+user.lASTNAME, user.wORKPOSITION, user.pERSONALPHOTO, "4.2", Colors.transparent, user.iD, user.pERSONALPROFESSION,false)
            );
            
          });

          
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
  print("//////////////////////"+serverResponse.toString());
    return serverResponse;
  }
   Future<bool> errorDialog(BuildContext context) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Error',
            style: TextStyle(
             color: Colors.red 
            ),),
            content: Container(
              height: 40,
              child:Text('Please select a timeslot before proceeding!',
            style: TextStyle(
             color: Colors.red 
            ),),
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

  Future<bool> confirmDialog(BuildContext context,String message) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Confirmation'),
            content: Container(
              height: 85,
              child:Text('$message'),
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

   Future _createPresciption(Payments payments) async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 //int result=0;
 
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":payments.title,
   "DESCRIPTION":payments.description,
   "UF_AUTO_831530867848":widget.value.pageNav.patientId,
   "UF_AUTO_197852543914":payments.medicines,
  
   "UF_AUTO_229319567783":"prescription",
   "RESPONSIBLE_ID":widget.value.pageNav.docName
  }

})).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           
        print('//////////////////////////////zvaita'+responseBody.toString());
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }
}