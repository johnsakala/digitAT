

import 'medecine.dart';

class Payments{

 
  String title;
  String description;
  String responsibleID;
   List<Medecine>  medicines;


  Payments.init();
  Payments(this.title,this.description,this.responsibleID, this.medicines);
}