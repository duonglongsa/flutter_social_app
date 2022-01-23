import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:social_app/controllers/signup_controller.dart';
import 'package:social_app/utilities/style_constants.dart';

import 'signup_screen_widgets.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/signup_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GetBuilder(
            init: signupController,
            builder: (_) {
              return LoadingOverlay(
                isLoading: signupController.isLoading,
                color: backGroundColor,
                opacity: 0.7,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SizedBox(
                          height: double.infinity,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 120.0,
                            ),
                            child: Form(
                              key: signupController.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  signupNameTF(signupController),
                                  const SizedBox(height: 20.0,),
                                  signupPhoneTF(signupController),
                                  const SizedBox(height: 20.0,),
                                  signupPasswordTF(signupController),
                                  const SizedBox(height: 20.0,),
                                  confirmPasswordTF(signupController),
                                  const SizedBox(height: 30.0,),
                                  registerBtn(signupController),
                                  backToLoginBtn(),
                                ],
                              ),
                            ),
                          ),
                        )
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}