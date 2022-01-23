import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/services/post_service.dart';

class HomeController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, token;
  User? currentUser;
  List<Post> ?postList;
  BuildContext? context;
  
  Future getUserInfo() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
    currentUser = await FriendService.getUserInfo(token!, userId!);
  }

  Future<List<Post>> getList() async {
    postList = await PostService.getPostList(token!,"");
    postList = postList!.reversed.toList();
    update();
    return postList!;
  }

  void removePostFromList(String postId){
    postList!.removeWhere((item) => item.postID == postId);
    showMessage("Delete successful!", context!);
    update();
  }

}
