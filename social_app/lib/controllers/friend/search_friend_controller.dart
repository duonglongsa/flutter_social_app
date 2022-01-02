import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/services/friend_service.dart';


class SearchFriendController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  bool isLoading = false;

  TextEditingController searchTextConntroller = TextEditingController();

  List<User>? searchFriendList, searchUserList;
 
  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
  }

  Future getSearchList(String val) async {
    isLoading = true;
    update();
    searchFriendList = await getSearchFriendList(token!, val);
    searchUserList = await getSearchUserList(token!, val);
    isLoading = false;
    update();
  }

  
}
