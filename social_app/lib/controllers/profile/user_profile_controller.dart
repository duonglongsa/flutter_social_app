import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/chat/room_chat_controller.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/chat/chat_screen.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/services/post_service.dart';



class UserProfleController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  bool isLoading = false;
  User ?user;
  List<Post> postList = [];
 
  Future getUserInfo() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
  }

  
  void getProfileUser(String profileId) async {
    user = await FriendService.getUserInfo(token!, profileId);
    update();
  }

  Future getProfilePost(String profileId) async {
    postList = await PostService.getPostList(token!, "?userId=$profileId");
    postList = postList.reversed.toList();
    update();
  }

  Future blockUser() async {
    await FriendService.blockUser(token!, user!.id!);
    update();
  }

  Future sendFriendRequset() async {
    await FriendService.sendRequestFriend(token!, userId!);
    update();
  }

  Future joinChatRoom() async {
    final RoomChatController roomChatController = Get.find<RoomChatController>();
    String roomId = "";
    for(RoomModel room in roomChatController.roomChatList!){
      if(room.memberId.contains(user!.id)){
        roomId = room.roomId!;
      }
    }
    if(roomId == ""){
      roomId = await ChatService.sendMessage(token!, MessageModel(user!, "", "Hello ${user!.name}"));
    }
    Get.to(()=>ChatScreen(roomId: roomId, member: user!))!.then((value) async => {
      await roomChatController.getChatRoomList()
    });
  }

}
