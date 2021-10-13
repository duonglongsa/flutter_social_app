import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:social_app/utilities/style_constants.dart';

Widget signupEmailTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Email',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          onChanged: (value) {

          },
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

Widget signupPasswordTF() {
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
          obscureText: true,
          onChanged: (value) {
          },

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

Widget registerBtn() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    // ignore: deprecated_member_use
    child: RaisedButton(
      elevation: 5.0,
     onPressed: (){

     },
     /* onPressed: () async {
        if (signupController.validateSignup()) {
          bool isRegisted = await firebaseRegister(signupController);
          if(isRegisted) {
            Get.defaultDialog(
                title: 'Successful register',
                middleText: 'Back to login page?',
                textConfirm: 'OK',
                onConfirm: (){
                  Get.back();
                },
                textCancel: 'Cancel',
                onCancel: (){
                }
            );
          } else {
            Get.defaultDialog(
              title: 'Fail to register',
              middleText: 'Email was used!',
              textConfirm: 'OK',
              onConfirm: () {
                Get.back();
              },
            );
          }
        }
      },*/
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