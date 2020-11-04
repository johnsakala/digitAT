
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

  MedList(this.pid,this.list,this.bill, this.pharmacy, this.responsibleId,this.quantity);
  MedList.scan(this.pharmacy,this.pid,this.bill,this.list, this.responsibleId);
  MedList.second(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID,this.quantity);
  MedList.p(this.pid,this.list,this.bill, this.pharmacy, this.responsibleId,this.quantity, this.pageNav);
  MedList.pscan(this.pharmacy,this.pid,this.bill,this.list, this.responsibleId, this.pageNav);
  MedList.psecond(this.pid,this.list,this.bill, this.pharmacy, this.pharmacistID,this.quantity,this.pageNav);
}