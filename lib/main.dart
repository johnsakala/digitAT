import 'package:digitAT/config/app_config.dart' as config;
import 'package:digitAT/pages/Welcome.dart';
import 'package:digitAT/pages/tabs.dart';
import 'package:digitAT/pages/verification_number.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:digitAT/routes_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name,city,phone,vId;
  int id;
getId()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.getInt("id");
}
fetchId()async{
  id= await getId();
  
}

 @override
  void initState()  {
    // TODO: implement initState
    super.initState();
 
   SharedPreferences.getInstance().then((SharedPreferences sp) {
      String _name,_city,_phone,_vId;
      int _testValue;
      _testValue = sp.getInt('id');
      _name = sp.getString('name');
      _city = sp.getString('city');
      _phone = sp.getString('phone');
      _vId = sp.getString('vId');

      // will be null if never previously saved
      if (_testValue == null ) {
        _testValue = null;
       
         // set an initial value
      }
      if (_vId == null ) {
        _vId = null;
       
         // set an initial value
      }
      setState(() {
        id=_testValue;
        name=_name;
        city=_city;
        phone=_phone;
        vId=_vId;

      });
    
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
           debugShowCheckedModeBanner: false,
          home: Scaffold(
            body:SplashScreen(

              imageBackground: AssetImage('images/splash.jpg'),
            seconds: 3,
          navigateAfterSeconds: new AfterSplash([id,name,city,phone,vId]),
    
      
        
          backgroundColor:Hexcolor('#1DA1F2').withOpacity(0.8),
       
          photoSize: 100.0,
      
          loaderColor:Hexcolor('#1DA1F2'),
        ),
      ),
    );
  }


}

class AfterSplash extends StatelessWidget {
 const AfterSplash(this.id);
 final List<dynamic> id;
 
  @override
  Widget build(BuildContext context) {
    print(id[1]);
    return MaterialApp(
      title: 'digitAT',
      home:id[0]==null?Welcome():TabsWidget(acountInfos: [id[1],id[0],id[2]]),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Color(0xFF252525)),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Theme.of(context).primaryColor),
          headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
        ),
      ),
    );
  }
}
