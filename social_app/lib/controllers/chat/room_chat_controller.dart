import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/screens/chat/chat_screen.dart';
import 'package:social_app/services/chat_service.dart';

class RoomChatController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? userId, token;
  List<RoomModel>? roomChatList;

  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
    roomChatList = await ChatService.getChatRoomList(token!, userId!);
    sortRoomChat();
    update();
  }

  void deleteRoomChat(String roomId) async {
    await ChatService.deleteChatRoom(token!, roomId);
  }

  void sortRoomChat() {
    print("sort");
    roomChatList!.sort((a, b) {
      return b.lastMessage.timeCreated!.compareTo(a.lastMessage.timeCreated!);
    });
  }

  void enterRoomChat(RoomModel room) {
    Get.to(() => ChatScreen(roomId: room.roomId!, member: room.member[0]))!
        .then((result) {
      room.lastMessage = result as MessageModel;
      sortRoomChat();
    });
    print(room.lastMessage.content);
    update();
  }
}
