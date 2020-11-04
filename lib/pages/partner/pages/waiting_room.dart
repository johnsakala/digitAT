import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/doctor.dart' as model;
import 'package:image_picker/image_picker.dart';
class WaitingRoom extends StatefulWidget {
 
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  model.DoctorsList doctorsList;
  List<int> list=[];
  @override
  void initState() {
    this.doctorsList = new model.DoctorsList();
    super.initState();
  
 
  }
  File _image;
  String baseImage,imageJson;
   Future _getPhoto() async{
    print('picking image');
     
    final image= await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image=image;
           final bytes = _image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    baseImage=img64;
    imageJson=baseImage;
    
    });
   
    print('image path //////////////'+imageJson);
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
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Waiting Room',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Take Vitals',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(            
               color: Colors.transparent,
              ),
              child: Container(
                    margin: EdgeInsets.only(right:30.0,left: 30.0 ),
                    height: 60,
                                            
                              child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: (){
                        _getPhoto();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(child:Container(
                        child:  Center(
                          child:Text(
                            'Take Photo', 
                            style:  TextStyle(
                              fontSize: 18.0, 
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),  
                        ),
                      )
                      ),   
                    ),
                            ),
            ),
          ],
        ),      
     ) );
    
       }
  }
  