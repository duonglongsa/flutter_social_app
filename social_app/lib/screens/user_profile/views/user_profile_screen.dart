import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/create_post/views/create_post_screen.dart';
import 'package:social_app/screens/home_page/controller/home_controller.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/screens/view_post_screen/post_creen.dart';
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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
          ],
        ),
        backgroundColor: cointainerColor,

      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        child: Image.network("https://elead.com.vn/wp-content/uploads/2020/04/13624171783_9f287bafdb_o.jpg")
                    ),
                    const SizedBox(height: 60,)
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 130,
                    child: CircleAvatar(
                        radius: 80,
                        backgroundColor: backGroundColor,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage("lib/assets/avatar.jpg"),
                        ),
                    )
                )
              ]
            ),
            SizedBox(width: 450, height: 20,),
            Text("Girl", style: TextStyle(fontSize: 30, color: Colors.white)),
            SizedBox(height: 20,width: 0),
            createPostWidget(onCreatePost: ()=>{}),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {},
                  child: post(
                    postColor: cointainerColor,
                    context: context,
                    post: Post.test(User("ducanh","329480","fejl"),"jdkf","","", DateTime.parse("2021-11-08T03:18:05.654Z")),
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