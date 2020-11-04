import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:digitAT/api/doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  
  const Home( {Key key, }) : super(key: key);
 
  @override
  _HomeState createState() => _HomeState();
}

User currentUser=new User.init().getCurrentUser();


class _HomeState extends State<Home> {
  String name,city;
  @override
  void initState()  {
   SharedPreferences.getInstance().then((SharedPreferences sp) {
      setState((){
        name = sp.getString('name');
        city = sp.getString('city');
    
      });
      
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('-------------city'+city);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
     Center(
         
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child:FlatButton(
      textColor: Colors.white,
      onPressed: () {
               //Navigator.of(context).pushNamed('/account',arguments: widget.value[2]);
     },
      child: /*currentUser.name==null?Text('Update Profile'):*/Text(
                              name,
                              style: TextStyle(
                          
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
      shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
    ), 
       ),
     ),
        ],
        iconTheme: new IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).accentColor,
        title:    Text(
                          'digitAT',
                          style: TextStyle(
                            fontSize:22.0,
                            fontFamily: 'Bauhaus',
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),),
      drawer: Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: FittedBox(
                fit: BoxFit.contain,
                child: Text("digitAT",
                 style: TextStyle(
                   color: Theme.of(context).primaryColor,
                            fontSize:22.0,
                            fontFamily: 'Bauhaus',))
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
      ),
 ListTile(
            leading: Image(image: AssetImage('images/nurse.png'),),
            title:Text('Doctors'),
           onTap:(){
              Navigator.of(context).pushNamed('/doctors');
           }
          ),
           ListTile(
            leading: Image(image: AssetImage('images/pill.png'),),
            title:Text('PharmaHub'),
                onTap:(){
                  
                // Navigator.of(context).pushNamed('/pharmaPrescription');
                Navigator.of(context).pushNamed('/pharmacies',arguments: pageNav);
           }
          ),
           ListTile(
            leading: Image(image: AssetImage('images/microscope.png'),),
          onTap: (){
             Navigator.of(context).pushNamed('/imagingcentres', arguments: pageNavScan);

          },
            title:Text('ScaniT'),

          ),

           ListTile(
            leading: Image(image: AssetImage('images/Hospitals.png'),),
              onTap: (){
             Navigator.of(context).pushNamed('/hospitals');

          },
            title:Text('Hospitals'),

          ),
           ListTile(
            leading: Image(image: AssetImage('images/TheLab.png'),),
            onTap: (){
             Navigator.of(context).pushNamed('/labs', arguments: pageNavLab);

          },
            title:Text('TheLab'),

          ),
             ListTile(
            leading: Image(image: AssetImage('images/covid19-score.png'),),
            onTap: (){
             Navigator.of(context).pushNamed('/covidservices', arguments: pageNavCov);

          },
            title:Text('Cov-ID'),

          ),

           ListTile(
            leading:Image(image: AssetImage('images/MoneyTel.png'),),
            title:Text('MoneyTel'),

          ),
    ],
  ),
),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height:50.0,
                padding: const EdgeInsets.only(left:20.0,right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                  color: Theme.of(context).accentColor,
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Row(
                     children: <Widget>[
                       Text('')
                     ],
                   )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.only(left: 30.0 , right: 30.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                       
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150)),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/doctors');
                      },
                      child:ball("images/nurse.png",Theme.of(context).scaffoldBackgroundColor),
                    ),
                     FlatButton(
                       
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                      
                        borderRadius: BorderRadius.circular(150)),
                      onPressed: (){
                        // Navigator.of(context).pushNamed('/pharmaPrescription');
                        Navigator.of(context).pushNamed('/pharmaPrescription');
                      },
                      child:ball("images/pill.png",Theme.of(context).scaffoldBackgroundColor),
                    ),
                     FlatButton(
                        
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150)),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/imagingcentres', arguments: pageNavScan);
                      },
                      child:ball("images/microscope.png",Theme.of(context).scaffoldBackgroundColor),
                    ),

                  ],
                ),
              ),
            ],
          ),      
          Container(
            margin: const EdgeInsets.only(top: 6.0,bottom: 6.0),
            padding: const EdgeInsets.only(left: 30.0 , right: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Doctors",
                      style: TextStyle(
                        fontSize:12.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                     Text(
                      "Search doctors",
                      style: TextStyle(
                        fontSize:10.0,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "PharmaHub",
                      style: TextStyle(
                        fontSize:12.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    Text(
                      "Order medicine",
                      style: TextStyle(
                        fontSize:10.0,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "ScaniT",
                      style: TextStyle(
                        fontSize:12.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).focusColor
                      ),
                    ),
                    Text(
                      "Book test",
                      style: TextStyle(
                        fontSize:10.0,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            child:CarouselSlider(
              items: <Widget>[
                Container(
                  height: 200.0,
                  margin: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(width:  1.0 , color: Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image:AssetImage('images/doctor-productivity.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                ),
                Container(
                  height: 200.0,
                  margin: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                   border: Border.all(width:  1.0 , color: Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(16.0),
                     image: DecorationImage(
                      image:AssetImage('images/13nov_resize.jpg',),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                 Container(
                  height: 200.0,
                  margin: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(width:  1.0 , color: Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(16.0),
                     image: DecorationImage(
                      image:AssetImage('images/medical-lab-technician-85654102.jpg',),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: (){},
                  child: Text(
                    'Doctors near  you ',
                    style: TextStyle(
                    fontSize:12.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).focusColor
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/doctorcategories', arguments: pageNavDoc);
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                    fontSize:12.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 200.0,
            child:FutureBuilder<List<Widget>>(
                future: _fetchDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> data = snapshot.data;
                    return _doctorsListView(data);
                  } else if (snapshot.hasError) {
                    return Text("Please check your internet connection!");
                  }
                  return Container(
                      height: 80.0,
                      child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    ),
    );
  }
  Widget ball(String image,Color color){
    return Container(
      height: 80,width: 80.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  Widget ballcard(String image,Color color){
    return Container(
      height: 60,width: 60.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover,),
      ),
    );
  }
  Widget card(Doctor doctor){
    return 
     Stack(
     children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow( color: Theme.of(context).primaryColor .withOpacity(0.1), offset: Offset(0,4), blurRadius: 10)],
        ),
        width: 140.0,
        height: 140.0,
        child: GestureDetector(
          onTap: (){
                        Navigator.of(context).pushNamed('/doctorProfil', arguments: doctor);

          },
                  child: Card(
            elevation: 0.2,
            child: Wrap(
              children: <Widget>[
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 0.0,vertical:40.0),
                  child:ListTile(
                    title: Text(
                      doctor.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    subtitle: Column(
                      children: <Widget>[
                        Text(
                          doctor.profession==null?doctor.description:doctor.profession,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star,color: Colors.yellow,),
                            Text(doctor.state,style: TextStyle(fontFamily: 'Poppins',),),
                           /* IconButton(
              onPressed: () async{
                  setState(() {
                    
                     doctor.isFavorited = !doctor.isFavorited;
                     doctor.isFavorited? myDoctors.add(int.parse(doctor.userId)):
                      myDoctors.remove(int.parse(doctor.userId));
                      doctor.isFavorited
                  ? _message='added to'
                  : _message='removed from';
                     
                     });
                     //await confirmDialog(context,_message);
                     print(doctor.isFavorited);
                     },
                  
              icon:doctor.isFavorited
                  ? Icon(Icons.favorite,color:Colors.red)
                  : Icon(Icons.favorite_border),
            ),*/
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        Container(
          margin:EdgeInsets.symmetric(horizontal: 30.0,vertical:0.0),
          child:ballcard(doctor.avatar,Colors.transparent),
        ),
     ],
    );

  }
  List<Widget> _doctorsList;
   Future<List<Widget>> _fetchDoctors() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
      '${webhook}user.get.json?UF_DEPARTMENT=$doctorsId&PERSONAL_CITY=$city',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List serverResponse = [];
   _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
        
          //DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          
          //serverResponse = doctors_list.result;
          responseBody['result'].forEach((user) {
          
            print("------\n");
            print(user['NAME']);
            print("------\n");
            if(user['PERSONAL_PHOTO']==null){
              user['PERSONAL_PHOTO']="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
          bool isFavoured= myDoctors.contains(user['ID']);
            Doctor doc = Doctor.min(user['NAME']+' '+user['LAST_NAME'], user['PERSONAL_PROFESSION'], user['PERSONAL_PHOTO'], "4.2", Colors.transparent, user['ID'], user['WORK_POSITION'],isFavoured,'');
            _doctorsList.add(
               card(doc)
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

 /* Future<List<Widget>> _fetchDoctors() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get(
      '${webhook}user.get.json?UF_DEPARTMENT=$doctorsId&PERSONAL_CITY=$city',
    )
        .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List serverResponse = [];
    _doctorsList = [];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
//        print(responseBody);
          DepartmentUsers doctors_list = DepartmentUsers.fromJson(responseBody);
          serverResponse = doctors_list.result;
          doctors_list.result.forEach((user) {
            print("------\n");
            print(user.nAME);
            print("------\n");
            if(user.pERSONALPHOTO==null){
              user.pERSONALPHOTO="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU";
            }
            bool isFavoured= myDoctors.contains(user.iD);
            Doctor doc = Doctor.min(user.nAME+' '+user.lASTNAME, user.pERSONALPROFESSION, user.pERSONALPHOTO, "4.2", Colors.transparent, user.iD, user.wORKPOSITION,isFavoured,'');
            _doctorsList.add(
               card(doc)
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
  }*/

  ListView _doctorsListView(data) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: _doctorsList,
        );
  }
  
}

