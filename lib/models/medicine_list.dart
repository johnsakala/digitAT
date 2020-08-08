
import 'package:digitAT/models/medecine.dart';

class MedList{
   String pharmacy;
    String pid;
    String pharmacistID;
  double bill;
  List<Medecine> list;

  
  MedList(this.pid,this.list,this.bill, this.pharmacy);
  MedList.second(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID);
}