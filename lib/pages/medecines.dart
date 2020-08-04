import 'dart:convert';

import 'package:digitAT/models/medecine.dart';
import 'package:digitAT/models/pharmacist.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/medecine.dart' as model;
import 'package:digitAT/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:digitAT/widgets/searchWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Medecines extends StatefulWidget {
  final String pId;
  const Medecines({Key key,this.pId}):super(key:key);
  @override
  _MedecinesState createState() => _MedecinesState();
}

class _MedecinesState extends State<Medecines> {
  String number,aid;
  User currentUser=User.init().getCurrentUser();
  //model.MedecinesList medecinesList;
  List<Medecine>medicines= [];
  double bill=0.0;
   List<dynamic> medicalAids=[];

  Future< List< dynamic >> _fetchMedicines() async {
//  showAlertDialog(context);
    final http.Response response = await http
        .get('https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/crm.product.list',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
     

      try {
        if (responseBody["result"] != null) {
               result = responseBody["result"];
            
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
    final http.Response aids = await http
        .get('https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/department.get?PARENT=72',
    )  .catchError((error) => print(error));
    Map<String, dynamic> aidsBody = jsonDecode(aids.body); 
    if (aids.statusCode == 200) {
     

      try {
        if (aidsBody["result"] != null) {
          setState(() {
            medicalAids = aidsBody["result"];
          });
          print('********************medical'+medicalAids.toString());     
            
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
      
Future<Pharmacist> _fetchPharmacist() async {
//  showAlertDialog(context);
Pharmacist pharmacist;
    final http.Response response = await http
        .get('https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/user.get?UF_DEPARTMENT=${widget.pId}',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
               result = responseBody["result"];
                  pharmacist= Pharmacist(result[0]["ID"], result[0]["NAME"], result[0]["LAST_NAME"]);            
   
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
    print('response //////////////////////////////'+result.toString());
    return pharmacist;
  }
  Future<Pharmacist> _fetchAidOfficer(String id) async {
//  showAlertDialog(context);
Pharmacist officer;
 
    final http.Response response = await http
        .get('https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/user.get?UF_DEPARTMENT=$id',
    )  .catchError((error) => print(error));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    
    List< dynamic> result=[];
    if (response.statusCode == 200) {
      try {
        if (responseBody["result"] != null) {
               result = responseBody["result"];
                  officer= Pharmacist(result[0]["ID"], result[0]["NAME"], result[0]["LAST_NAME"]);            
   
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
    print('response //////////////////////////////'+result.toString());
    return officer;
  }
  Pharmacist _pharmacist, officer;
  void getPharmacist() async{

     _pharmacist= await _fetchPharmacist();
     
     

 
  }
  void initState() {
    //this.medecinesList = new model.MedecinesList();
    super.initState();
    setState(() {
      getPharmacist();
    });
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
      IconButton(icon: Icon(Icons.edit), onPressed: (){
        Navigator.of(context).pushNamed('/prescription', arguments: _pharmacist.id);
      })
        ],
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
      body: FutureBuilder(
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.hasData){
          return SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 0,left: 12.0,right: 12.0),
                    child:SearchBarWidget(),
                  ),
              ],
            ),
            Container(
              padding:EdgeInsets.only(top:12.0,right: 12.0,left: 12.0,bottom: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                'Medicines :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding:EdgeInsets.only(right: 12.0,left: 12.0,bottom: 12.0),
              decoration: BoxDecoration(            
               color: Theme.of(context).primaryColor,
               borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data.length,
                separatorBuilder: (context,index){
                  return SizedBox(height: 7,);
                },
                itemBuilder: (context,index){
                  return 
                  Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 12.0,right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${snapshot.data[index]['NAME']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${snapshot.data[index]['PRICE']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: (){
                  print(_pharmacist.id);
                 setState(() {
                   bill= bill+ double.parse(snapshot.data[index]['PRICE']);
                 medicines.add(model.Medecine(snapshot.data[index]['NAME'], snapshot.data[index]['PRICE']));
             });
                
                 },
                icon: Icon(Icons.add_circle_outline),
                color: Theme.of(context).accentColor.withOpacity(0.8),
                iconSize: 30,

              )
            ],
          ),
        ),
        SizedBox(height: 15.0,child: Center(child: Container(height: 1.0,color: Colors.grey.withOpacity(0.1),),),),
      
      
      
                         
      ],
    );
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
                  onSaved: (value)async {
                     officer= await _fetchAidOfficer(value);
                    setState(() {
                      aid = value;
                    });
                    print("//////////// ${officer.id}");
                  },
                  onChanged: (value) async {
                     officer= await _fetchAidOfficer(value);
                    setState(() {
                     aid = value;
                    });
                    print("//////////// ${officer.id}");
                  },
                  dataSource: [
                         {
                          "display": "${medicalAids[0]['NAME']}",
                      "value": "${medicalAids[0]['ID']}",
                         },
                           {
                          "display": "${medicalAids[1]['NAME']}",
                      "value": "${medicalAids[1]['ID']}",
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
          ],
        ),
      );
          }
          else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        } ,
        future: _fetchMedicines(),
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
                        '${medicines.length} medecine Added',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        '\$ $bill',
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
                    onPressed: (){
                      Navigator.of(context).pushNamed("/medecinesSeconde", arguments:[medicines,bill,_pharmacist.id,aid+" "+number,officer.id]);
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