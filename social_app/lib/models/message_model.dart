import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_app/models/user.dart';

class MessageModel {
  String? roomId;
  User? sender;
  String? messageId;
  DateTime? timeCreated;
  DateTime? timeUpdated;
  String? content;
  bool isSender = false;
  User? receiver;

  MessageModel(this.receiver, this.roomId, this.content);

  //[data]
  MessageModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        roomId = json["chat"],
        timeCreated = DateTime.parse(json["createdAt"]),
        sender = User.fromPostJson(json["user"]),
        timeUpdated = DateTime.parse(json["updatedAt"]),
        messageId = json["_id"];
}