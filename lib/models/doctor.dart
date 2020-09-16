
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Doctor{
  String id = UniqueKey().toString();
  String name;
  String description;
  String state;
  String userId;
  Color color;
  String avatar;
  String resId;
  String profession;
  bool isFavorited;
 void setIsFavourite(bool isFavourite){
   this.isFavorited= isFavourite;
 }
  Doctor.init();
  
  Doctor.app(this.name, this.avatar);
    Doctor.min(this.name,this.profession,this.avatar,this.state,this.color,this.userId, this.description, this.isFavorited, this.resId);
  Doctor(this.name,this.description,this.avatar,this.state,this.color,this.userId,this.isFavorited, this.resId);
  Doctor getCurrentDoctor() {
    return Doctor("Dr.Alina james", "B.Sc DDVL Demilitologist",
                  "images/asset-1.png","Closed To day", Colors.red,"1",false,"");
  }
}
class DoctorsList{
  List<Doctor> _doctorsList;
  DoctorsList(){
    this._doctorsList =[
//      new Doctor("Dr.Alina james", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-1.png","Closed To day", Colors.red),
//      new Doctor("Dr.Steve Robert", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-2.png","Open To day", Colors.green),
//      new Doctor("Dr.Steve Robert", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-3.png","Open To day", Colors.green),
//      new Doctor("Dr.Alina james", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-4.png","Closed To day", Colors.red),
//      new Doctor("Dr.Frank karima", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-5.png","Closed To day", Colors.green),
//      new Doctor("Dr.Nemeli Aaraf", "B.Sc DDVL Demilitologist 26 years of experience",
//                "images/asset-6.png","Closed To day", Colors.green),
    ];
  }
  List<Doctor> get doctors => _doctorsList;
}