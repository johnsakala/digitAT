//import 'package:flutter/gestures.dart';
import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:digitAT/models/user.dart';
import'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter/services.dart';

class VerificationNumber extends StatefulWidget {
  final String userPhoneNumber, verificationId;
  VerificationNumber(this.userPhoneNumber, this.verificationId);
  @override
  _VerificationNumberState createState() => _VerificationNumberState();
}

class _VerificationNumberState extends State<VerificationNumber> {
  User currentUser=new User.init().getCurrentUser();
   var _code;
   bool load=false;

  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    verificationId=widget.verificationId;

    return Scaffold(
      key: _scaffoldstate,
        backgroundColor: Color(0xeeffffff),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close,color: Colors.black),
            onPressed: (){    
              //Navigator.of(context).pushNamed('/phone');
            },
          ),
        ),
        body: ListView(

          children:[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30.0),
              child: Text(
                "Enter Code",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              child: Text(
                'we have sent you an SMS on your ${maskNumber(widget.userPhoneNumber)} \n with 6 digit verification code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12.0),
              child: Center(
                child: Text(
                  '* * * * * *',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0
                  ),
                ) 
              ,),
            ),
            Container(
              height: 180.0,
              margin: EdgeInsets.only(top:12.0,right:12.0,left:12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children:[
                  Form(
                    key: _formKey,
                    child:VerificationCodeInput(
                   keyboardType: TextInputType.number,
                    length: 6,
                   onCompleted: (String value) {
                    setState(() {
                      _code=value;
                    });

            
            },
            
        )
                  ),
                  Container(
                    margin: EdgeInsets.only(top:40.0,bottom: 20.0,right:30.0,left: 30.0 ),
                    height: 40,
                    child:load?CircularProgressIndicator(): RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: (){
                      
                        if(_formKey.currentState.validate()){
                          setState(() {
                            load=true;
                          });
                       verifyOTP();
                        }
                        else{
                           final snackBar = SnackBar(content: Text('Enter verification code first'));
                    _scaffoldstate.currentState.showSnackBar(snackBar);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        child:  Center(
                          child:Text(
                            'Submit', 
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
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30.0),
              child: Text(
                "Did not receive the code?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){},
                    child:Text(
                      "Re-send",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){},
                    child:Text(
                      "Get a call now",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
  Widget _otpTextField() {
    return new Container(
      margin: const EdgeInsets.only(top: 30.0),
      width: 25.0,
      height: 45.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2.0,
            color: Colors.black,
      ))),
      child: Center(
        child: new FormBuilderTextField(
          initialValue: "",
          attribute: 'Country code',
          validators: [
          ],
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          controller: optController,
          keyboardType: TextInputType.number,
          style: new TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      
    );
  }
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController optController = new TextEditingController();
  verifyOTP() {
    _auth.currentUser().then((user) {
      if (user != null) {
        verifiedSuccess(user.phoneNumber);
      } else {
        signIn();
      }
    });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: widget.verificationId,
        smsCode: _code,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
     await verifiedSuccess(user.phoneNumber);
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print("Something went wrong" + verificationId + widget.userPhoneNumber);
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'You have entered an invalid OTP';
        });
        Navigator.of(context).pop();

//        smsOTPDialog(context).then((value) {
//          print('sign in');
//        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
          print(errorMessage);
          Navigator.of(context).pop();
        });

        break;
    }
  }

  maskNumber(String userPhoneNumber) {
    int maskLength = userPhoneNumber.length - 3;
    return userPhoneNumber.replaceRange(4, maskLength, '*' * maskLength);
  }
  Future verifiedSuccess(String phone) async {
    int _id;
     print('*********************** $phone');
    SharedPreferences preferences= await SharedPreferences.getInstance();
     _id= await _createLead( phone);
     preferences.setInt('id', _id);
     preferences.setString('name',phone);
     preferences.setString('city','Harare');
    Navigator.of(context).pushNamed('/home',arguments: [phone,_id,'Harare']);
         print("Successfully Verified user number");
  }
   Future <int>_createLead( String phoneNumber) async {
//  showAlertDialog(context);
  int result=0;
    final http.Response response = await http.post(
        '${webhook}crm.lead.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
        "fields":{  "TITLE": "digitAT Phone", 
                    "NAME": " ", 
                    "SECOND_NAME": " ", 
                    "LAST_NAME": " ", 
                    "STATUS_ID": "NEW", 
                    "OPENED": "Y", 
                    "ASSIGNED_BY_ID": 1, 
                    "ADDRESS_CITY":"Harare",
                    "EMAIL":  [ { "VALUE": "me@digitat.info", "VALUE_TYPE": "WORK" } ],
                    "PHONE": [ { "VALUE": phoneNumber, "VALUE_TYPE": "WORK" } ] 
       }
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
         setState(() {
           load=false;
         }); 
         Map<String, dynamic> responseBody = jsonDecode(response.body);     
           result=responseBody['result'];
        print('******************************'+result.toString());
 
       }
       else{
         print(response.statusCode);
       }
       return result;
  }

}