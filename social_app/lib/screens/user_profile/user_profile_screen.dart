import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/home/home_controller.dart';
import 'package:social_app/controllers/profile/user_profile_controller.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/utilities/configs.dart';
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
                          FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(
                                  "$networkFile${userProfileController.user!.coverImage!.fileName}")),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "$networkFile${userProfileController.user!.avatar!.fileName}"),
                          ),
                        ),
                      ))
                    ]),
                    Text(userProfileController.user!.name!,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white)),
                    const SizedBox(height: 20, width: 0),
                    if (userProfileController.user!.type! == 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  userProfileController.blockUser();
                                },
                                label: const Text(
                                  'Message',
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: const Icon(Icons.message,
                                    color: Colors.white),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[700])),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text(
                                'Unfriend',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.person_off,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[700])),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                userProfileController.blockUser();
                              },
                              label: const Text(
                                'Block',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.block,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[700])),
                            ),
                          ],
                        ),
                      ),
                    if (userProfileController.user!.type! == 2)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  userProfileController.blockUser();
                                },
                                label: const Text(
                                  'Send friend request',
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: const Icon(
                                  Icons.person_add_alt,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[700])),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              label: const Text(
                                'Block',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.block,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[700])),
                            ),
                          ],
                        ),
                      ),
                    if (userProfileController.user!.type! == 0) Row(),
                    const SizedBox(height: 20, width: 0),
                    if (userProfileController.user!.type! == 0)
                      createPostWidget(
                          userAvatar:
                              userProfileController.user!.avatar!.fileName!),
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
