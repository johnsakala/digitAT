import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:digitAT/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
class CreateAcount extends StatefulWidget {
  final List<dynamic> accountInfo;
  const CreateAcount({Key key, this.accountInfo}):super(key:key);
  @override
  _CreateAcountState createState() => _CreateAcountState();

  
}

class _CreateAcountState extends State<CreateAcount> {
  User currentUser = new User.init().getCurrentUser();
  File _image;
  
  Future _getPhoto() async{
    print('picking image');
    final image= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image=image;
    });
    print('image path ////////////////'+_image.toString());
  }


 Future<Response> uploadPhoto(
   File _image,
  String _path,
  int _id,
) async {
  Dio dio = new Dio();

   String fileName = _image.path.split('/').last;
            Map<String, dynamic> _formdata = {
              "PERSONAL_PHOTO": await MultipartFile.fromFile(_image.path,filename: fileName),
            };
  //_formdata.add("PERSONAL_PHOTO", new UploadFileInfo(_image, _path));
  final response = await dio.post(
    'https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/user.update?ID=${_id}',
    data: _formdata,
    options: Options(
      method: 'PUT',
      responseType: ResponseType.json,
    ),
  );
  if (response.statusCode == 200 || response.statusCode == 500) {
    print('uploaded image');
  } else {
    throw Exception('Failed to upload!');
  }
}
    final _formKey = GlobalKey<FormState>();
    
    String city, gender,email, fullName,lname, phoneNumber;
    int  _result;
    var newFormat = DateFormat("dd-MMM-yyyy");
   bool _load= false;
   
    DateTime birthDate;
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
            Navigator.of(context).pushNamed('/home',arguments: [currentUser.name,currentUser.phoneNumber]);
          },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor),
        ),
        title: Text(
          "Update Acount",
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
                                 fullName=value;
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
                  dataSource: [
                         {
                          "display": "Harare",
                      "value": "Harare",
                         },
                           {
                          "display": "Bulawayo",
                      "value": "Bulawayo",
                         },
                         {
                          "display": "Chitungwiza",
                      "value": "Chitungwiza",
                         },
                           {
                          "display": "Mutare",
                      "value": "Mutare",
                         },
                           {
                          "display": "Epworth",
                      "value": "Epworth",
                         },
                           {
                          "display": "Gweru",
                      "value": "Gweru",
                         },
                           {
                          "display": "Kwekwe",
                      "value": "Kwekwe",
                         },
                           {
                          "display": "Kadoma",
                      "value": "Kadoma",
                         },
                           {
                          "display": "Masvingo",
                      "value": "Masvingo",
                         },
                           {
                          "display": "  Chinhoyi",
                      "value": "  Chinhoyi",
                         },
                           {
                          "display": "Norton",
                      "value": "Norton",
                         },
                           {
                          "display": "Marondera",
                      "value": "Marondera",
                         },
                           {
                          "display": "Ruwa",
                      "value": "Ruwa",
                         },
                           {
                          "display": "Chegutu",
                      "value": "Chegutu",
                         },
                           {
                          "display": "Zvishavane",
                      "value": "Zvishavane",
                         },
                           {
                          "display": "Bindura",
                      "value": "Bindura",
                         },
                           {
                          "display": "Beitbridge",
                      "value": "Beitbridge",
                         },
                           {
                          "display": "Redcliff",
                      "value": "Redcliff",
                         },
                           {
                          "display": "Victoria Falls",
                      "value": "Victoria Falls",
                         },
                           {
                          "display": "Hwange",
                      "value": "Hwange",
                         },
                           {
                          "display": "Rusape",
                      "value": "Rusape",
                         },
                           {
                          "display": " Chiredzi",
                      "value": " Chiredzi",
                         },
                           {
                          "display": "Kariba",
                      "value": "Kariba",
                         },
                           {
                          "display": "Karoi",
                      "value": "Karoi",
                         },
                           {
                          "display": "Chipinge",
                      "value": "Chipinge",
                         },
                           {
                          "display": "Gokwe",
                      "value": "Gokwe",
                         },
                           {
                          "display": "Shurugwi",
                      "value": "Shurugwi",
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
                            child:  TextFormField(
                             initialValue: widget.accountInfo[1]==null?"":'${widget.accountInfo[1]}',
                              keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                  
                               labelText: 'Phone Number'
                                            ),
                               onChanged: (value){
                                phoneNumber=value; 
                               },             
                              
                        validator: (value) {
                      if (value.isEmpty) {
                       return 'Phone Number can not be empty!';
                         }
                             return null;
                                  },
                            )
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
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5,color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.withOpacity(0.4)                           
                            ),
                            child:DropDownFormField(
                  titleText: 'Gender',
                  hintText: 'Select gender',
                  value: gender,
                  onSaved: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                     gender = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Male",
                      "value": "Male",
                    },
                    {
                      "display": "Female",
                      "value": "Female",
                    },
                    {
                      "display": "Other",
                      "value": "Other",
                    },
                  
                  
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
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
                   if (_formKey.currentState.validate()) {
                  setState(() {
                    _load=true;
                  });
                     /*showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator(),);
                  });*/
                  
                 _result=await _createAccount(gender,fullName,lname,city,phoneNumber,email,birthDate);

                  User.init().setCurrentUser(fullName+' '+lname, phoneNumber, _result.toString());
                  
                    /* Navigator.of(context).pushNamed('/home', arguments:[lname]).then((value){
                   Navigator.of(context).pop();
                    });
                    await uploadPhoto( _image,_image.uri.toFilePath(), _result).then((Response response) {
                    print(response.toString());
                  });*/
                    Navigator.of(context).pushNamed('/account', arguments:_result).then((value){
                   Navigator.of(context).pop();
                    });
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

   Future <int>_createAccount(String g, String name, String lname, String city, String phoneNumber,String email, DateTime dob) async {
//  showAlertDialog(context);
  int result=0;
    final http.Response response = await http.post(
        'https://internationaltechnology.bitrix24.com/rest/1/0w1pl1vx3qvxg57c/user.add',
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
          "EXTRANET":"N",
          "USER_TYPE":"employee",
          "SONET_GROUP_ID":[1],
          "UF_DEPARTMENT":[70],
         "LAST_NAME":lname,
         "EMAIL":email,
         "PERSONAL_BIRTHDAY":dob.toString(),
         "NAME":name,
         "PERSONAL_CITY":city,
         "PERSONAL_GENDER":g,
         "PERSONAL_PHONE":phoneNumber
         

       }),).catchError((error) => print(error));
       if(response.statusCode==200)
       {  
         setState(() {
           _load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        
 
       }
       else{
         print(response.statusCode);
       }
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
}