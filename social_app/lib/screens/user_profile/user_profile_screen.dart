import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/home/home_controller.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/utilities/style_constants.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  HomeController homeController = Get.put(HomeController());

  Future initController() async {
    await homeController.getUserInfo();
    await homeController.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
          ],
        ),
        backgroundColor: cointainerColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4kjqcZjBqB8k-xyIBDJr-WeTrVi5rbpUqiw&usqp=CAU"))),
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
                    backgroundImage: AssetImage("lib/assets/avatar.jpg"),
                  ),
                ),
              ))
            ]),
            const SizedBox(
              width: 450,
              height: 20,
            ),
            const Text("Girl",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 20, width: 0),
            createPostWidget(onCreatePost: () => {}),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {},
                  child: post(
                    postColor: cointainerColor,
                    context: context,
                    post: Post.test(User("ducanh", "329480", "fejl"), "jdkf",
                        "", "", DateTime.parse("2021-11-08T03:18:05.654Z")),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
