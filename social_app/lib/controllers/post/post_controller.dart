import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/comment_service.dart';
import 'package:social_app/services/post_service.dart';

class PostController extends GetxController {

  final  storage = const FlutterSecureStorage();
  String ?userId, postId, token;
  List<CommentModel> ?commentList;

  TextEditingController commentController = TextEditingController();
  
  Future getUserInfo() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
  }

  Future<List<CommentModel>> getList() async {
    commentList = await CommentService.getCommentList(postId!, token!);
    commentList = commentList!.reversed.toList();   //newest post first
    update();
    print("update");
    return commentList!;
  }

  // void removePostFromList(String postId){
  //   postList!.removeWhere((item) => item.postID == postId);
  //   update();
  // }

}
