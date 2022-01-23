// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/profile/user_profile_controller.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/controllers/home/home_controller.dart';
import 'package:social_app/screens/user_profile/user_profile_screen.dart';
import 'package:social_app/services/friend_service.dart';
import 'package:social_app/services/post_service.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'create_post/create_post_screen.dart';

Widget createPostWidget({required String userAvatar, required VoidCallback getPostList}) {
  return Card(
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: cointainerColor,
      child: InkWell(
        onTap: () {
          Get.to(() => const CreatePostScreen())!.then((value) {
            getPostList;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('$networkFile$userAvatar'),
                  backgroundColor: Colors.blueAccent,
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              height: 10.0,
              thickness: 0.5,
              color: Colors.white70,
            ),
            SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: const Text(
                      'Photo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 8.0,
                    color: Colors.white70,
                  ),
                  FlatButton.icon(
                    onPressed: () => print('Video'),
                    icon: const Icon(
                      Icons.video_library,
                      color: Colors.purpleAccent,
                    ),
                    label: const Text(
                      'Video',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget post(
    {required BuildContext context,
    required Post post,
    required Color postColor}) {
  return Card(
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: postColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => UserProfileScreen(userId: post.postUser!.id!));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "$networkFile${post.postUser!.avatar!.fileName}"),
                        backgroundColor: Colors.grey,
                        radius: 18,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.postUser!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  timeago.format(post.timeCreated!),
                                  style: kHintTextStyle,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.public,
                                  color: Colors.white70,
                                  size: 12.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white70,
                        ),
                        onPressed: () async {
                          String? currentUserId =
                              await const FlutterSecureStorage()
                                  .read(key: 'userId');

                          if (currentUserId == post.postUser!.id) {
                            return _showPostOption(context, post.postID!);
                          } else {
                            return _showOthersPostOption(context, post.postID!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  post.described!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (post.image != null && post.image!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ImageGridTemplate(
                        listImagePath: post.image!
                            .map((e) => "$networkFile${e.fileName}")
                            .toList()),
                  ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    String? token =
                        await const FlutterSecureStorage().read(key: "token");
                    List<User> likedUsers = [];
                    for (String userId in post.likedUserId!) {
                      likedUsers
                          .add(await FriendService.getUserInfo(token!, userId));
                    }
                    _showLikeList(context, likedUsers);
                  },
                  child: Row(
                    children: [
                      if (post.countLikes! > 0)
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.thumb_up,
                            size: 10.0,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          post.countLikes! > 0
                              ? '${post.countLikes} Likes'
                              : '',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (post.countComments! > 0)
                        Text(
                          '${post.countComments} Comments',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(width: 8.0),
                    ],
                  ),
                ),
                const Divider(
                  height: 10.0,
                  thickness: 0.5,
                  color: Colors.white70,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            String? token = await const FlutterSecureStorage()
                                .read(key: 'token');
                            PostService.likePost(post.postID!, token!);
                            post.isLike = true;
                            post.countLikes = post.countLikes! + 1;
                            (context as Element).markNeedsBuild();
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            height: 25.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: post.isLike
                                      ? Colors.blue
                                      : Colors.white70,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  'Like',
                                  style: TextStyle(
                                      color: post.isLike
                                          ? Colors.blue
                                          : Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: SizedBox(
                            height: 25.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.mode_comment_outlined,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  'Comment',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.grey[200],
  ));
}

class ImageGridTemplate extends StatelessWidget {
  final List<String> listImagePath;
  Map<String, double> aspectRaito = {};
  int numberOfVerticalImage = 0;
  //BuildContext context;

  ImageGridTemplate({Key? key, required this.listImagePath}) : super(key: key);

  Future<double> _calculateNetWorkImage(String link) {
    Completer<double> completer = Completer();
    Image image = Image.network(link);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          double aspectRaito =
              myImage.width.toDouble() / myImage.height.toDouble();
          completer.complete(aspectRaito);
        },
      ),
    );
    return completer.future;
  }

  Future calculateAspectRaito() async {
    for (int i = 0; i < listImagePath.length; i++) {
      aspectRaito[listImagePath[i]] =
          await _calculateNetWorkImage(listImagePath[i]);

      if (aspectRaito[listImagePath[i]]! < 4 / 3) {
        numberOfVerticalImage++;
      }
    }
    listImagePath.sort((a, b) {
      return aspectRaito["$a"]!.compareTo(aspectRaito["$b"]!);
    });
    //(context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: calculateAspectRaito(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        // if(!snapshot.hasData){
        //   return Container();
        // }
        switch (listImagePath.length) {
          case 1:
            return StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  if (aspectRaito['${listImagePath[0]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount:
                            4 / aspectRaito['${listImagePath[0]}']!,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[0]}']!,
                            aspectRaito: aspectRaito['${listImagePath[0]}']!,
                            imageFile: listImagePath[0]))
                ]);
          case 2:
            return StaggeredGrid.count(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  if (aspectRaito['${listImagePath[0]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 4,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[0]}']!,
                            aspectRaito: 3 / 4,
                            imageFile: listImagePath[0])),
                  if (aspectRaito['${listImagePath[1]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 4,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[1]}']!,
                            aspectRaito: 3 / 4,
                            imageFile: listImagePath[1])),
                ]);

          case 3:
            if (numberOfVerticalImage == 3) {
              return StaggeredGrid.count(
                  crossAxisCount: 9,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    if (aspectRaito['${listImagePath[0]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 4,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[0]}']!,
                              aspectRaito: 3 / 4,
                              imageFile: listImagePath[0])),
                    if (aspectRaito['${listImagePath[1]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 4,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[1]}']!,
                              aspectRaito: 3 / 4,
                              imageFile: listImagePath[1])),
                    if (aspectRaito['${listImagePath[2]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 4,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[2]}']!,
                              aspectRaito: 3 / 4,
                              imageFile: listImagePath[2])),
                  ]);
            } else {
              return StaggeredGrid.count(
                  crossAxisCount: 6,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    if (aspectRaito['${listImagePath[0]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 4,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[0]}']!,
                              aspectRaito: 3 / 4,
                              imageFile: listImagePath[0])),
                    if (aspectRaito['${listImagePath[1]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 4,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[1]}']!,
                              aspectRaito: 3 / 4,
                              imageFile: listImagePath[1])),
                    if (aspectRaito['${listImagePath[2]}'] != null)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 6,
                          mainAxisCellCount: 4.5,
                          child: _singleImage(
                              imageAspectRaito:
                                  aspectRaito['${listImagePath[2]}']!,
                              aspectRaito: 4 / 3,
                              imageFile: listImagePath[2])),
                  ]);
            }
          case 4:
            return StaggeredGrid.count(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  if (aspectRaito['${listImagePath[0]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 3,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[0]}']!,
                            aspectRaito: 3 / 3,
                            imageFile: listImagePath[0])),
                  if (aspectRaito['${listImagePath[1]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 3,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[1]}']!,
                            aspectRaito: 3 / 3,
                            imageFile: listImagePath[1])),
                  if (aspectRaito['${listImagePath[2]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 3,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[2]}']!,
                            aspectRaito: 3 / 3,
                            imageFile: listImagePath[2])),
                  if (aspectRaito['${listImagePath[3]}'] != null)
                    StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 3,
                        child: _singleImage(
                            imageAspectRaito:
                                aspectRaito['${listImagePath[3]}']!,
                            aspectRaito: 3 / 3,
                            imageFile: listImagePath[3])),
                ]);

          default:
            return Container();
        }
      },
    );
  }

  Widget _singleImage(
      {required double imageAspectRaito,
      required double aspectRaito,
      required String imageFile}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailScreen(imageLink: imageFile));
      },
      child: Hero(
        tag: imageFile,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: imageAspectRaito < aspectRaito
                  ? BoxFit.fitWidth
                  : BoxFit.fitHeight,
              alignment: FractionalOffset.center,
              image: NetworkImage(
                imageFile,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imageLink;

  const DetailScreen({Key? key, required this.imageLink}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          child: Stack(
            children: [
              Container(
                color: backGroundColor,
                child: Center(
                  child: Hero(
                    tag: imageLink,
                    child: Image.network(
                      imageLink,
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    shape: const CircleBorder(),
                    color: Colors.black12,
                  )),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

Widget commentWidget({
  required BuildContext context,
  required User user,
  required CommentModel comment,
  VoidCallback? onLikeTap,
  VoidCallback? onReplyTap,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage("$networkFile${user.avatar!.fileName}"),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: cointainerColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      comment.content,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white60, fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        timeago.format(comment.timeCreated),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      InkWell(
                        onTap: onLikeTap,
                        child: const Text('Like'),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      InkWell(
                        onTap: onReplyTap,
                        child: const Text('Reply'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

void _showOthersPostOption(BuildContext context, String postId) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: backGroundColor,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.report,
                  color: Colors.white,
                ),
                title: const Text(
                  "Report",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.back();
                  _showRepostForm(context, postId);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showLikeList(BuildContext context, List<User> likedUsers) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: backGroundColor,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Users liked this post:',
                  style: kLabelStyle,
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: likedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              '$networkFile${likedUsers[index].avatar!.fileName}'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          likedUsers[index].name!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ]),
                    );
                  }),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      );
    },
  );
}

void _showRepostForm(BuildContext context, String postId) {
  TextEditingController subjectTextController = TextEditingController();
  TextEditingController detailsTextController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: backGroundColor,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Text(
                    "Subject",
                    style: TextStyle(color: Colors.white),
                  ),
                  title: TextFormField(
                    controller: subjectTextController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "Details",
                    style: TextStyle(color: Colors.white),
                  ),
                  title: TextFormField(
                    controller: detailsTextController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(closeOverlays: true);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        String? token =
                            await const FlutterSecureStorage().read(key: 'token');
                        PostService.reportPost(
                          postId,
                          subjectTextController.text,
                          detailsTextController.text,
                          token!,
                        );
                        Get.back();
                        showMessage("Report successful", context);
                      },
                      child: const Text(
                        "Report",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void _showPostOption(BuildContext context, String postId) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: backGroundColor,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                title: const Text(
                  "Edit post",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                title: const Text(
                  "Delete post",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => _selectedDeletePost(postId),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _selectedDeletePost(String postId) async {
  String? token = await const FlutterSecureStorage().read(key: 'token');

  await PostService.deletePost(postId, token!);
  final homeController = Get.find<HomeController>();
  Get.back();
  homeController.removePostFromList(postId);
}
