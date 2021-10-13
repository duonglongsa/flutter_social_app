import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_app/view/sign_up/views/signup_screen.dart';


class SigninController extends GetxController{

  bool isRememberMe = false;

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscureText = true;

  void pressSignup(){
    Get.to(SignUpScreen());
  }

  void pressForgotPassword(){

  }

  void rememberPassword(bool value){
    isRememberMe = value;
    update();
  }

  void obscurePassword(){
    isObscureText = !isObscureText;
    update();
  }


}