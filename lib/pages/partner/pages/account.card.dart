import 'dart:convert';
import 'package:digitAT/main.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/model/ContactModel.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/models/partner/models/account_card.dart';
import 'package:digitAT/models/partner/models/confirm_booking.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/widgets/partner/widgets/doctorsWidget.dart';
import 'package:digitAT/api/doctors.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:digitAT/models/partner/models/doctor.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants.dart';

Color primaryColor = Color(0xff0074ff);

class AccountCard extends StatefulWidget {
  const AccountCard({Key key,this.patient}) : super(key:key);

  final PatientCard patient;

  @override
  _AccountCardState createState()=> _AccountCardState();
}
 class _AccountCardState extends State<AccountCard>{
    bool attended;
   String name;
   String date;
  String hour;
  String id;
  String confirmed;
  String paid;
  User user= User.init();
  ContactModel contactModel= ContactModel.init();
  final fireStoreUtils= FireStoreUtils();

Future _fetchDetails() async {

    final http.Response response = await http
        .get(
      '${webhook}crm.contact.list?filter[UF_CRM_1598992339725]=$id&select[]=UF_CRM_1603851628169',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
   
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        var id=responseBody["result"][0]['UF_CRM_1603851628169'];
 print('**********************************id $id');
      Stream<User> controller= fireStoreUtils.getUserByID(id);
       controller.listen((data) {
         setState(() {
           contactModel= ContactModel(type:ContactType.ACCEPT,user:data);
         });
         print('---------------------${contactModel.user.userID}');
        });
        
          
        } else {
          
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

 


Doctor doctor= Doctor.init();
@override
  void initState() {
  
    super.initState();
    attended=widget.patient.attended;
    name= widget.patient.name;
    date= widget.patient.date;
    hour=widget.patient.hour;
    id=widget.patient.id;
    confirmed=widget.patient.confirmed;
    paid=widget.patient.paid;
    _fetchDoctor().then((value){
      setState((){
  doctor=value;
      });
    });
  SharedPreferences.getInstance().then((SharedPreferences sp) {
      
      user=User.fromJson(jsonDecode(sp.getString('user')));

  });
  }

  Future _onContactButtonClicked(ContactModel contact) async {
    switch (contact.type) {
      case ContactType.ACCEPT:
        
       showProgress(context, 'acceptingFriendship', false);
        await fireStoreUtils.onFriendAccept(contact.user, MyAppState.currentUser);
        contact.type= ContactType.FRIEND;
        hideProgress();
        break;
      case ContactType.FRIEND:
        
        break;
      case ContactType.PENDING:
        showProgress(context, 'acceptingFriendship', false);
        await fireStoreUtils.onFriendAccept(contact.user, MyAppState.currentUser);
        contact.type= ContactType.FRIEND;
        hideProgress();
        break;
      case ContactType.BLOCKED:
      showProgress(context, 'acceptingFriendship', false);
        await fireStoreUtils.onFriendAccept(contact.user, MyAppState.currentUser);
        contact.type= ContactType.FRIEND;
        hideProgress();
        break;
      case ContactType.UNKNOWN:
        showProgress(context, 'acceptingFriendship', false);
        await fireStoreUtils.onFriendAccept(contact.user, MyAppState.currentUser);
        contact.type= ContactType.FRIEND;
        hideProgress();
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: attended ?  Colors.green: primaryColor,
      ),
      child:  Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "images/asset-2.png"),
                  ),
                ),
              ),
              GestureDetector(
        onTap: ()async{
        await  _fetchDetails();
         await _onContactButtonClicked(contactModel);
         ConfirmBooking confirmBooking= ConfirmBooking(doctor, widget.patient);

       
        if(confirmed==""){
          Navigator.of(context).pushNamed('/firstDoctorBook',arguments: confirmBooking) ;
         // await _updateAppointment();
        }else if(paid=="paid"){
        Navigator.of(context).pushNamed('/patientacc',arguments: widget.patient);
        }
        
        },
         // Navigator.of(context).pushNamed('/patientacc',arguments: widget.patient);        },
              child:
              Container(
                width: MediaQuery.of(context).size.width/3,
                child: ListTile(
                  title: Text(
                    '$name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('${date.toString()}'),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${hour.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        onPressed: (){

                      },
                      icon:(Icon(
                        Icons.check_circle,
                        size: 30,
                        color: Colors.green,
                      )
                      
                      )  ),
                      IconButton(
                    onPressed: (){

                    },
                    icon:Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.red,
                  )
                  
                  ),
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      
    );
  }
  
  Future _updateAppointment() async {


 
     final http.Response response = await http.post(
        '${webhook}tasks.task.update',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":'Doctor Appointment Booking',
   "DESCRIPTION":'',
   "UF_AUTO_831530867848":id,
   "UF_AUTO_621898573172":'',
   "UF_AUTO_229319567783": "booking",
   "UF_AUTO_206323634806":'',
   "RESPONSIBLE_ID":''
  }

}),).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
        
 
       }
       else{
         print(response.statusCode);
       }
      
  }
    Future<Doctor> _fetchDoctor() async {
//  showAlertDialog(context);
int docId;
  SharedPreferences preferences = await SharedPreferences.getInstance();
    docId= preferences.getInt("id");
  

    final http.Response response = await http
        .get(
      '${webhook}user.get.json?UF_DEPARTMENT=30&ID=$docId',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    Doctor serverResponse = Doctor.init();
    List<Doctor> _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
//        print(responseBody);
          DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
      
          doctors_list.result.forEach((user) {
            print("------\n");
            print(user.nAME);
            print("------\n");
            if(user.pERSONALPHOTO==null){
              user.pERSONALPHOTO="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            bool isFavoured= myDoctors.contains(int.parse(user.iD));
            _doctorsList.add(
              new Doctor(
                  user.nAME + " " + user.lASTNAME,
                  " ${user.pERSONALPROFESSION} 26 years of experience ",
                  user.pERSONALPHOTO,
                  "Closed To day",
                  Colors.green,
                  user.iD,isFavoured,
                  id),
            );
          });

          serverResponse = _doctorsList[0];
        } else {
          
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