
import 'package:digitAT/models/partner/models/medecine.dart';
import 'package:digitAT/models/partner/models/navigation.dart';

class MedList{
   String pharmacy;
    String pid;
    String pharmacistID;
    String responsibleId;
  double bill;
  int quantity;
  List<Medecine> list;
  PageNav pageNav;
  List<String> medNames;

  MedList(this.pid,this.list,this.bill, this.pharmacy, this.responsibleId,this.quantity, this.medNames);
  MedList.scan(this.pharmacy,this.pid,this.bill,this.list, this.responsibleId, this.medNames);
  MedList.second(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID,this.quantity, this.medNames);
  MedList.p(this.pid,this.list,this.bill, this.pharmacy, this.responsibleId,this.quantity, this.pageNav, this.medNames);
  MedList.pscan(this.pharmacy,this.pid,this.bill,this.list, this.responsibleId, this.pageNav, this.medNames);
  MedList.psecond(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID,this.quantity,this.pageNav, this.medNames);
}