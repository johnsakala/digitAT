import 'dart:convert';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:digitAT/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DoctorBookSecondeStep extends StatefulWidget {
  final List<dynamic> value;
  const DoctorBookSecondeStep({Key key,this.value}) : super(key: key);
  @override
  _DoctorBookSecondeStepState createState() => _DoctorBookSecondeStepState();
}

class _DoctorBookSecondeStepState extends State<DoctorBookSecondeStep> {

  String aid, number;
  Future< List< dynamic >> _fetchAids() async {

    final http.Response response = await http
        .get('https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/department.get?PARENT=72',
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
   Future _createAppointment() async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  String id= preferences.getString('id');
 
     final http.Response response = await http.post(
        'https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":"appointment booking",
   "DESCRIPTION":widget.value[1]+ " "+ nameController.text+" "+ emailController.text+" "+ phoneNumberController.text+" "+"payment $aid $number",
   "CREATED_BY":id,
   "RESPONSIBLE_ID":widget.value[0].userId
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
          'Select a time slot',
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
                            ball(widget.value[0].avatar, Colors.transparent),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.value[0].name,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child:Text(
                                    widget.value[0].description,
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
                                    "Tomorrow ${widget.value[1]}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 60.0,width:2,child: Center(child: Container(height: 60.0,color: Colors.grey.withOpacity(0.1),),),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Consultation Fees",
                                     style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  Text(
                                    "600\$",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,child: Center(child: Container(height: 2.0,color: Colors.grey.withOpacity(0.1),),),),
                        Container(
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
                              initialValue: '',//for testing
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
                              initialValue: '',//for testing
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
                              initialValue: '',//for testing
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
                            child:DropDownFormField(
                  titleText: 'Medical Aid',
                  value: aid,
                  onSaved: (value) {
                    setState(() {
                      aid = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                     aid = value;
                    });
                  },
                  dataSource: [
                         {
                          "display": "${snapshot.data[0]['NAME']}",
                      "value": "${snapshot.data[0]['NAME']}",
                         },
                           {
                          "display": "${snapshot.data[1]['NAME']}",
                      "value": "${snapshot.data[1]['NAME']}",
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
      );
      }
      else{
        return CircularProgressIndicator();
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
                  RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async{
                       await _createAppointment();
                        SharedPreferences preferences= await SharedPreferences.getInstance();
                       String id= preferences.getString('id');
                     /*  if(result!=null){
                       print('*********************************appointment created');
                      }*/
                      Navigator.of(context).pushNamed("/account",arguments:int.parse(id));
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
}