import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/chat_service.dart';

class RoomChatController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  List<RoomModel>? roomChatList;
 
  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
    roomChatList = await ChatService.getChatRoomList(token!, userId!);
    update();
  }

  
}
