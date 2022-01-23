import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/signin_controller.dart';
import 'package:social_app/utilities/style_constants.dart';

import '../template_widget.dart';


Widget signinPhoneTF({
  required SigninController signinController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Phone number',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Form(
        child: TextFormField(
          controller: signinController.phoneController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: emailInputDecoration,
        ),
      ),
     /* Form(
        child: TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            onEditingComplete:  () {
            },
            decoration: emailInputDecoration,
          ),
          validator: (value){},
          hideOnLoading: true,
          noItemsFoundBuilder: (value){
          },
          suggestionsCallback: () {
            return ;
            //return  hintEmail.where((element) => element.startsWith(pattern) && element!='');
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              //title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
          },

        ),
      ),*/

    ],
  );
}

Widget signinPasswordTF({
  required SigninController signinController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Password',
        style: kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      GetBuilder<SigninController>(
        builder:(_) => TextFormField(
          controller: signinController.passwordController,
          obscureText: signinController.isObscureText,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
              fillColor: Colors.white24,
              filled: true,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  signinController.isObscureText? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                  color: Colors.white,
                ),
                onPressed: (){
                  signinController.obscurePassword();
                },
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              )
          ),
        ),
      ),
    ],
  );
}

Widget signinBtn({
  required SigninController signinController,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    // ignore: deprecated_member_use
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () async {
        await signinController.pressSignin();
      },
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: const Text(
        'LOGIN',
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

Widget forgotPasswordBtn({
  required SigninController signinController,
}) {
  return Container(
    alignment: Alignment.centerRight,
    // ignore: deprecated_member_use
    child: FlatButton(
      onPressed: () => signinController.pressForgotPassword(),
      padding: const EdgeInsets.only(right: 0.0),
      child: const Text(
        'Forgot Password?',
        style: kLabelStyle,
      ),
    ),
  );
}

Widget rememberMeCheckbox({
  required SigninController signinController,
}) {
  return SizedBox(
    height: 20.0,
    child: Row(
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: GetBuilder<SigninController>(
            builder: (_) => Checkbox(
              checkColor: Colors.green,
              value: signinController.isRememberMe,
              activeColor: Colors.white,
              onChanged: (value) => signinController.rememberPassword(value!),
            ),
          ),
        ),
        const Text(
          'Remember me',
          style: kLabelStyle,
        ),
      ],
    ),
  );
}

Widget headToSignupBtn({
  required SigninController signinController,
}) {
  return GestureDetector(
    child: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            //TextSpan onTap
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                signinController.pressSignup();
              },
          ),
        ],
      ),
    ),
  );
}