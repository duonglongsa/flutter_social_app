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

  MessageModel.fromChatRoom(Map<String, dynamic> json)
      : sender = User.id(json["user"]),
        content = json["content"],
        timeUpdated = DateTime.parse(json["updatedAt"]),
        timeCreated = DateTime.parse(json["createdAt"]);

  //[data]
  MessageModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        roomId = json["chat"],
        timeCreated = DateTime.parse(json["createdAt"]),
        sender = User.fromCommentJson(json["user"]),
        timeUpdated = DateTime.parse(json["updatedAt"]),
        messageId = json["_id"];

  MessageModel.fromSocket(Map<String, dynamic> json)
      : sender = User.id(json["user_id"]),
        content = json["text"],
        timeUpdated = DateTime.parse(json["time"]),
        timeCreated = DateTime.parse(json["time"]);
}
