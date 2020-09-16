import 'package:digitAT/pages/acount.dart';
import 'package:digitAT/pages/book_dignostics1.dart';
import 'package:digitAT/pages/book_dignostics2.dart';
import 'package:digitAT/pages/book_dignostics3.dart';
import 'package:digitAT/pages/covid_services.dart';
import 'package:digitAT/pages/doctor_catergories.dart';
import 'package:digitAT/pages/editAccount.dart';
import 'package:digitAT/pages/home_options.dart';
import 'package:digitAT/pages/hospital_options.dart';
import 'package:digitAT/pages/hospitals.dart';
import 'package:digitAT/pages/imaging_centres.dart';
import 'package:digitAT/pages/labs.dart';
import 'package:digitAT/pages/my_payments.dart';
import 'package:digitAT/pages/payment.dart';
import 'package:digitAT/pages/pharmacies.dart';
import 'package:digitAT/pages/prescription.dart';
import 'package:digitAT/pages/waiting_room.dart';
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
        case '/editAcount':
        return MaterialPageRoute(builder: (_) => EditAcount(profile:args)); 
        case '/account':
        return MaterialPageRoute(builder: (_) => AcountWidget(acountInfos: args)); 
      case '/home':
        return MaterialPageRoute(builder: (_) => TabsWidget(acountInfos: args,));
      case '/chat' :
        return MaterialPageRoute(builder: (_) => ChatWidget());
      case '/doctors':
        return MaterialPageRoute(builder: (_) => DoctorsList(pageNav: args,));  
      case '/doctorProfil':
        return MaterialPageRoute(builder: (_) => DoctorAcount(doctor: args,));
      case '/firstDoctorBook':
        return MaterialPageRoute(builder: (_) => DoctorBookFirstStep(doctor: args,));
      case '/secondeDoctorBook':
        return MaterialPageRoute(builder: (_) => DoctorBookSecondeStep(value: args));
      case '/offers':
        return MaterialPageRoute(builder: (_) => OffersList());
      case '/bookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnline(pageNav: args));
      case '/secondeBookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnlineSecondeStep(value: args,));
      case '/thirdBookTest':
        return MaterialPageRoute(builder: (_) => BookTestsOnlineThirdStep(value: args,));
      case "/fourthBookTest":
        return MaterialPageRoute(builder: (_) => BookTestsOnlineFourthStep());
      case '/medecines':
        return MaterialPageRoute(builder: (_) => Medecines(value: args));
      case '/medecinesSeconde':
        return MaterialPageRoute(builder: (_) => MedecinesSlected(value: args,));
      case '/mydoctors':
        return MaterialPageRoute(builder: (_) => MyDoctorsList());
      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentsList());
      case '/health':
        return MaterialPageRoute(builder: (_) => HealthTips());
        case '/pharmacies':
        return MaterialPageRoute(builder: (_) => Pharmacies(pageNav: args,));
        case '/prescription':
        return MaterialPageRoute(builder: (_) => Prescription());
        case '/payments':
        return MaterialPageRoute(builder: (_) => Paymnt(payment: args,));
        case '/paymentslist':
        return MaterialPageRoute(builder: (_) => PaymentsList());
        case '/doctorcategories':
        return MaterialPageRoute(builder: (_) => DoctorsCat(pageNav: args,));
        case '/imagingcentres':
        return MaterialPageRoute(builder: (_) => ImagingCentres(pageNav:args,));
        case '/covidservices':
        return MaterialPageRoute(builder: (_) => CovIDServices(pageNav:args,));
          case '/labs':
        return MaterialPageRoute(builder: (_) => Labs(pageNav: args,));
        case '/hospitals':
        return MaterialPageRoute(builder: (_) => Hospitals());
        case '/waitingroom':
        return MaterialPageRoute(builder: (_) => WaitingRoom());
        case '/hospitaloptions':
        return MaterialPageRoute(builder: (_) => HospitalOptions(pageNav: args,));
        case '/firstlabsbooking':
        return MaterialPageRoute(builder: (_) => BookDignosticsOnline(pageNav: args,));
        case '/secondlabsbooking':
        return MaterialPageRoute(builder: (_) => BookDignosticsOnlineSecondeStep(value: args,));
        case '/thirdlabsbooking':
        return MaterialPageRoute(builder: (_) => BookDignosticsOnlineThirdStep(value: args,));



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