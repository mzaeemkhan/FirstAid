// To parse this JSON data, do
//
//     final emergencyContactModel = emergencyContactModelFromJson(jsonString);
import 'dart:convert';

List<EmergencyContactModel> emergencyContactModelFromJson(String str) => List<EmergencyContactModel>.from(json.decode(str).map((x) => EmergencyContactModel.fromJson(x)));

String emergencyContactModelToJson(List<EmergencyContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmergencyContactModel {
  EmergencyContactModel({
    this.contactId,
    this.emergency,
    this.phoneNumber,
    this.imageUrl,
    this.insertedTime,
    this.updateTime,
  });

  int contactId;
  String emergency;
  String phoneNumber;
  String imageUrl;
  DateTime insertedTime;
  DateTime updateTime;

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) => EmergencyContactModel(
    contactId: json["contactID"],
    emergency: json["emergency"],
    phoneNumber: json["phoneNumber"],
    imageUrl: json["imageUrl"],
    insertedTime: DateTime.parse(json["insertedTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "contactID": contactId,
    "emergency": emergency,
    "phoneNumber": phoneNumber,
    "imageUrl": imageUrl,
    "insertedTime": insertedTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
  };
}
