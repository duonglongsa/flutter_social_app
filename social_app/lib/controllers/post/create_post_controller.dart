import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/post_service.dart';

class CreatePostController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? userId, token;
  final TextEditingController describedController = TextEditingController();
  List<File> imagePath = [];
  String videoPath = '';
  @override
  void onInit() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
    super.onInit();
  }

  void addPost() async {
    List<String> base64Image = [];
    for(File file in imagePath){
      List<int> bytes = await file.readAsBytes();
      String img64 = base64Encode(bytes);
      base64Image.add("data:image/jpeg;base64," + img64);
    }
    var res = await createPost(
        Post(userId, describedController.text, base64Image, videoPath), token!);
    print(res);
  }

  void pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePath.add(File(image!.path));
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
