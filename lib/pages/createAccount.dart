import 'dart:convert';
import 'dart:io';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateAcount extends StatefulWidget {
  final List<dynamic> accountInfo;
  const CreateAcount({Key key, this.accountInfo}):super(key:key);
  @override
  _CreateAcountState createState() => _CreateAcountState();

  
}

class _CreateAcountState extends State<CreateAcount> {
  File _image;
  var imageJson;
  int userDepartment;
  final _formKey = GlobalKey<FormState>();
    Country _selected=Country.ZW;
    TextEditingController phoneNumberController = new TextEditingController();
    String city, gender,phoneNo,countryCode = "",phoneNumber = "", type,baseImage,email,imageName, fname,lname,cname,profession, physicalAddress;
    List<dynamic> specialities=[], facilityType=[];
    List<dynamic> _myActivities=[];
    int  _result,contactID;
    var newFormat = DateFormat("dd-MMM-yyyy");
   bool _load= false;
   
    DateTime birthDate;
 
   Future _getPhoto() async{
    print('picking image');
     
    final image= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image=image;
           final bytes = _image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    baseImage=img64;
    imageName = basename(_image.path);
    
    });
  
}
 Future uploadImage(int id, String imgName, String bsImage)async{
   var result;
final http.Response response = await http.post(
        '${webhook}disk.folder.uploadfile',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({

            "id": 60,
            "data": {
                "NAME": id
            },
            "fileContent":[imgName, bsImage] 
       
                    }
       )
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
         setState(() {
           _load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        print("/*/*/*/*/*"+result.toString());
 
       }
       else{
         print("***********************lead"+response.statusCode.toString());
       }
 }

 setDetails(int id, String fullname,String phonenumber, String city)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setInt("id", id);
    preferences.setString("name", fullname);
    preferences.setString("phone", phoneNumber);
    preferences.setString("city", city);
    

  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber= widget.accountInfo[1];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          onPressed: (){
            //TODO Paramters should be changed once user starts coming from the Core system
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor),
        ),
        title: Text(
          "Create Acount",
          style:TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ), 
      ),
      body: SingleChildScrollView(
        
        child:Container(
         
          color: Theme.of(context).primaryColor,
          child:Column(
            children: <Widget>[
              Container(
                padding:EdgeInsets.all(12.0),
                child:Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                     
                      child: Column(
                        children: <Widget>[
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
                               labelText: 'First Name'
                                            ),
                                            
                             onChanged: (value){
                               setState(() {
                                 fname=value;
                               });  
                               },     
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'First Name can not be empty!';
                         }
                             return null;
                                  },
                            )),
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
                               labelText: 'Last Name'
                                            ),
                                            
                             onChanged: (value){
                               setState(() {
                                 lname=value;
                               });  
                               },     
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'Last Name can not be empty!';
                         }
                             return null;
                                  },
                            )),
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
                               labelText: 'Display Name'
                                            ),
                                            
                             onChanged: (value){
                               setState(() {
                                 cname=value;
                               });  
                               },     
                      
                            )),

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
                  titleText: 'Partner type',
                  hintText: 'Select ',
                  value: type,
                  onSaved: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                     type = value;
                    });
                  },
                  dataSource:partnersList ,
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
                            child:DropDownFormField(
                  titleText: 'Profession',
                  hintText: 'Select ',
                  value: profession,
                  onSaved: (value) {
                    setState(() {
                      profession = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                     profession = value;
                    });
                  },
                  dataSource: professionsList,
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
                            
                           MultiSelectFormField(
                  autovalidate: false,
                  chipBackGroundColor: Theme.of(context).accentColor,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Theme.of(context).accentColor,
                  checkBoxCheckColor: Theme.of(context).primaryColor,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Specialities",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Select one or more specialities';
                    }
                    return null;
                  },
                  dataSource: specialitiesList,
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'DONE',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities= value;
                      specialities=_myActivities;
                      print(specialities);

                    });
                  },
                ),),
                
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
                               labelText: 'Physcial Address'
                                            ),
                                            
                             onChanged: (value){
                               setState(() {
                                 physicalAddress=value;
                               });  
                               }, 
                               validator: (value) {
                      if (value.isEmpty) {
                       return 'Physcial Address can not be empty!';
                         }
                             return null;
                                  },    
                      
                            )),
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
                  titleText: 'City',
                  hintText: 'Select city',
                  value: city,
                  onSaved: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                     city = value;
                    });
                  },
                  dataSource: citiesList,
                  textField: 'display',
                  valueField: 'value',
                ),
                          ),
                          Row(
                      children: <Widget>[
                        Expanded(child: Container(
                            height: 40.0,
                            margin: EdgeInsets.only(top: 20.0 ,left: 10.0,right: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0,color: Color(0xdddddddd)),
                              borderRadius: BorderRadius.circular(12.0),                          
                            ),
                              child:Center(
                                child: CountryPicker(
                                  dense: false,
                                  showFlag:
                                  true, //displays flag, true by default
                                 
                                  showDialingCode:
                                  true, //displays dialing code, false by default
                                  showName: false, //eg. 'GBP'
                                  onChanged: (Country country) {
                                    setState(() {
                                      _selected = country;
                                    });
                                  },
                                  dialingCodeTextStyle:  TextStyle(
                                    fontSize:
                                    (18),),
                                  nameTextStyle:  TextStyle(
                                    fontSize:(18),),
                                  selectedCountry: _selected,
                                ),
                              ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                          height: 40.0,
                          margin: EdgeInsets.only(top: 20.0 ,left: 12.0,right: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Color(0xdddddddd)),
                            borderRadius: BorderRadius.circular(12.0),                          
                          ),
                            child:Center(
                              child: FormBuilderTextField(
                                initialValue: null,
                                controller: phoneNumberController,
                                attribute: 'phoneNumber',
                                validators: [
                                  FormBuilderValidators.required()
                                ],
                                keyboardType: TextInputType.number,                            
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 6,left:12),
                                  border: InputBorder.none, 
                                  suffixIcon:Icon(Icons.verified_user),
                                  prefixText: "",
                                  prefixStyle: TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            child:  TextFormField(
                             
                              
                                  decoration: InputDecoration(
                                  
                               labelText: 'Email Address'
                                            ),
                               onChanged: (value){
                                email=value; 
                               },             
                              
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'Email Number can not be empty!';
                         }
                             return null;
                                  },
                            )
                          ),
                          Container(
                            height: 90.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.withOpacity(0.4)                           
                            ),
                            child: Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(
                                    birthDate==null?'BithDate':newFormat.format(birthDate)
                                  ),
                                ),
                                RaisedButton(
                                  child: Icon(Icons.calendar_today),
                                  onPressed: (){
                                    showDatePicker(context: context, initialDate: DateTime.now(),
                                     firstDate: DateTime(1900), 
                                     lastDate: DateTime(2299)
                                     ).then((value) {
                                      setState(() {
                                        birthDate= value;
                                      });
                                     });
                                }),
                              ],
                            )
                          ),
                      
                        
                          Container(
                            height: 100.0,
                            margin:  const EdgeInsets.only(top: 12.0),
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                         
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                   
                            
                              child: SizedBox(
                                height: 70.0,
                                width: 70.0,
                                child: _image==null?Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQHLSQ97LiPFjzprrPgpFC83oCiRXC0LKoGQ&usqp=CAU",
                                fit:BoxFit.cover)
                                                    :Image.file(
                                                              _image,
                                                          fit: BoxFit.cover,
                                                          
                                                             
                                                      ) ,
                              
                            ),
                          ),
                           
                              Container(
                    margin: EdgeInsets.only(right:30.0,left: 30.0 ),
                    height: 30,
                                            
                              child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: (){
                        _getPhoto();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        child:  Center(
                          child:Text(
                            'Upload Photo', 
                            style:  TextStyle(
                              fontSize: 18.0, 
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),  
                        ),
                      ),   
                    ),
                            ),

                                ],
                              ),
                            )),
                            
                             
                              
                            
                          
                           
                        ],
                      ),
                    ),
                  ],
                )
              ), 
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child:Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                child:_load?CircularProgressIndicator() : Text(
                  "Submit",
                  style: TextStyle(
                    color:Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    fontFamily: "Poppins"
                  ),
                ),
                onPressed: () async{

                  _onFormSaved();
                   if (_formKey.currentState.validate()) {
                  setState(() {
                    
                    _load=true;
                    this.phoneNo="+"+this._selected.dialingCode+" "+this.phoneNumberController.text;
                  });
                
                   await _decideDepartment(type);
                 _result = await _createAccount(gender, type,fname,lname,city,phoneNo,email,birthDate);
                 contactID =  await _createContact(widget.accountInfo[1],widget.accountInfo[0].userID,_result.toString());           
                    SharedPreferences.getInstance().then(( SharedPreferences sp){
                     sp.setInt('contactID', contactID);
                    });
                     await setDetails(_result, fname+" "+lname,phoneNo,city);
                   int cid=  await _createCompany(cname,physicalAddress,city, contactID);
                    
                  //var picUrl = await uploadImage(_result,imageName,baseImage);
                  //print('*************** $picUrl');
                     await confirmDialog(context); 
                     Navigator.of(context).pushNamed('/homeoptions', arguments: widget.accountInfo[0]); 
                    //Navigator.of(context).pushNamed('/home',arguments:[fname+' '+lname,_result,city]);
                  }
                },
              ),
              MaterialButton(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color:Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    fontFamily: "Poppins"
                  ),
                ),
                onPressed: () {
                  _formKey.currentState.reset();
                },
              ),
            ],
          ),
        ),
      ),      
    );
  }

   Future<int> _addContact(int cID, int contactID) async {
//  showAlertDialog(context);
int result=0;
    final http.Response response = await http.post(
        '${webhook}crm.company.contact.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
   "id":cID,
   "fields":{
     "CONTACT_ID":contactID,
     "IS_PRIMARY":true
   }

       }),).catchError((error) => print(error));
       if(response.statusCode==200)
       {  
         setState(() {
           _load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        
     print('************************* result $result');
       }
       else{
         print('//////////////////${response.statusCode}');
       }
       return result;
  }


   Future <int>_createAccount(String g, String type, String name, String lname, String city, String phoneNumber,String email, DateTime dob) async {
//  showAlertDialog(context);
  int result=0;
    final http.Response response = await http.post(
        '${webhook}user.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
          "EXTRANET":"N",
          "USER_TYPE":"employee",
          "SONET_GROUP_ID":[1],
          "UF_DEPARTMENT":[userDepartment],
          "WORK_POSITION": "Doctor",
         "LAST_NAME":lname,
         "EMAIL":email,
         "PERSONAL_BIRTHDAY":dob.toString(),
         "NAME":name,
         "PERSONAL_CITY":city,
         "PERSONAL_GENDER":g,
          "PERSONAL_PROFESSION": profession,
         "PERSONAL_PHONE":phoneNumber
         

       }),).catchError((error) => print(error));
       if(response.statusCode==200)
       {  
         setState(() {
           _load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        
     print('************************* result $result');
       }
       else{
         print('//////////////////${response.statusCode}');
       }
       return result;
  }


  Future <int>_createContact(String phoneNumber,String userID, String id) async {

  int result=0;
  setState(() {
    _load=true;
  });
    final http.Response response = await http.post(
        '${webhook}crm.contact.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
         "fields":{ 
                    "NAME": fname, 
                    "LAST_NAME": lname, 
                    "OPENED": "Y", 
                    "ASSIGNED_BY_ID": 1, 
                    "TYPE_ID": "CLIENT",
                    "UF_CRM_1603851628169":userID,
                    "UF_CRM_1604090065799":type,
                    "UF_CRM_1604303008535":userDepartment,
                    "UF_CRM_1598992339725":id,
                    "UF_CRM_1604322159879":specialities,
                
                            "PHONE": [ { "VALUE":phoneNumber, "VALUE_TYPE": "WORK" } ] 
       }
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
         setState(() {
           _load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        print("//////////"+result.toString());
 
       }
       else{
         print(response.statusCode);
       }
       return result;
  }


 
  Future<int> _createCompany(
      String displayName, String address, String addressCity, int id) async {
    setState(() {
      _load = true;
    });
    int result = 0;
    final http.Response response = await http
        .post('${webhook}crm.company.add',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "fields": {
                "TITLE": displayName,
                "ADDRESS": address,
                "ADDRESS_COUNTRY": "Zimbabwe",
                "ADDRESS_CITY":addressCity,
                "COMPANY_TYPE": "CUSTOMER",
                "INDUSTRY": "MANUFACTURING",
                "EMPLOYEES": "EMPLOYEES_2",
                "CURRENCY_ID": "GBP",
                "REVENUE": 3000000,
                "OPENED": "Y",
                "CONTACT_ID":id,
                "ASSIGNED_BY_ID": 10
              }
            }))
        .catchError((error) => print('///////////////////////error' + error));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      result = responseBody['result'];
      print("//////////company" + result.toString());
    } else {
      print(response.statusCode);
    }
    print(result);
    return result;
  }

   Widget ball(Image image,Color color){
    return CircleAvatar(
                            
                            radius:70,
                            backgroundColor: color,
                            child: ClipOval(
                              child: SizedBox(
                                height: 0.0,
                                width: 70.0,
                                child: image
                              ),
                            ),
                          );
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
              child:Text('Account created successfully'),
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
    void _onFormSaved() {
    final FormState form = _formKey.currentState;
    form.save();
  }
Future _decideDepartment(String departmentName){
  switch(departmentName){
    case "Doctor":{
   setState(() {
     userDepartment=30;
   });
    }
    break;
      case "Hospital":{
    setState(() {
     userDepartment=28;
   });
    }
    break;

       case "Clinic":{
    setState(() {
     userDepartment=28;
   });
    }
    break;
      case "Pharmacy":{
     setState(() {
     userDepartment=32;
   });
    }
    break;
      case "Laboratory":{
      setState(() {
     userDepartment=26;
   });
    }
    break;
      case "Imaging Centre":{
      setState(() {
     userDepartment=24;
   });
    }
    break;
  case "Fitness Center":{
      setState(() {
     userDepartment=1528;
   });
    }
    break;

    case "Blood Bank":{
      setState(() {
     userDepartment=1530;
   });
    }
    break;
    case "Ambulance":{
      setState(() {
     userDepartment=1532;
   });
    }
    break;
    
    default:{
      print('no such user type');
    }


  }
}
}