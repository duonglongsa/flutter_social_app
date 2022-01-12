import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user.dart';

enum ChatType {PRIVATE_CHAT, GROUP_CHAT,}

extension ChatTypeString on String {
  ChatType get chatType {
    switch (this) {
      case 'PRIVATE_CHAT':
        return ChatType.PRIVATE_CHAT;
      case 'GROUP_CHAT':
        return ChatType.GROUP_CHAT;
      default:
        return ChatType.PRIVATE_CHAT;
    }
  }
}


class RoomModel {
  String? roomId;
  List<String> memberId;
  //ChatType type;
  DateTime createdAt, updatedAt;
  MessageModel lastMessage;
  List<String> memberName = [];

  //["data"]["chat"]
  RoomModel.fromJson(Map<String, dynamic> json)
      : roomId = json["_id"],
        memberId = List.castFrom(json["member"]),
        //type = json["type"].chatType,
        lastMessage = MessageModel.fromChatRoom(json["lastMess"]),
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]);
}
