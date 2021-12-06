import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/create_post/views/create_post_screen.dart';
import 'package:social_app/screens/home_page/views/home_page_screen.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/post_service.dart';

class CreatePostController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? userId, token;

  @override
  void onInit() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
    print("read user data: " + userId! + token!);
    super.onInit();
  }

  final TextEditingController describedController = TextEditingController();
  String imagePath = '';
  String videoPath = '';

  void addPost() async {
    print(imagePath);
    var res = await createPost(
        Post(userId, describedController.text, imagePath, videoPath), token!);
  }

  void pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    imagePath = image!.path;
    update();
  }

  void back() {
    Get.defaultDialog(
      middleText: "Cancel post?",
      textConfirm: 'OK',
      textCancel: 'Cancel',
      onConfirm: () {
        Get.back(closeOverlays: true);
      },
      onCancel: (){

      }
    );
  }
}
