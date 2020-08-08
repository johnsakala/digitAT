
import 'dart:convert';
import 'dart:io';
import 'package:digitAT/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AcountWidget extends StatefulWidget {

  final int acountInfos;

  const AcountWidget({Key key, this.acountInfos}) : super(key: key);
  @override
  _AcountWidgetState createState() => _AcountWidgetState();
}

class _AcountWidgetState extends State<AcountWidget> {
  
    List<dynamic> _user= [];
  String fullname; 
  void _getResults() async{
      _user= await _fetchUser(this.widget.acountInfos);
   await setId(_user[0]['ID']);
   await setCity(_user[0]['PERSONAL_CITY']);
   await setName(_user[0]['NAME']+" "+_user[0]['LAST_NAME']);
    print('**********************'+_user[0]['NAME']);
  }


  setCity(String city)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("city", city);

  }
  setId(String id)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("id", id);

  }
    setName(String name)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("name", name);

  }
  @override
  void initState(){
    super.initState();
     _getResults();
  
    
   }
   
  User currentUser = new User.init().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
      if(snapshot.hasData)
      {
     return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(  
              height: 220.0,
              padding:EdgeInsets.all(7.0),
              margin:EdgeInsets.only(top: 40.0,left: 3.0,right: 3.0),
              decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16.0),
               color: Theme.of(context).accentColor,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top:6.0),
                    child:FlatButton(
                     child:Icon(Icons.edit,size: 25,
                        color: Theme.of(context).accentColor
                    ),
                     onPressed: (){
                       
                     },
                    
                    ),
                  ),    
                  Container(
                      
                      child: Column(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ball('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU', Colors.transparent),
                         Expanded(
                          
                           child: Row(
                       mainAxisAlignment:  MainAxisAlignment.center,
                              children: <Widget>[

                           Text("${snapshot.data[0]['NAME']+' '+snapshot.data[0]['LAST_NAME']}",
                           style:TextStyle(color:Theme.of(context).primaryColor,
                           fontSize: 19.0,
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.bold),
                           ),
                        
                            
                              ],
                            ),
                         ),
                         
                             Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                           Icon(Icons.phone,
                                color:Theme.of(context).primaryColor),
                          Text("${snapshot.data[0]['PERSONAL_PHONE']}",
                              style:TextStyle(color:Theme.of(context).primaryColor,
                              fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
                         ],),  
                         SizedBox(
                             height: 30.0, 
                            ),
                           
                        ],
                      ),
                    ),
                  
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top:12.0),
                    child:FlatButton(
                      child:Icon(Icons.edit,size: 25,
                        color: Theme.of(context).primaryColor
                    ),
                    onPressed: (){
                      Profile profile= Profile(snapshot.data[0]['ID'], snapshot.data[0]['NAME'], snapshot.data[0]['LAST_NAME'], snapshot.data[0]['PERSONAL_PHONE'], snapshot.data[0]['PERSONAL_CITY']);
                       Navigator.of(context).pushNamed('/editAcount',arguments: profile);
                    },),
                  ),
                    
                        
                 
                ],
              ),
              
            ),
            Container(
              padding:EdgeInsets.all(12.0),
              margin:EdgeInsets.all(12.0),
              decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16.0),
               border: Border.all(width: 1,color: Colors.grey.withOpacity(0.2)),
               color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: <Widget>[
                  _dropDownListe(Icon(Icons.bubble_chart,color: Theme.of(context).accentColor,),'My Doctors',1,'/mydoctors',context),
                  _dropDownListe(Icon(Icons.calendar_today,color: Theme.of(context).accentColor,),'Appointments',1,'/appointment',context),
                  _dropDownListe(Icon(Icons.card_giftcard,color: Theme.of(context).accentColor,),'Health Interest',1,'/health',context),
                  _dropDownListe(Icon(Icons.payment,color: Theme.of(context).accentColor,),'My Payments',1,'',context),
                  _dropDownListe(Icon(Icons.local_offer,color: Theme.of(context).accentColor,),'Offers',1,'/offers',context),
                  _dropDownListe(Icon(Icons.arrow_upward,color: Theme.of(context).accentColor,),'Logout',0,'/signup',context),

                ],
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
                  future: _fetchUser(widget.acountInfos)),
    
  
   ); 
}
Widget _dropDownListe(Icon icon ,String title,double borderWidth,String route,BuildContext context){
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom:BorderSide(width: borderWidth ,color: Colors.grey.withOpacity(0.2))),
    ),
    child: FlatButton(
      onPressed: (){
        Navigator.of(context).pushNamed(route);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 25.0),
                child: icon,
              ),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,

                  ),

                ),
              ),
            ],
          ),
          Container(
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
Future< List< dynamic >> _fetchUser(accountInfos) async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
      'https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/user.get?ID=$accountInfos',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
         
      result = 
      responseBody["result"];
         // result= serverResponse.result;
   
        
          
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
    return result;
  }

Widget ball(String image,Color color){
    return Container(
      height: 90,width: 90.0,
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image:Image.network(image).image, fit: BoxFit.cover,
        ),
      ),
    );
  }
}