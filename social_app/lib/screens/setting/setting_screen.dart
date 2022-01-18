import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/setting/setting_controller.dart';
import 'package:social_app/screens/setting/edit_profile_screen.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    settingController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cointainerColor,
          title: const Text(
            'Option',
          ),
          centerTitle: false,
        ),
        body: Center(
          child: GetBuilder(
              init: settingController,
              builder: (_) {
                if (settingController.user == null) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "$networkFile${settingController.user!.avatar!.fileName}"),
                      radius: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(settingController.user!.name!,
                        style: const TextStyle(fontSize: 30, color: Colors.white)),
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
                      onPressed: () {
                        Get.to(() => EditProfileScreen(user: settingController.user!,))!.then((_) {
                          settingController.getUserInfo();
                        });
                      },
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
                );
              }),
        ));
  }
}
