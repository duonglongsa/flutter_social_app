import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/chat/room_chat_controller.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/chat/chat_screen.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/services/friend_service.dart';

class FriendController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;

  // final messageList = <MessageModel>[].obs;
  // List<MessageModel> get messages => messageList.value;
  List<User> ?requestFriendList;
  List<User> ?friendList;


  TextEditingController messageTextConntroller = TextEditingController();
 
  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
    getRequestList();
    getFList();
  }

  Future getFList() async {
    friendList = await FriendService.getFriendList(token!);
    update();
  }

  Future joinChatRoom(User friend) async {
    final RoomChatController roomChatController = Get.find<RoomChatController>();
    String roomId = "";
    for(RoomModel room in roomChatController.roomChatList!){
      if(room.memberId.contains(friend.id)){
        roomId = room.roomId!;
      }
    }
    if(roomId == ""){
      roomId = await ChatService.sendMessage(token!, MessageModel(friend, "", "Hello ${friend.name}"));
    }
    Get.to(()=>ChatScreen(roomId: roomId, member: friend))!.then((value) async => {
      await roomChatController.getChatRoomList()
    });
  }

  Future getRequestList() async {
    requestFriendList = await FriendService.getRequestFriendList(token!);
    update();
  }

  Future acceptFriend(String userId, bool isAccept) async {
    await FriendService.acceptFriendRequest(token!, userId, isAccept);
    await getRequestList();
    await getFList();
    update();
  }
  
}
