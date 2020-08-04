import 'package:digitAT/pages/acount.dart';
import 'package:digitAT/pages/home_options.dart';
import 'package:digitAT/pages/pharmacies.dart';
import 'package:digitAT/pages/prescription.dart';
import 'package:flutter/material.dart';
import 'package:digitAT/pages/appointment.dart';
import 'package:digitAT/pages/book-test-online1.dart';
import 'package:digitAT/pages/book-test-online2.dart';
import 'package:digitAT/pages/book-test-online3.dart';
import 'package:digitAT/pages/book-test-online4.dart';
import 'package:digitAT/pages/doctor-book-1.dart';
import 'package:digitAT/pages/doctor-book-2.dart';
import 'package:digitAT/pages/health.dart';
import 'package:digitAT/pages/medeciens-2.dart';
import 'package:digitAT/pages/medecines.dart';
import 'package:digitAT/pages/my-doctors.dart';
import 'package:digitAT/pages/offers.dart';
import 'package:digitAT/pages/Welcome.dart';
import 'package:digitAT/pages/chat.dart';
import 'package:digitAT/pages/createAccount.dart';
import 'package:digitAT/pages/docotr_acount.dart';
import 'package:digitAT/pages/doctors.dart';

import 'package:digitAT/pages/phoneNumber_login.dart';
import 'package:digitAT/pages/signup.dart';
import 'package:digitAT/pages/tabs.dart';
import 'package:digitAT/pages/verification_number.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch(settings.name){
      case '/' :
        return MaterialPageRoute(builder: (_) => Welcome());      
      case '/signup' :
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/phone':
        return MaterialPageRoute(builder: (_) => PhoneLogin());
      case '/verification':
        return MaterialPageRoute(builder: (_) => VerificationNumber("",""));
      case '/createAcount':
        return MaterialPageRoute(builder: (_) => CreateAcount(accountInfo:args)); 
        case '/account':
        return MaterialPageRoute(builder: (_) => AcountWidget(acountInfos: args)); 
      case '/home':
        return MaterialPageRoute(builder: (_) => TabsWidget(acountInfos: args,));
      case '/chat' :
        return MaterialPageRoute(builder: (_) => ChatWidget());
      case '/doctors':
        return MaterialPageRoute(builder: (_) => DoctorsList());  
      case '/doctorProfil':
        return MaterialPageRoute(builder: (_) => DoctorAcount(doctor: args,));
      case '/firstDoctorBook':
        return MaterialPageRoute(builder: (_) => DoctorBookFirstStep(doctor: args,));
      case '/secondeDoctorBook':
        return MaterialPageRoute(builder: (_) => DoctorBookSecondeStep(value: args));
      case '/offers':
        return MaterialPageRoute(builder: (_) => OffersList());
      case '/bookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnline());
      case '/secondeBookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnlineSecondeStep());
      case '/thirdBookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnlineThirdStep());
      case "/fourthBookTest":
        return MaterialPageRoute(builder: (_) => BookTestsOnlineFourthStep());
      case '/medecines':
        return MaterialPageRoute(builder: (_) => Medecines(pId: args));
      case '/medecinesSeconde':
        return MaterialPageRoute(builder: (_) => MedecinesSlected(value: args,));
      case '/mydoctors':
        return MaterialPageRoute(builder: (_) => MyDoctorsList());
      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentsList());
      case '/health':
        return MaterialPageRoute(builder: (_) => HealthTips());
        case '/pharmacies':
        return MaterialPageRoute(builder: (_) => Pharmacies());
        case '/prescription':
        return MaterialPageRoute(builder: (_) => Prescription());



      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }
    static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}