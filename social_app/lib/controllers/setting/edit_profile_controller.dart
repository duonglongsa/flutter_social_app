import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/image.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/models/user_info.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/services/post_service.dart';
import 'package:social_app/utilities/style_constants.dart';

class EditProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? userId, token;
  bool isLoading = false;
  User? user;
  final formKey = GlobalKey<FormState>();
  File? coverImagePath;
  File? avatarPath;

  Future getUserInfo() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
  }

  Future onSaveInfo() async {
    isLoading = true;
    update();
    formKey.currentState!.save();
    if (avatarPath != null) {
      List<int> bytes = await avatarPath!.readAsBytes();
      String img64 = base64Encode(bytes);
      user!.avatar = ImageModel("data:image/jpeg;base64," + img64);
    }
    if (coverImagePath != null) {
      List<int> cbytes = await coverImagePath!.readAsBytes();
      String cimg64 = base64Encode(cbytes);
      user!.coverImage = ImageModel("data:image/jpeg;base64," + cimg64);
    }
    await AuthService.editProFile(token!, user!);
    isLoading = false;
    update();
  }

  Future setBirthDay(BuildContext context) async {
    user!.birthDay = (await showDatePicker(
      context: context,
      initialDate: user!.birthDay ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              surface: cointainerColor,
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor: backGroundColor,
          ),
          child: child!,
        );
      },
    ))!;
    update();
  }

  void pickImage(BuildContext context, bool isAvatar) async {
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
                    Get.back();
                    if (isAvatar) {
                      avatarPath = File(image!.path);
                    } else {
                      coverImagePath = File(image!.path);
                      print(coverImagePath);
                    }
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
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (isAvatar) {
                      avatarPath = File(image!.path);
                    } else {
                      coverImagePath = File(image!.path);
                      print(coverImagePath);
                    }
                    Get.back();
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
}
