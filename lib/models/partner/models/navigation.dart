import 'package:digitAT/models/partner/models/medecine.dart';

class PageNav{
  String title;
  String id;
  String responsibleId;
  double bill;
  String docName;
  String profession;
  String patientId;
  List<Medecine> list;

  PageNav.inti();
  PageNav.special(this.title,this.id,this.patientId,this.docName);
  PageNav.min(this.title,this.id, this.responsibleId);
  PageNav(this.title,this.id,this.bill,this.list, this.responsibleId);
}