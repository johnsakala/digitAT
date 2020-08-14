
import 'dart:convert';

import 'package:digitAT/api/url.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  User currentUser = new User.init().getCurrentUser();
  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
var _user;
 
  bool isLoggedIn = false;
  bool isLoading = false;
  var profileData;

  var facebookLogin = FacebookLogin();


  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      isLoading = false;
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

   Future initiateFacebookLogin() async {
    setState(() {
      isLoading = true;
    });
    var facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
       final token = facebookLoginResult.accessToken.token;

       print('*******************'+token.toString());
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
       
        onLoginStatusChanged(true, profileData: profile);
        AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token);

    // this line do auth in firebase with your facebook credential.
   final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
    setState(() {
      
      profileData=user;
    });
        break;
    }
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
                  initiateFacebookLogin().whenComplete(() async{
                        SharedPreferences preferences= await SharedPreferences.getInstance();
                    print(profileData);

                  int response = await _createLead(profileData.email,profileData.displayName,'facebook');
                  preferences.setInt('id', response);
                    preferences.setString('name',_user.displayName);
                   Navigator.of(context).pushNamed("/home",arguments: [profileData.displayName,response,'Harare']);
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
                        SharedPreferences preferences= await SharedPreferences.getInstance();

                    int response= await _createLead(_user.email,_user.displayName,"gmail");
                    preferences.setInt('id', response);
                    preferences.setString('name',_user.displayName);
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

  Future <int>_createLead( String email, String name,String type) async {
//  showAlertDialog(context);
  int result=0;
    final http.Response response = await http.post(
        '${webhook}crm.lead.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
        "fields":{  "TITLE": "digitAT $type", 
                    "NAME": name, 
                    "SECOND_NAME": " ", 
                    "LAST_NAME": " ", 
                    "STATUS_ID": "NEW", 
                    "OPENED": "Y", 
                    "HAS_PHONE": "Y",
                    "HAS_EMAIL": "Y",
                    "ASSIGNED_BY_ID": 1, 
                    "ADDRESS_CITY":"Harare",
                    "EMAIL":  [ { "VALUE": email, "VALUE_TYPE": "WORK" } ],
                    "PHONE": [ { "VALUE": "0404", "VALUE_TYPE": "WORK" } ] 
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