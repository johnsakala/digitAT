import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitAT/api/url.dart';
import 'package:digitAT/config/constants.dart';
import 'package:digitAT/constants.dart';
import 'package:digitAT/main.dart';
import 'package:digitAT/models/model/User.dart';
import 'package:digitAT/models/partner/models/profile.dart';
import 'package:digitAT/services/FirebaseHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/models/model/User.dart' as fUser;
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
  AuthResult result;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var _user;

  bool isLoggedIn = false;
  bool isLoading = false;
  bool isloading = false;
  var profileData;
  String fname, sname, lname;
  var facebookLogin = FacebookLogin();

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.blue,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "Please wait, loading..",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
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

        print('*******************' + token.toString());
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200).width(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: token);

        // this line do auth in firebase with your facebook credential.
        final AuthResult authResult =
            await _auth.signInWithCredential(credential);
            setState(() {
              result=authResult;
            });
        final FirebaseUser user = authResult.user;
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        setState(() {
          profileData = user;
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
      _user = user;
    });
    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: isloading
          ? bodyProgress
          : ListView(
              children: [
                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    image: DecorationImage(
                      image: AssetImage('images/image-home.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0)),
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0, right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 0.2,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/phone');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/cellphone-line.png'),
                            ),
                            Text(
                              ' Phone Number',
                              style: TextStyle(
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
                /*Container(
                  margin: EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 20)
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 0.2,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      initiateFacebookLogin().whenComplete(() async {
                        setState(() {
                          isloading = true;
                        });
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        print(profileData);
                        List url = profileData.photoUrl.split('/');

                        splitNames(profileData.displayName);
                        int response = await _createContact(fname,
                            lname,
                             profileData.email,profileData.uid);
                        preferences.setInt('id', response);
                        preferences.setString('name', fname);
                        preferences.setString('email',profileData.email);
                        preferences.setString('city', 'Harare');
                        fUser.User user = fUser.User(
            email: profileData.email,
            firstName: fname,
            phoneNumber: "0404",
            userID: result.user.uid,
            lastOnlineTimestamp: Timestamp.now(),
            active: true,
            fcmToken: await FirebaseMessaging().getToken(),
            lastName: lname,
            settings: Settings(allowPushNotifications: true),
            profilePictureURL: 'https://graph.facebook.com/${url[3]}/picture?width=200');
        await FireStoreUtils.firestore
            .collection(USERS)
            .document(result.user.uid)
            .setData(user.toJson());
        
        MyAppState.currentUser = user;
        fireStoreUser=user;
        print('-----------------------------------${MyAppState.currentUser}');
                        Navigator.of(context).pushNamed("/homeoptions",
                            arguments: [fname, response, 'Harare']);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/facebook-fill.png'),
                            ),
                            Text(
                              ' Facebook',
                              style: TextStyle(
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
                ),*/
                Container(
                  margin: EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0),
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.10),
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ],
                  ),
                  child: RaisedButton(
                    elevation: 0.2,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      signInWithGoogle().whenComplete(() async {
                        setState(() {
                          isloading = true;
                        });
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        splitNames(_user.displayName);
                       /* int response = await _createContact(
                            fname, lname, _user.email,_user.uid);*/
                       
                        preferences.setString('name', fname);
                        preferences.setString('email',_user.email);
                        preferences.setString('city', 'Harare');

                                  
                                  User user = fUser.User(
            email: _user.email,
            firstName: fname,
            phoneNumber: "0404",
            userID: _user.uid,
            //lastOnlineTimestamp: Timestamp.now(),
            active: true,
            fcmToken: await FirebaseMessaging().getToken(),
            lastName: lname,
           // settings: Settings(allowPushNotifications: true),
            profilePictureURL:_user.photoUrl);
        await FireStoreUtils.firestore
            .collection(USERS)
            .document(_user.uid)
            .setData(user.toJson());
        
        MyAppState.currentUser = user;
        fireStoreUser=user;
        preferences.setString('user', jsonEncode( user.toJson()));
        print('-------------------------+ ${preferences.getString('user')}');
                        Navigator.of(context).pushNamed('/createAcount', arguments: [user, ""]);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/google-fill.png'),
                            ),
                            Text(
                              ' Google',
                              style: TextStyle(
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
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Center(
                    child: Text(
                      "By continuing, you agree to Terms & Conditions",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
    );
  }

  void splitNames(String name) {
    List<String> names = name.split(" ");
    switch (names.length) {
      case 1:
        {
          setState(() {
            fname = names[0];
          });
        }
        break;
      case 2:
        {
          setState(() {
            fname = names[0];
            lname = names[1];
            sname = '';
          });
        }
        break;
      case 3:
        {
          setState(() {
            fname = names[0];
            sname = names[1];
            lname = names[2];
          });
        }
        break;
      default:
        {
          setState(() {});
        }
    }
  }

  
  Future <int>_createContact( String fName, String lName, String email,String userID) async {

  int result=0;
  setState(() {
    isLoading=true;
  });
    final http.Response response = await http.post(
        '${webhook}crm.contact.add',
         headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         
         "fields":{ 
                    "NAME": fName, 
                    "LAST_NAME": lName, 
                    "OPENED": "Y", 
                    "ASSIGNED_BY_ID": 1, 
                    "TYPE_ID": "CLIENT",
                    "UF_CRM_1603851628169":userID,
                    
                
                            "EMAIL": [ { "VALUE":email, "VALUE_TYPE": "WORK" } ] 
       }
       })
        
         ).catchError((error) => print('///////////////////////error'+error));
       if(response.statusCode==200)
       {  
         setState(() {
           isLoading=false;
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
}
