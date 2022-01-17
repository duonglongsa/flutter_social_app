import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  Future getUserInfo() async {
    userId = await storage.read(key: 'userId');
    token = await storage.read(key: 'token');
    user = await FriendService.getUserInfo(token!, '');
    update();
  }

  Future onSaveInfo() async {
    formKey.currentState!.save();
    print(user!.address);
    print(DateFormat("yyyy-MM-ddTHH:mm:ss").format(user!.birthDay!));
    print(user!.gender);
    await AuthService.editProFile(token!, user!);
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
}
