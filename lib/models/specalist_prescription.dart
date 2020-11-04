import 'package:digitAT/models/presciption_item.dart';

class SpecialistPrescription{

  String id;
  String specialistName;
  String specialistProfession;
  List<PresciptionItem> items;

  SpecialistPrescription(this.id,this.specialistName,this.specialistProfession,this.items);
}