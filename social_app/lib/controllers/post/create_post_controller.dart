import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/image.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/post_service.dart';
import 'package:social_app/utilities/style_constants.dart';

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
    List<ImageModel> base64Image = [];
    for (File file in imagePath) {
      List<int> bytes = await file.readAsBytes();
      String img64 = base64Encode(bytes);
      base64Image.add(ImageModel("data:image/jpeg;base64," + img64));
    }
    await PostService.createPost(
        Post(userId, describedController.text, base64Image, videoPath), token!);
  }

  void pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: backGroundColor,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    imagePath.add(File(image!.path));
                    update();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    List<XFile>? images = await ImagePicker().pickMultiImage();
                    for (XFile image in images!) {
                      imagePath.add(File(image.path));
                    }
                    update();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void back() {
    Get.defaultDialog(
        middleText: "Cancel post?",
        textConfirm: 'OK',
        textCancel: 'Cancel',
        onConfirm: () {
          Get.back(closeOverlays: true);
        },
        onCancel: () {});
  }
}
