import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
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
    user = await getUserProfile(token!, profileId);
    update();
  }

  void getProfilePost(String profileId) async {
    postList = await getPostList(token!, "?userId=$profileId");
    update();
  }

}
