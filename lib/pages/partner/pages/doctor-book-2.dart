import 'dart:convert';

import 'package:digitAT/models/partner/models/doc_booking.dart';
import 'package:digitAT/models/partner/models/medecine.dart';

import 'package:digitAT/models/partner/models/payment.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:digitAT/models/partner/models/doctor.dart';
import 'package:digitAT/models/partner/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DoctorBookSecondeStep extends StatefulWidget {
  final DoctorBooking value;
  const DoctorBookSecondeStep({Key key,this.value}) : super(key: key);
  @override
  _DoctorBookSecondeStepState createState() => _DoctorBookSecondeStepState();
}

class _DoctorBookSecondeStepState extends State<DoctorBookSecondeStep> {

  String aid, number, name='',phone='',email='';
  bool _loading = false;

 

  User currentUser=new User.init().getCurrentUser();
  Doctor currentDoctor = new Doctor.init().getCurrentDoctor();
  TextEditingController emailController= new TextEditingController();
  TextEditingController nameController= new TextEditingController();
  TextEditingController phoneNumberController= new TextEditingController();
 var newFormat = DateFormat("dd-MMM-yyyy");
  
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
          'Select a time slot',
          style: TextStyle(
            fontSize:20.0,
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
                    height: 40,
                    padding: const EdgeInsets.only(left:0.0,right: 0.0,bottom: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                      color: Theme.of(context).accentColor,
                    ),   
                  ),
                Container(
                    padding:EdgeInsets.only(top:20.0,right: 12.0,left: 12.0,bottom: 12.0),
                    margin:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0,top: 0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(            
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                           // ball(widget.value.cbooking.doctor.avatar, Colors.transparent),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("",
                                 // widget.value.doctor.name,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child:Text("",
                                   // widget.value.doctor.description,
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
                        SizedBox(height: 20.0,child: Center(child: Container(height: 2.0,color: Colors.grey.withOpacity(0.1),),),),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "DATE & Time",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  Text(
                                    "${newFormat.format(widget.value.date)} ${widget.value.timeSlot}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 60.0,width:2,child: Center(child: Container(height: 60.0,color: Colors.grey.withOpacity(0.1),),),),
          
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,child: Center(child: Container(height: 2.0,color: Colors.grey.withOpacity(0.1),),),),
                        /*Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                            height: 50.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Color(0xdddddddd)),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey[100].withOpacity(0.4),
                            ),
                            child:FormBuilderTextField(
                              attribute: "Full Name",
                              controller: nameController,
                              initialValue: name,//for testing
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins'

                                ),
                                border: InputBorder.none,

                              ),

                              validators: [
                                FormBuilderValidators.max(70),
                                FormBuilderValidators.required(),
                              ],
                            ), 
                          ),
                            Container(
                            height: 50.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Color(0xdddddddd)),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey[100].withOpacity(0.4),
                            ),
                            child:FormBuilderTextField(
                              attribute: "Email",
                              controller:emailController ,
                              initialValue: email,//for testing
                              decoration: InputDecoration(
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins'

                                ),
                                border: InputBorder.none,

                              ),

                              validators: [
                                FormBuilderValidators.max(70),
                                FormBuilderValidators.required(),
                              ],
                            ), 
                          ),
                            Container(
                            height: 50.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Color(0xdddddddd)),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey[100].withOpacity(0.4),
                            ),
                            child: FormBuilderTextField(
                              attribute: "phone Number",
                              controller: phoneNumberController,
                              initialValue: phone,//for testing
                              decoration: InputDecoration(border: InputBorder.none,hintText: "Phone Number",hintStyle: TextStyle(fontFamily: 'Poppins'),prefixText: "+",),
                              keyboardType: TextInputType.number,
                              validators: [
                                //FormBuilderValidators.numeric(),
                                FormBuilderValidators.required(),
                              ],
                            ),
                          ),
                          ],
                        ),
                      ),*/
                     
     
                        SizedBox(height: 25.0,),
                        Container(
                          child: Text(
                            "By Booking this appointment you agree to the T&C",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'
                            ),

                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
                      
                     /*  if(result!=null){
                       print('*********************************appointment created');
                      }*/
                      Medecine medecine= Medecine("Doctor Booking", "");
                     List<Medecine>  list=[];
                     list.add(medecine);
                     List <String> medNames=[];
                     for(int i=0;i<list.length;i++){
                       medNames.add(list[i].name);
                     }
                      //Payments payments= Payments("Doctor Appointment Booking", widget.value.timeSlot+ " "+newFormat.format(widget.value.date), widget.value.doctor.userId,list,600.0, widget.value.date, widget.value.doctor.resId, medNames);
                      await confirmDialog( context, 'Doctors booking');
                      Navigator.of(context).pushNamed('/patientacc');  
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 55.0,right: 55.0,top: 12,bottom: 12),
                      child:Text(
                        'Book',
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
  Widget ball(String image,Color color){
    return Container(
      height: 60,width: 60.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover,)
      ),
    );
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
              child:Text('$message '),
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
}