// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    lastName: json['lastName'] as String,
    active: json['active'] as bool,
    fcmToken: json['fcmToken'] as String,
    userID: json['userID'] as String,
    profilePictureURL: json['profilePictureURL'] as String,
  )
    ..selected = json['selected'] as bool
    ..appIdentifier = json['appIdentifier'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'active': instance.active,
      'userID': instance.userID,
      'profilePictureURL': instance.profilePictureURL,
      'selected': instance.selected,
      'fcmToken': instance.fcmToken,
      'appIdentifier': instance.appIdentifier,
    };
