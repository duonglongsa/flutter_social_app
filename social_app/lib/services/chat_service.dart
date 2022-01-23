import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

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
    return (responseJson["data"] as List).map((p) {
      MessageModel messageModel = MessageModel.fromJson(p);
      messageModel.isSender = (messageModel.sender!.id == userId);
      return messageModel;
    }).toList();
  }

  static Future<String> sendMessage(String token, MessageModel message) async {
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
    return responseJson["data"]["chat"]["_id"];
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
    List<RoomModel> roomList = (responseJson["data"] as List)
        .map((p) => RoomModel.fromJson(p))
        .toList();

    for (RoomModel room in roomList) {
      room.memberId.remove(userId);
      for (String userId in room.memberId) {
        room.member.add(((await FriendService.getUserInfo(token, userId))));
      }
    }

    return roomList;
  }

  static Future<void> deleteMessage(String token, String messageId) async {
    var res = await http.delete(
      Uri.parse(localhost + "/v1/chats/deleteMessage/$messageId"),
      headers: {
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(res.statusCode);
  }

  static Future<void> deleteChatRoom(String token, String roomId) async {
    var res = await http.delete(
      Uri.parse(localhost + "/v1/chats/deleteConversation/$roomId"),
      headers: {
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(res.statusCode);
  }

  static IO.Socket getChatSocket() {
    print("123");
    IO.Socket socket = IO.io(
        'http://192.168.1.3:3500',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.onConnectError((data) => print(data));
    print(socket.connected);
    return socket;
  }
}
