import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:digitAT/models/model/ContactModel.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/models/partner/models/account_card.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:digitAT/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Color(0xff0074ff);

class AccountCard extends StatefulWidget {
  final PatientCard patient;
  const AccountCard({Key key,this.patient}) : super(key:key);
  @override
  _AccountCardState createState()=> _AccountCardState();

}
 class _AccountCardState extends State<AccountCard>{
    bool attended;
   String name;
   String date;
  String hour;
  String id;
  User user;
  ContactModel contactModel;
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

@override
  void initState() {
  
    super.initState();
    attended=widget.patient.attended;
    name= widget.patient.name;
    date= widget.patient.date;
    hour=widget.patient.hour;
    id=widget.patient.id;
  SharedPreferences.getInstance().then((SharedPreferences sp) {
      
      user=User.fromJson(jsonDecode(sp.getString('user')));

  });
  }

  Future _onContactButtonClicked(ContactModel contact) async {
    switch (contact.type) {
      case ContactType.ACCEPT:
        

        break;
      case ContactType.FRIEND:
        showProgress(context, 'removingFriendship', false);
        await fireStoreUtils.onUnFriend(contact.user);
    contact.type = ContactType.UNKNOWN;
        break;
      case ContactType.PENDING:
        showProgress(context, 'removingFriendshipRequest', false);
        await fireStoreUtils.onCancelRequest(
            contact.user);
        contact.type = ContactType.UNKNOWN;

        break;
      case ContactType.BLOCKED:
        break;
      case ContactType.UNKNOWN:
        showProgress(context, 'please wait...', false);
       print(contact.user.userID);
        await fireStoreUtils.sendFriendRequest(contact.user);
       contact.type = ContactType.PENDING;
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
          Navigator.of(context).pushNamed('/patientacc',arguments: widget.patient);        },
              child:
              Container(
                width: MediaQuery.of(context).size.width/3,
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(date),
                ),
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    hour,
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
}