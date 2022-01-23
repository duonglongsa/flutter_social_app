import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/home_page/home_page_screen.dart';
import 'package:social_app/screens/navigation_screen.dart';
import 'package:social_app/screens/sign_up/signup_screen.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/services/auth.dart';

class SigninController extends GetxController {
  final storage = const FlutterSecureStorage();

  BuildContext? context;

  User? user;
  bool isRememberMe = false;
  bool isLoading = false;

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscureText = true;

  Future pressSignin() async {
    isLoading = true;
    update();
    var res = await AuthService.login(phoneController.text, passwordController.text);
    if (res.statusCode == 200) {
      showMessage("Login successfull!", context!);
      user = User.fromLoginJson(json.decode(res.body));
      await storage.write(key: 'token', value: user!.token);
      await storage.write(key: 'userId', value: user!.id);
      Get.to(() => NavScreen());
    } else {
      Get.defaultDialog(
        title: 'Fail to login',
        middleText: json.decode(res.body)['message'],
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
    }
    isLoading = false;
    update();
  }

  void pressSignup() {
    Get.to(SignUpScreen());
  }

  void pressForgotPassword() {}

  void rememberPassword(bool value) {
    isRememberMe = value;
    update();
  }

  void obscurePassword() {
    isObscureText = !isObscureText;
    update();
  }
}
