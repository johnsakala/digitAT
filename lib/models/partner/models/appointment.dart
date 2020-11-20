import 'package:flutter/material.dart';
import 'package:digitAT/models/partner/models/doctor.dart';

class Appointment{
  String id =UniqueKey().toString();
  String taskid;
  Doctor doctor;
  String date;
  
  Appointment(this.date,this.doctor, this.taskid);

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