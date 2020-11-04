import 'package:digitAT/models/medecine.dart';
import 'package:digitAT/models/model/User.dart';

class PageNav{
  String title;
  String id;
  String responsibleId;
  double bill;
  User user;
  List<Medecine> list;

 

  PageNav.inti();
  PageNav.min(this.title,this.id, this.responsibleId);
  PageNav(this.title,this.id,this.bill,this.list, this.responsibleId);
}