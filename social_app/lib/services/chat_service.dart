import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/utilities/configs.dart';

//todo: chinh lai api de fetch

class ChatService {
  static Future<List<MessageModel>> getMessageList(
      String token, String userId, String chatId) async {
    var res = await http
        .get(Uri.parse(localhost + "/v1/chats/getMessages/$chatId"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    var responseJson = json.decode(res.body);
    print(responseJson["data"].toString());
    return (responseJson["data"] as List).map((p) {
      MessageModel messageModel = MessageModel.fromJson(p);
      messageModel.isSender = (messageModel.sender!.id == userId);
      return messageModel;
    }).toList();
  }

  static Future<void> sendMessage(String token, MessageModel message) async {
    var res =
        await http.post(Uri.parse(localhost + "/v1/chats/send"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      "chatId": message.roomId,
      "receivedId": message.receiver!.id,
      "member": "",
      "type": "PRIVATE_CHAT",
      "content": message.content
    });

    var responseJson = json.decode(res.body);
    print(res.statusCode);
    print(responseJson["data"].toString());
  }

  static Future<List<RoomModel>> getChatRoomList(
      String token, String userId) async {
    var res = await http
        .post(Uri.parse(localhost + "/v1/chats/getConversationList"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    var responseJson = json.decode(res.body);
    print(responseJson["message"]);
    List<RoomModel> roomList = (responseJson["data"] as List)
        .map((p) => RoomModel.fromJson(p))
        .toList();

    for (RoomModel room in roomList) {
      room.memberId.remove(userId);
      for (String userId in room.memberId) {
        room.memberName
            .add(((await FriendService.getUserProfile(token, userId)).name!));
      }
    }

    return roomList;
  }
}
