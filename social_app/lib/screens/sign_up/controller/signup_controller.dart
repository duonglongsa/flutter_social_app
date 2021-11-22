import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class SignupController extends GetxController{
  final phoneFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassWordController = TextEditingController();


 /* String validatePassword(String value){
    if(value.isEmpty){
      return 'Please enter password!';
    } else if(value.length < 6){
      return "Password must be at least 6 characters!";
    } else {
      return null;
    }
  }

  String validateConfirmPassword(String value){
    if(confirmPassWordController.text != user.password){
      return 'Password mismatch!';
    } else {
      return null;
    }
  }

  bool validateSignup(){
    if (emailFormKey.currentState.validate()
        && passwordFormKey.currentState.validate()
        && confirmPasswordFormKey.currentState.validate()) {
      return true;
    }
    return false;
  }
*/
}