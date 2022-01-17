import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:social_app/screens/setting/edit_profile_screen.dart';
import 'package:social_app/utilities/style_constants.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cointainerColor,
          title: const Text(
            'News feed',
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            SizedBox(
              width: 450,
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("lib/assets/avatar.jpg"),
              radius: 80,
            ),
            SizedBox(
              width: 450,
              height: 20,
            ),
            Text("Girl", style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(
              width: 450,
              height: 60,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: cointainerColor,
                padding: const EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: () {},
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: const [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text('View profile'),
                  ])),
            ),
            const SizedBox(
              width: 0,
              height: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: cointainerColor,
                padding: const EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: () {Get.to(() => EditProfileScreen());},
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: const [
                    Icon(Icons.edit),
                    SizedBox(width: 10),
                    Text('Edit profile'),
                  ])),
            ),
            const SizedBox(
              width: 0,
              height: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: cointainerColor,
                padding: const EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: () {},
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: const [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Sign out'),
                  ])),
            ),
          ],
        ));
  }
}
