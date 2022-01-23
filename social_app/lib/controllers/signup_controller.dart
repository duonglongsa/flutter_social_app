import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassWordController =
      TextEditingController();

  bool isLoading = false;

  void showLoading() {
    print(isLoading);
    isLoading = !isLoading;
    update();
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password!';
    } else if (value.length < 6) {
      return "Password must be at least 6 characters!";
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter comfirm password!';
    }
    if (confirmPassWordController.text != passwordController.text) {
      return 'Password mismatch!';
    } else {
      return null;
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name!';
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number!';
    } else if (value.length < 10) {
      return "Phone number must has a least 10 characters!";
    } else {
      return null;
    }
  }

  bool validateSignup() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
