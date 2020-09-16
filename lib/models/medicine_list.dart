
import 'package:digitAT/models/medecine.dart';

class MedList{
   String pharmacy;
    String pid;
    String pharmacistID;
    String responsibleId;
  double bill;
  int quantity;
  List<Medecine> list;

  
  MedList(this.pid,this.list,this.bill, this.pharmacy, this.responsibleId,this.quantity);
  MedList.scan(this.pharmacy,this.pid,this.bill,this.list, this.responsibleId);
  MedList.second(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID,this.quantity);
}