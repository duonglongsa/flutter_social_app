import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/home/home_controller.dart';
import 'package:social_app/controllers/profile/user_profile_controller.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/utilities/style_constants.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final userProfileController = Get.put(UserProfleController());

  @override
  void initState() {
    super.initState();
    initController();
  }

  
  Future initController() async {
    await userProfileController.getUserInfo();
    userProfileController.getProfileUser(widget.userId);
    userProfileController.getProfilePost(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: cointainerColor,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<UserProfleController>(
            init: userProfileController,
            builder: (context) {
              if (userProfileController.user != null) {
                return Column(
                  children: <Widget>[
                    Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEDTZ1LJSMVWVqW5yiGusDNMMdTI7B4lvQjw&usqp=CAU"))),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: backGroundColor,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage:
                                AssetImage("lib/assets/avatar.jpg"),
                          ),
                        ),
                      ))
                    ]),
                    const SizedBox(
                      width: 450,
                      height: 20,
                    ),
                    Text(userProfileController.user!.name!,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white)),
                    const SizedBox(height: 20, width: 0),
                    createPostWidget(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userProfileController.postList.length,
                      itemBuilder: (context, index) {
                        return post(
                          postColor: cointainerColor,
                          context: context,
                          post: userProfileController.postList[index],
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
