import 'dart:convert';

List<FirstAidModel> firstAidModelFromJson(String str) => List<FirstAidModel>.from(json.decode(str).map((x) => FirstAidModel.fromJson(x)));

String firstAidModelToJson(List<FirstAidModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirstAidModel {
  FirstAidModel({
    this.firstAidId,
    this.engName,
    this.urName,
    this.icon,
    this.insertedTime,
    this.updateTime,
    this.firstAidLists,
  });

  int firstAidId;
  String engName;
  String urName;
  String icon;
  DateTime insertedTime;
  DateTime updateTime;
  List<FirstAidList> firstAidLists;

  factory FirstAidModel.fromJson(Map<String, dynamic> json) => FirstAidModel(
    firstAidId: json["firstAidID"] != null ? json["firstAidID"] : -1,
    engName: json["engName"] != null ? json["engName"] : "",
    urName: json["urName"] != null ? json["urName"] : "",
    icon: json["icon"] != null ? json["icon"] : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : null,
    updateTime: json["updateTime"] != null ? DateTime.parse(json["updateTime"]) : null,
    firstAidLists: json["firstAidLists"] != null ? List<FirstAidList>.from(json["firstAidLists"].map((x) => FirstAidList.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "firstAidID": firstAidId,
    "engName": engName,
    "urName": urName,
    "icon": icon,
    "insertedTime": insertedTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "firstAidLists": List<dynamic>.from(firstAidLists.map((x) => x.toJson())),
  };
}

class FirstAidList {
  FirstAidList({
    this.listId,
    this.firstAidCategoriesId,
    this.engListName,
    this.urListName,
    this.engDetail,
    this.urDetail,
    this.imageUrl,
    this.engHeading,
    this.urHeading,
    this.insertedTime,
    this.updateTime,
    this.firstAidStepLists,
  });

  int listId;
  int firstAidCategoriesId;
  String engListName;
  String urListName;
  String engDetail;
  String urDetail;
  String imageUrl;
  String engHeading;
  String urHeading;
  DateTime insertedTime;
  DateTime updateTime;
  List<FirstAidStepList> firstAidStepLists;

  factory FirstAidList.fromJson(Map<String, dynamic> json) => FirstAidList(
    listId: json["listID"] != null ? json["listID"] : -1,
    firstAidCategoriesId: json["firstAidCategoriesID"] != null ? json["firstAidCategoriesID"] : -1,
    engListName: json["engListName"] != null ? json["engListName"] : "",
    urListName: json["urListName"] != null ? json["urListName"] : "",
    engDetail: json["engDetail"] != null ? json["engDetail"] : "",
    urDetail: json["urDetail"] != null ? json["urDetail"] : "",
    imageUrl: json["imageUrl"] != null ? json["imageUrl"] : "",
    engHeading: json["engHeading"] != null ? json["engHeading"] : "",
    urHeading: json["urHeading"] != null ? json["urHeading"] : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : null,
    updateTime: json["updateTime"] != null ? DateTime.parse(json["updateTime"]) : null,
    firstAidStepLists: json["firstAidStepLists"] != null ? List<FirstAidStepList>.from(json["firstAidStepLists"].map((x) => FirstAidStepList.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "listID": listId,
    "firstAidCategoriesID": firstAidCategoriesId,
    "engListName": engListName,
    "urListName": urListName,
    "engDetail": engDetail,
    "urDetail": urDetail,
    "imageUrl": imageUrl,
    "engHeading": engHeading,
    "urHeading": urHeading,
    "insertedTime": insertedTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "firstAidStepLists": List<dynamic>.from(firstAidStepLists.map((x) => x.toJson())),
  };
}

class FirstAidStepList {
  FirstAidStepList({
    this.stepListId,
    this.firstAidListId,
    this.engStepNumber,
    this.urStepNumber,
    this.imageUrl,
    this.engStepDetails,
    this.urStepDetails,
    this.insertedTime,
    this.updateTime,
  });

  int stepListId;
  int firstAidListId;
  String engStepNumber;
  String urStepNumber;
  String imageUrl;
  String engStepDetails;
  String urStepDetails;
  DateTime insertedTime;
  DateTime updateTime;

  factory FirstAidStepList.fromJson(Map<String, dynamic> json) => FirstAidStepList(
    stepListId: json["stepListID"] != null ? json["stepListID"] : -1,
    firstAidListId: json["firstAidListID"] != null ? json["firstAidListID"] : -1,
    engStepNumber: json["engStepNumber"] != null ? json["engStepNumber"] : "",
    urStepNumber: json["urStepNumber"] != null ? json["urStepNumber"] : "",
    imageUrl: json["imageUrl"] != null ? json["imageUrl"] : "",
    engStepDetails: json["engStepDetails"] != null ? json["engStepDetails"] : "",
    urStepDetails: json["urStepDetails"] != null ? json["urStepDetails"] : "",
    insertedTime: json["insertedTime"] != null ? DateTime.parse(json["insertedTime"]) : null,
    updateTime: json["updateTime"] != null ? DateTime.parse(json["updateTime"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "stepListID": stepListId,
    "firstAidListID": firstAidListId,
    "engStepNumber": engStepNumber,
    "urStepNumber": urStepNumber,
    "imageUrl": imageUrl,
    "engStepDetails": engStepDetails,
    "urStepDetails": urStepDetails,
    "insertedTime": insertedTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
  };
}