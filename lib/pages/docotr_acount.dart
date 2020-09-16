import 'dart:convert';

import 'package:digitAT/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:digitAT/models/doctor.dart';
import 'package:digitAT/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DoctorAcount extends StatefulWidget {
  final Doctor doctor;
  const DoctorAcount({Key key,this.doctor}) : super(key: key);
  @override
  _DoctorAcountState createState() => _DoctorAcountState();
}
class _DoctorAcountState extends State<DoctorAcount> {
  Doctor currentDoctor = new Doctor.init().getCurrentDoctor();
  User currentUser = new User.init().getCurrentUser();
  String _message;
  @override
  Widget build(BuildContext context) {
      print('----------------'+ widget.doctor.resId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
              color:Theme.of(context).primaryColor
          ),
          onPressed: (){
           //Navigator.of(context).pushNamed("/doctors");
           Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Doctor',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(top:40,left:12.0,right: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      
                      padding:EdgeInsets.all(26.0),
                      margin:EdgeInsets.only(top: 33.0,left: 14.0,right: 14.0),
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20.0),
                       boxShadow: [BoxShadow( color: Colors.grey .withOpacity(0.4), offset: Offset(2,4), blurRadius: 10)],
                       color: Theme.of(context).primaryColor,
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Prime",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Text("4.0",style: TextStyle(fontFamily: 'Poppins',color: Colors.grey,),),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Text(
                                "${widget.doctor.name}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color:Theme.of(context).hintColor,
                                ),
                              ),
                              Center(
                                child:Text(
                                  "${widget.doctor.description}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "16 yrs.Experience",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  color:Theme.of(context).hintColor,
                                ),
                              ),
                             widget.doctor.resId==''? IconButton(
              onPressed: () async{
                  setState(() {
                    
                     widget.doctor.isFavorited= !widget.doctor.isFavorited;
                     widget.doctor.isFavorited? myDoctors.add(int.parse(widget.doctor.userId)):
                      myDoctors.remove(int.parse(widget.doctor.userId));
                      widget.doctor.isFavorited
                  ? _message='added to'
                  : _message='removed from';
                     print(myDoctors);
                     });
                     await persistDoctors(myDoctors);
                     await confirmDialog(context,_message);
                     },
                  
              icon:widget.doctor.isFavorited
                  ? Icon(Icons.favorite,color:Colors.red)
                  : Icon(Icons.favorite_border),
            ):SizedBox(),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(height: 60,width: 60,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),image:DecorationImage(image:AssetImage('images/Image 11.png'),
                                      fit: BoxFit.cover,)),),),
                              SizedBox(height: 60,width: 60,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),image:DecorationImage(image:AssetImage('images/Image 12.png'),
                                      fit: BoxFit.cover,)),),),
                              SizedBox(height: 60,width: 60,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),image:DecorationImage(image:AssetImage('images/Image 19.png'),
                                      fit: BoxFit.cover,)),),),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(image: NetworkImage(widget.doctor.avatar),
                                     fit: BoxFit.cover,
      ),
                                  ),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Theme.of(context).accentColor.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+7",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(child:ball(widget.doctor.avatar, Theme.of(context).primaryColor,)),
                  ],
                ),
              ],
            ),
            Container(
              padding:EdgeInsets.all(26.0),
              width: double.maxFinite,
              margin:EdgeInsets.only(top: 30.0,left: 14.0,right: 14.0,bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [BoxShadow( color: Colors.grey.withOpacity(0.4), offset: Offset(2,4), blurRadius: 10)],
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "In clinic : 10\$",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color:Theme.of(context).hintColor,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5,color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          onPressed: (){

                          },
                          child: Text(
                            'Book',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ), 
                      ),
                               
                    ],
                  ),
                  SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[400].withOpacity(0.1),),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Closed To Day',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '9:30AM - 8:00PM',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color:Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        'All Timing',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[400].withOpacity(0.1),),)),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on,color:Theme.of(context).hintColor.withOpacity(0.5),),
                      Text(
                        '92/3rd Floor, outer Ring Road,\nChandra Layout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0,),
                 widget.doctor.resId==''?  SizedBox(
                    height: 120,
                    width: double.maxFinite,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image:DecorationImage(
                          image:AssetImage('images/gps.png'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ):SizedBox(),
                  SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[400].withOpacity(0.1),),)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                   widget.doctor.resId==''? Text(
                      'FEEDBACK',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Colors.grey,

                      ),
                    ):SizedBox(),
                    widget.doctor.resId==''?Text(
                      'Very good,courteous and efficient staff',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        //fontWeight: FontWeight.bold,
                        color:Theme.of(context).hintColor,
                      ),
                    ):SizedBox(),
                    ],
                  ),
                  SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[400].withOpacity(0.1),),)),
                  Text(
                    'SPECIALIZATION',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6.0,),
                  Text(
                    'Dermitologist',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color:Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: 6.0,),
                  Text(
                    'Trichologist',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color:Theme.of(context).hintColor,
                      ),
                  ),
                  SizedBox(height: 6.0,),
                  Text(
                    'Cosmetologist',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color:Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[400].withOpacity(0.1),),)),
                 widget.doctor.resId==''? Text(
                    'ALSO PRACTICES AT',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ):SizedBox(),
                  SizedBox(height: 6.0,),
                  widget.doctor.resId==''?Column(
                    children: <Widget>[
                      card("images/asset-2.png","Dr.Mickel Nick","B.Sc DDVL Demilitologist","4.2"),
                      SizedBox(height: 30.0,child: Center(child: Container(height: 1.0,color: Colors.grey[350].withOpacity(0.1),),)),
                      card("images/asset-3.png","Dr.Steve Robert","B.Sc DDVL Demilitologist","3.6"),
                    ],
                  ):SizedBox(),
                ],
              ),
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
                        'GIVE FEEDBACK',
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
                    onPressed: (){
                      Navigator.of(context).pushNamed("/firstDoctorBook", arguments: widget.doctor);
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
      ),
      
    );
  }
  Widget ball(String image,Color color,){
    return Container(
      height: 60,width: 60.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.2)),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover,)
      ),
      
    );
  }
  Widget card(String image,String title,String subTitle,String rank){
    return Container(
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ball(image, Colors.transparent),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0
                ),
              ),
            Text(
                subTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0
                ),
              ),
            Text(
                "50 \$",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0
                ),
              ), 
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star,color: Colors.yellow,),
            Text(rank,style: TextStyle(fontFamily: 'Poppins',),),
          ],
        ),
      ],
    ),);
  }
  Future<bool> confirmDialog(BuildContext context, String message) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Message'),
            content: Container(
              height: 40,
              child:Text('Doctor $message your favourite doctors'),
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

  Future persistDoctors(List docs) async{
 var list = jsonEncode(docs);
SharedPreferences preferences= await SharedPreferences.getInstance();
preferences.setString('docs', list);
  }
}