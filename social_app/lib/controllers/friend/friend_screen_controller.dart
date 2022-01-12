import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/user.dart';
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

  Future getRequestList() async {
    requestFriendList = await FriendService.getRequestFriendList(token!);
    update();
  }

  Future acceptFriend(String userId, bool isAccept) async {
    await FriendService.acceptFriendRequest(token!, userId, isAccept);
    await getRequestList();
    update();
  }
  
}
