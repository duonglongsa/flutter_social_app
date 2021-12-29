import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';


class SearchFriendController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;

  TextEditingController messageTextConntroller = TextEditingController();
 
  @override
  void onInit() async {
    super.onInit();
    userId = await storage.read(key: "userId");
    token = await storage.read(key: "token");
  }

  
}
