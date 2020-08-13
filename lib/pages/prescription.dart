import 'dart:convert';
import 'package:digitAT/api/url.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
           
        print('//////////////////////////////zvaita');
 
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
           
        print('//////////////////////////////zvaita');
 
       }
       else{
         print(response.statusCode);
       }
       //return responseBody['result'];
  }
  final _formKey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();
    setState(() {
     
    });
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        elevation: 0,
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Theme.of(context).primaryColor ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'PharmaHub',
          style: TextStyle(
            fontSize:22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),

      ),
      body:FutureBuilder(
        future: _fetchAids(),
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData){
          return
          SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 20,
                    padding: const EdgeInsets.only(left:0.0,right: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                      color: Theme.of(context).accentColor,
                    ),
                    
                  ),
                 
              ],
            ),
            Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Paste prescription below :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              
              child:  Form(
                      key: _formKey,
                     
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 300.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.withOpacity(0.4)                          
                            ),
                            child:
                            
                            TextFormField(
                                 maxLines: 8, 
                                            
                             onChanged: (value){
                               setState(() {
                                 prescription=value;
                               });  
                               },     
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'can not be empty!';
                         }
                             return null;
                                  },
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
                        ]),
               ),) 
               ],
        ),
      );}
      else{
        Center(child: CircularProgressIndicator(),);
      }
      }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
              padding:EdgeInsets.only(right: 0.0,left: 30.0,bottom: 0.0,top: 0),
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
                        '',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: ()async {
                   if (_formKey.currentState.validate()) {
                      
                   await _createOrder();
                   await _createPaymentOrder();
                   final snackBar = SnackBar(content: Text('Order Sent, you will receive a notification from the pharmacy'));
                    _scaffoldstate.currentState.showSnackBar(snackBar);
                   SharedPreferences preferences= await SharedPreferences.getInstance();
                       int id= preferences.getInt('id');
                       String name= preferences.getString('name');
                       String city= preferences.getString('city');
                     /*  if(result!=null){
                       print('*********************************appointment created');
                      }*/
                      Navigator.of(context).pushNamed("/home",arguments:[name,id,city]);
                      /*if(result!=null){
                       print('*********************************order created');
                      }*/
                     // Navigator.of(context).pushNamed('/home',arguments: [currentUser.name,currentUser.userID]);
                    
                   }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                        'Checkout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
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
}