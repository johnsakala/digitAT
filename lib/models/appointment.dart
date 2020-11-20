import 'package:flutter/material.dart';
import 'package:digitAT/models/doctor.dart';

class Appointment{
  double bill;
  String date;
  Doctor doctor;
  String id =UniqueKey().toString();
  String taskId;

  Appointment(this.date,this.doctor, this.taskId, this.bill);
}
class ApointmentList{
  Doctor currentDoctor = new Doctor.init().getCurrentDoctor();

  List<Appointment> _appointmentList;

  ApointmentList(){
    this._appointmentList =[
 
    ];
  }

  List<Appointment> get appointment => _appointmentList;
}