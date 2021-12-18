import 'dart:convert';
import 'package:social_app/models/user.dart';

enum ChatType {PRIVATE_CHAT, GROUP_CHAT,}

class RoomModel {
  String? roomId;
  String? name;
  List<String> member;
  ChatType type;
  DateTime createdAt, updatedAt;

  //["data"]["chat"]
  RoomModel.fromJson(Map<String, dynamic> json)
      : roomId = json["_id"],
        name = json["chat"],
        member = json["chat"]["member"] as List<String>,
        type = json["chat"]["type"],
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]);
}
