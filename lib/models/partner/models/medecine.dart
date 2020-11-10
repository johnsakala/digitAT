import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Medecine.g.dart';
@JsonSerializable()
class Medecine{
  String id =UniqueKey().toString();
  String name;
  String price;
  int quantity;
  double unitPrice;
  Medecine.init();
  Medecine(this.name,this.price);
  Medecine.cart(this.name,this.price,this.quantity, this.unitPrice);
factory Medecine.fromJson(Map<String, dynamic> json) => _$:MedecineFromJson(json);
  Map<String, dynamic> toJson() => _$MedecineToJson(this);
@override
  String toString() {
    // TODO: implement toString
    return this.id+" "+ this.name+" "+this.price;
  }

}



class MedecinesList{
  List<Medecine> medecinesMist;
  MedecinesList(){
    this.medecinesMist=[
      new Medecine("Paracetamol", "20\$"),
      new Medecine("Amlor", "45\$"),
      new Medecine("Tahor", "55\$"),
      new Medecine("Rumafed", "22\$"),
      new Medecine("Paracetamol", "20\$"),
      new Medecine("Amlor", "45\$"),

  ];

  }
  List<Medecine> get medecine => medecinesMist;
}