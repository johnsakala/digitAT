import 'dart:convert';
import 'dart:io';
import 'package:digitAT/api/url.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Prescription extends StatefulWidget {
  final String rId;
  const Prescription ({Key key,this.rId}):super(key:key);
  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription > {
 User currentUser=User.init().getCurrentUser();
  String prescription, aid, number;

   Future< List< dynamic >> _fetchAids() async {

    final http.Response response = await http
        .get('${webhook}department.get?PARENT=72',
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
   Future _createOrder() async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 //int result=0;
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":"medicine order",
   "DESCRIPTION":prescription+" payment"+ aid +" "+number,
   "CREATED_BY":id,
   "RESPONSIBLE_ID":widget.rId
  }

}),).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }

  Future _createPaymentOrder() async {
//  showAlertDialog(context);
  SharedPreferences preferences= await SharedPreferences.getInstance();
  int id= preferences.getInt('id');
 //int result=0;
     final http.Response response = await http.post(
        '${webhook}tasks.task.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
  "fields":{ 
   "TITLE":"payment",
   "DESCRIPTION":"pay for medicines ${widget.rId}",
   "CREATED_BY":id,
   "RESPONSIBLE_ID":widget.rId
  }

}),).catchError((error) => print(error));
       if(response.statusCode==200)
       {
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           
      
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }

  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();
    setState(() {
     
    });
  
  }
 
  List<int> list=[];
  File _image;
  String baseImage,imageJson;
   Future _getPhoto(BuildContext context) async{
    print('picking image');
     
    final image= await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image=image;
           final bytes = _image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    baseImage=img64;
    imageJson=baseImage;
    
    });
   await confirmDialog(context);
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
          'Prescription',
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
                'Upload Picture',
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
                      onPressed: () async{
                        _getPhoto(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(child:Container(
                        child:  Center(
                          child:Text(
                            'Upload', 
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

         Future<bool> confirmDialog(BuildContext context) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Confirmation'),
            content: Container(
              height: 85,
              child:Text('Prescription uploaded successfully'),
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