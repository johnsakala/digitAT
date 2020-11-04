import 'package:digitAT/models/partner/models/doctor.dart' as model;

class DoctorBooking{
  model.Doctor doctor;
  DateTime date;
  String timeSlot;

  DoctorBooking(this.doctor,this.timeSlot, this.date);

}