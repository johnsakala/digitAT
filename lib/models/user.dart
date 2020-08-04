import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

class User {
  String id = UniqueKey().toString();
  String name;
  String phoneNumber;
  String gender;
  String userID;
  DateTime dateOfBirth;
  String avatar;

  User.init();

  User.basic(this.name, this.phoneNumber, this.userID);

  User.advanced(this.name, this.gender, this.dateOfBirth, this.avatar,this.phoneNumber);

  User getCurrentUser() {
    return User.basic(this.name, this.phoneNumber, this.userID);
  }
  void setCurrentUser(String name, String phoneNumber, String userId){
    this.name=name;
    this.phoneNumber=phoneNumber;
    this.userID=userId;
  }
  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
  }
}
