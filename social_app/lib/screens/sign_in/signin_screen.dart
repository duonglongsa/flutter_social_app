import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:social_app/controllers/signin_controller.dart';
import 'package:social_app/screens/sign_in/signin_screen_widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:social_app/utilities/style_constants.dart';



class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninController signinController = Get.put(SigninController());


  @override
  Widget build(BuildContext context) {
    signinController.context = context;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/signin_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: GetBuilder(
            init: signinController,
            builder: (_) {
              return LoadingOverlay(
                color: backGroundColor,
                opacity: 0.7,
                isLoading: signinController.isLoading,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                signinPhoneTF(signinController: signinController),
                                const SizedBox(height: 30.0,),
                                signinPasswordTF(signinController: signinController),
                                forgotPasswordBtn(signinController: signinController),
                                rememberMeCheckbox(signinController: signinController),
                                signinBtn(signinController: signinController),
                                headToSignupBtn(signinController: signinController),
                              ],
                            )),
                          ),
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
