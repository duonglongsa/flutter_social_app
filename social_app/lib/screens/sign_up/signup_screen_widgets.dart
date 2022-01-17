import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/controllers/signup_controller.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/utilities/style_constants.dart';

Widget signupNameTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Name',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          controller: signupController.nameController,
          onChanged: (value) {},
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: nameInputDecoration,
        ),
      ),
    ],
  );
}

Widget signupPhoneTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Phone',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          controller: signupController.phoneController,
          onChanged: (value) {},
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: emailInputDecoration,
        ),
      ),
    ],
  );
}

Widget signupPasswordTF(SignupController signupController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Password',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          controller: signupController.passwordController,
          obscureText: true,
          onChanged: (value) {},
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: passwordInputDecoration,
        ),
      ),
    ],
  );
}

Widget confirmPasswordTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Confirm Password',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          obscureText: true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: passwordInputDecoration,
        ),
      ),
    ],
  );
}

Widget registerBtn(SignupController signupController) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    // ignore: deprecated_member_use
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () async {
        final res = await AuthService.register(User(
            signupController.nameController.text,
            signupController.phoneController.text,
            signupController.passwordController.text));
            print("123213");
        if (res.statusCode == 201) {
          Get.defaultDialog(
              title: 'Successful register',
              middleText: 'Back to login page?',
              textConfirm: 'OK',
              onConfirm: () {
                Get.back();
              },
              textCancel: 'Cancel',
              onCancel: () {

              }
          );
        } else {
          Get.defaultDialog(
              title: 'Error',
              middleText: json.decode(res.body)["message"],
              textConfirm: 'OK',
              onConfirm: () {
                Get.back();
              },
              textCancel: 'Cancel',
              onCancel: () {

              }
          );
        }
      },
      
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: const Text(
        'REGISTER',
        style: TextStyle(
          color: Color(0xFF527DAA),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

Widget backToLoginBtn() {
  return GestureDetector(
    child: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Have an Account? ',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            //TextSpan onTap
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.back();
              },
          ),
        ],
      ),
    ),
  );
}
