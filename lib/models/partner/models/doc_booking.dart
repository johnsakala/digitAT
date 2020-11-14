import 'package:digitAT/models/partner/models/confirm_booking.dart';
import 'package:digitAT/models/partner/models/doctor.dart' as model;

class DoctorBooking{
  ConfirmBooking doctor;
  DateTime date;
  String timeSlot;

  DoctorBooking(this.doctor,this.timeSlot, this.date);

}