import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:social_app/screens/create_post/views/create_post_screen.dart';
import 'package:social_app/screens/home_page/controller/home_controller.dart';
import 'package:social_app/screens/view_post_screen/post_creen.dart';
import 'package:social_app/screens/sign_in/controller/signin_controller.dart';
import 'package:social_app/screens/sign_in/views/signin_screen_widgets.dart';
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

  Future initController() async {
    await homeController.getUserInfo();
    await homeController.getList();
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
          automaticallyImplyLeading: false,
        ),*/
        backgroundColor: backGroundColor,
        //resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              backgroundColor: cointainerColor,
              title: const Text(
                'News feed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  letterSpacing: -1.2,
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  onPressed: () => print('Search'),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: createPostWidget(
                onCreatePost: () {
                  Get.to(() => const CreatePostScreen());
                },
              ),
            ),
            SliverFillRemaining(
              child: GetBuilder<HomeController>(
                init: homeController,
                builder: (_) {
                  if (homeController.postList == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return RefreshIndicator(
                      onRefresh: () => homeController.getList(),
                      backgroundColor: backGroundColor,
                      child: ListView.builder(
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
                    );
                  }
                },
              ),
            ),
            // homeController.postList != null
            //     ? SliverList(
            //         delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //             return post(
            //               userName:
            //                   homeController.postList![index].postUser!.name!,
            //               avatar: NetworkImage(
            //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlHidJs9A2sNkuM9gCih3fO49j6D8gEAZuzg&usqp=CAU"),
            //               timeAgo: homeController.postList![index].timeCreated!,
            //               caption: homeController.postList![index].described,
            //               image: Image.network(
            //                   "https://memehay.com/meme/20210924/troll-mu-cup-trong-long-nguoi-ham-mo-la-chiec-cup-quy-gia-nhat.jpg"),
            //             );
            //           },
            //           childCount: homeController.postList!.length,
            //         ),
            //       )
            //     : const SliverToBoxAdapter(
            //         child: SizedBox(
            //             width: 40,
            //             height: 40,
            //             child: CircularProgressIndicator()),
            //       )
          ],
        ),
      
      ),
    );
  }
}
