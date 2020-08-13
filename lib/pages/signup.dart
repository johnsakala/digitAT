
import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  User currentUser = new User.init().getCurrentUser();
  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
var _user;
 
  Map userProfile;
  

Future login() async {
  final facebookLogin = FacebookLogin();
  final facebookLoginResult = await facebookLogin.logIn(['email']);

  print(facebookLoginResult.accessToken);
  print(facebookLoginResult.accessToken.token);
  print(facebookLoginResult.accessToken.expires);
  print(facebookLoginResult.accessToken.permissions);
  print(facebookLoginResult.accessToken.userId);
  print(facebookLoginResult.accessToken.isValid());

  print(facebookLoginResult.errorMessage);
  print(facebookLoginResult.status);

  final token = facebookLoginResult.accessToken.token;

  /// for profile details also use the below code
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  final profile = json.decode(graphResponse.body);
  setState(() {
    userProfile=profile;
  });
  print(profile);
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
    setState(() {
      
      _user=user;
    });
  return 'signInWithGoogle succeeded: $user';
}

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
          
          children: [
            Container(
              height: 400.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0)),
                image: DecorationImage(
                  image:AssetImage('images/image-home.jpeg'),
                  fit: BoxFit.cover,
                  ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(50.0),bottomRight: Radius.circular(50.0)),
                  color: Theme.of(context).accentColor.withOpacity(0.8),
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0,right:50.0,left: 50.0 ),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.10), offset: Offset(0,4), blurRadius: 10)
                ],
              ),
              child: RaisedButton(
                elevation: 0.2,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.of(context).pushNamed('/phone');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Image(
                            image: AssetImage('images/cellphone-line.png'),
                        ),
                        Text(
                          ' Phone Number', 
                          style:  TextStyle(
                            fontSize: 16.0, 
                            color: Theme.of(context).focusColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),   
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0,right:50.0,left: 50.0 ),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.10), offset: Offset(0,4), blurRadius: 20)
                ],
              ),
              child: RaisedButton(
                elevation: 0.2,
                color: Theme.of(context).primaryColor,
                onPressed: () async{
                  await login();
                  int response = await _createLead('',userProfile['name']);
                   Navigator.of(context).pushNamed("/home",arguments: [userProfile['name'],response,'Harare']);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Image(
                            image: AssetImage('images/facebook-fill.png'),
                        ),
                        Text(
                          ' Facebook', 
                          style:  TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).focusColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ), 
                      ],
                    ),
                  ),
                ),   
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0,right:50.0,left: 50.0 ),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.10), offset: Offset(0,4), blurRadius: 10)
                ],
              ),
              child: RaisedButton(
                elevation: 0.2,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  signInWithGoogle().whenComplete(() async{
                    int response= await _createLead(_user.email,'');
                         Navigator.of(context).pushNamed("/home",arguments: [_user.displayName,response,'Harare']);

                          });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  child:  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Image(
                            image: AssetImage('images/google-fill.png'),
                        ),
                        Text(
                          ' Google', 
                          style:  TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).focusColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),  
                      ],
                    ),
                  ),
                ),   
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0,bottom: 20.0),
              child: Center(
                child: Text(
                  "By continuing, you agree to Terms & Conditions",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'
                  ),
                  
                ),
              ),
            ),
            SizedBox(height: 40,),
            /*Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Container(
                    height: 40.0,width: 70.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent.withOpacity(0.10), offset: Offset(0,4), blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(80.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                      color: Colors.transparent.withOpacity(0.1),
                    ),
                  ),
                ],
              ),   
            ),*/
          ],
        ),
    );
  }

  Future <int>_createLead( String email, String name) async {
//  showAlertDialog(context);
  int result=0;
    final http.Response response = await http.post(
        '${webhook}crm.lead.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
        "fields":{  "TITLE": "digitAT", 
                    "NAME": name, 
                    "SECOND_NAME": " ", 
                    "LAST_NAME": " ", 
                    "STATUS_ID": "NEW", 
                    "OPENED": "Y", 
                    "ASSIGNED_BY_ID": 1, 
                    "ADDRESS_CITY":"Harare",
                    "EMAIL":email,
                    "PHONE": [ { "VALUE": "040235", "VALUE_TYPE": "WORK" } ] 
       }
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
         setState(() {
          
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