import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'User.g.dart';

@JsonSerializable()
class User with ChangeNotifier {
  String email = '';
  String firstName = '';
  String lastName = '';
  //Settings settings = Settings(allowPushNotifications: true);
  String phoneNumber = '';
  bool active = false;
  //Timestamp lastOnlineTimestamp = Timestamp.now();
  String userID;
  String profilePictureURL = '';
  bool selected = false;
  String fcmToken = '';
  String appIdentifier = 'digitAT ${Platform.operatingSystem}';

  User(
      {this.email,
      this.firstName,
      this.phoneNumber,
      this.lastName,
      this.active,
     // this.lastOnlineTimestamp,
      //this.settings,
      this.fcmToken,
      this.userID,
      this.profilePictureURL});
      User.init();

  String fullName() {
    return '$firstName $lastName';
  }
  

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class Settings {
  bool allowPushNotifications = true;

  Settings({this.allowPushNotifications});

  factory Settings.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new Settings(
        allowPushNotifications: parsedJson['allowPushNotifications'] ?? true);
  }

  Map<String, dynamic> toJson() {
    return {'allowPushNotifications': this.allowPushNotifications};
  }
}
