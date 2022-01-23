import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:social_app/screens/create_post/create_post_screen.dart';
import 'package:social_app/controllers/home/home_controller.dart';
import 'package:social_app/screens/view_post_screen/post_creen.dart';
import 'package:social_app/controllers/signin_controller.dart';
import 'package:social_app/screens/sign_in/signin_screen_widgets.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/services/post_service.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  HomeController homeController = Get.put(HomeController());
  bool _showBackToTopButton = false;

  ScrollController? _scrollController;

  Future initController() async {
    await homeController.getUserInfo();
    await homeController.getList();
  }

  @override
  void initState() {
    super.initState();
    initController();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController!.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    homeController.context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cointainerColor,
          title: const Text(
            'News feed',
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: () => print('Search'),
            ),
          ],
        ), //resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          onRefresh: () => homeController.getList(),
          backgroundColor: backGroundColor,
          child: SingleChildScrollView(
            //controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<HomeController>(
                init: homeController,
                builder: (_) {
                  if (homeController.postList == null &&
                      homeController.currentUser == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Column(
                      children: [
                        createPostWidget(
                            userAvatar:
                                homeController.currentUser!.avatar!.fileName!,
                            isInProfile: false),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homeController.postList!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.to(() => PostScreen(
                                    post: homeController.postList![index],
                                  )),
                              child: post(
                                postColor: cointainerColor,
                                context: context,
                                post: homeController.postList![index],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
        floatingActionButton: _showBackToTopButton == false
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _scrollController!.animateTo(0,
                      duration: Duration(seconds: 1), curve: Curves.linear);
                },
                child: Icon(Icons.arrow_upward),
              ),
      ),
    );
  }
}
