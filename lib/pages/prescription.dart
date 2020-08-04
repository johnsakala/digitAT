import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:http/http.dart' as http;


class Prescription extends StatefulWidget {
  final String rId;
  const Prescription ({Key key,this.rId}):super(key:key);
  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription > {
  User currentUser=User.init().getCurrentUser();
  String prescription;
  final _formKey = GlobalKey<FormState>();
  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();
    setState(() {
     
    });
  
  }
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
           // Navigator.of(context).pushNamed('/home', arguments:[currentUser.name,currentUser.phoneNumber]);
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
      body:
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
                            )), 
                        ]),
               ),) 
               ],
        ),
      ),
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
                     
                   }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Theme.of(context).accentColor,
                    child:Container(
                      margin: EdgeInsets.only(left: 45.0,right: 45.0,top: 12,bottom: 12),
                      child:Text(
                        'Continue',
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