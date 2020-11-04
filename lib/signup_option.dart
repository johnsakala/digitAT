import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupOptions extends StatefulWidget {
  
  const SignupOptions( {Key key}) : super(key: key);
 
  @override
  _SignupOptionsState createState() => _SignupOptionsState();
}

class _SignupOptionsState extends State<SignupOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
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
                  child: Center(
                    child:Text('Sign up ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.underline
                  ),))
                ),
                
                Container(
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
                    onPressed: ()  {
                     Navigator.of(context).pushNamed('/patientWelcome');
                      SharedPreferences.getInstance().then((SharedPreferences sp) {
                   sp.setBool('isPartner', false);
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
                              image: AssetImage('images/microscope.png'),
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              'Patient',
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

                      Navigator.of(context).pushNamed('/partnerWelcome');
                   SharedPreferences.getInstance().then((SharedPreferences sp) {
                   sp.setBool('isPartner', true);
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
                              image: AssetImage('images/Hospitals.png'),
                               height: 20,
                              width: 20,
                            ),
                            Text(
                              'Partner',
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
                
                SizedBox(
                  height: 40,
                ),
              ],
            ),
    );

  }
}