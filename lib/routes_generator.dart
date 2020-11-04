import 'package:digitAT/comm/contacts/ContactsScreen.dart';
import 'package:digitAT/comm/conversations/ConversationsScreen.dart';
import 'package:digitAT/comm/search/SearchScreen.dart';
import 'package:digitAT/pages/acount.dart';
import 'package:digitAT/pages/book_dignostics1.dart';
import 'package:digitAT/pages/book_dignostics2.dart';
import 'package:digitAT/pages/book_dignostics3.dart';
import 'package:digitAT/pages/covid_services.dart';
import 'package:digitAT/pages/doctor_catergories.dart';
import 'package:digitAT/pages/editAccount.dart';
import 'package:digitAT/pages/conversations.dart' as con;
import 'package:digitAT/pages/home.dart';
import 'package:digitAT/pages/hospital_options.dart';
import 'package:digitAT/pages/partner/pages/Welcome.dart' as partnerWelcome;
import 'package:digitAT/pages/hospitals.dart';
import 'package:digitAT/pages/imaging_centres.dart';
import 'package:digitAT/pages/labs.dart';
import 'package:digitAT/pages/my_payments.dart';
import 'package:digitAT/pages/partner/pages/account.card.dart';
import 'package:digitAT/pages/partner/pages/add_departments.dart';
import 'package:digitAT/pages/partner/pages/appointment.card.dart';
import 'package:digitAT/pages/partner/pages/conversations.dart';
import 'package:digitAT/pages/createAccount.dart';
import 'package:digitAT/pages/partner/pages/home.dart';
import 'package:digitAT/pages/partner/pages/home_options.dart';
import 'package:digitAT/pages/partner/pages/hospital_reg.dart';
import 'package:digitAT/pages/partner/pages/partner_lab.dart';
import 'package:digitAT/pages/partner/pages/partner_pharmacy.dart';
import 'package:digitAT/pages/partner/pages/partner_scan.dart';
import 'package:digitAT/pages/partner/pages/patient_account.dart';
import 'package:digitAT/pages/payment.dart';
import 'package:digitAT/pages/pharmaHub_prescription.dart';
import 'package:digitAT/pages/pharmacies.dart';
import 'package:digitAT/pages/prescription.dart';
import 'package:digitAT/pages/tabs.dart';
import 'package:digitAT/pages/waiting_room.dart';
import 'package:digitAT/signup_option.dart';
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
import 'package:digitAT/pages/docotr_acount.dart';
import 'package:digitAT/pages/doctors.dart';

import 'package:digitAT/pages/phoneNumber_login.dart';
import 'package:digitAT/pages/partner/pages/phoneNumber_login.dart' as par;
import 'package:digitAT/pages/signup.dart';
import 'package:digitAT/pages/partner/pages/signup.dart' as sign;

import 'package:digitAT/pages/verification_number.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch(settings.name){
      case '/' :
        return MaterialPageRoute(builder: (_) => SignupOptions());  
        case '/patientWelcome' :
        return MaterialPageRoute(builder: (_) => Welcome()); 

        case '/comConversations' :
        return MaterialPageRoute(builder: (_) =>ConversationsScreen(user:args,)); 

        case '/partnerWelcome' :
        return MaterialPageRoute(builder: (_) => partnerWelcome.Welcome());     
      case '/signup' :
        return MaterialPageRoute(builder: (_) => SignUp());
        case '/signupPartner' :
        return MaterialPageRoute(builder: (_) => sign.SignUp());
      case '/phone':
        return MaterialPageRoute(builder: (_) => PhoneLogin());
        case '/phonePartner':
        return MaterialPageRoute(builder: (_) =>par.PhoneLogin());
      case '/verification':
        return MaterialPageRoute(builder: (_) => VerificationNumber("",""));
      case '/createAcount':
        return MaterialPageRoute(builder: (_) => CreateAcount(accountInfo: args,)); 
        case '/editAcount':
        return MaterialPageRoute(builder: (_) => EditAcount(profile:args)); 
        case '/account':
        return MaterialPageRoute(builder: (_) => AccountCard()); 
        case '/partnerpharmacy':
        return MaterialPageRoute(builder: (_) => PartnerPharmacy(user: args,)); 
        case '/partnerscan':
        return MaterialPageRoute(builder: (_) => PartnerScan(user: args,)); 
        case '/partnerlab':
        return MaterialPageRoute(builder: (_) => PartnerLab(user: args,));
        case '/addDepart':
        return MaterialPageRoute(builder: (_) => AddDepartments (seleted: args,));
        
        case '/inbox':
        return MaterialPageRoute(builder: (_) => Conversation()); 

        case '/contacts':
        return MaterialPageRoute(builder: (_) => ContactsScreen(user: args,));
        case '/searchScreen':
        return MaterialPageRoute(builder: (_) => SearchScreen(user: args,));
        case '/home':
        return MaterialPageRoute(builder: (_) => HospitalDashboardHome(user:args)); 
         case '/homePatient':
        return MaterialPageRoute(builder: (_) => TabsWidget(acountInfos:args)); 
     case '/homeoptions' :
        return MaterialPageRoute(builder: (_) => HomeOptions(user:args));
        case '/conversation':
        return MaterialPageRoute(builder: (_) => con.Conversation()); 
        case '/covidServices':
        return MaterialPageRoute(builder: (_) => CovIDServices()); 
     case '/account' :
        return MaterialPageRoute(builder: (_) => AcountWidget(acountInfos: args,));
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
        return MaterialPageRoute(builder: (_) => AppointmentCard());
      case '/health':
        return MaterialPageRoute(builder: (_) => HealthTips());
        case '/pharmacies':
        return MaterialPageRoute(builder: (_) => Pharmacies(pageNav: args,));
        case '/prescription':
        return MaterialPageRoute(builder: (_) => Prescription());
        case '/pharmaPrescription':
        return MaterialPageRoute(builder: (_) => PharmaHubPrescription());
        case '/payments':
        return MaterialPageRoute(builder: (_) => Paymnt(payment: args,));
        case '/paymentslist':
        return MaterialPageRoute(builder: (_) => PaymentsList());
        case '/doctorcategories':
        return MaterialPageRoute(builder: (_) => DoctorsCat(pageNav: args,));
        case '/imagingcentres':
        return MaterialPageRoute(builder: (_) => ImagingCentres(pageNav:args,));
          case '/labs':
        return MaterialPageRoute(builder: (_) => Labs(pageNav: args,));
        case '/hospitals':
        return MaterialPageRoute(builder: (_) => Hospitals());
        case '/patientacc':
        return MaterialPageRoute(builder: (_) => PatientAccount(patient: args,));
        case '/hospitalreg':
        return MaterialPageRoute(builder: (_) => HospitalReg());
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