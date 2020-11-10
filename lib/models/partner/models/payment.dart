

import 'medecine.dart';

class Payments{

 
  String title;
  String description;
  String responsibleID;
  double bill;
  DateTime due;
  String resId;
   List<Medecine>  medicines;
   List<String> medNames;


  Payments.init();
  Payments(this.title,this.description,this.responsibleID, this.medicines, this.bill,this.due, this.resId, this.medNames);
}