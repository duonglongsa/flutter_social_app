import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/home_page/controller/home_controller.dart';
import 'package:social_app/services/post_service.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;


Widget createPostWidget({
  required VoidCallback onCreatePost,
}) {
  return Card(
    child: Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: cointainerColor,
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blueAccent,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration.collapsed(
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
          Container(
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
                const VerticalDivider(
                  width: 8.0,
                  color: Colors.white70,
                ),
                FlatButton.icon(
                  onPressed: () async {
                    onCreatePost();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.purpleAccent,
                  ),
                  label: const Text(
                    'Post',
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
  );
}

Widget post({
  required BuildContext context,
  required Post post,
}) {
  return Card(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: cointainerColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      //backgroundImage: avatar,
                      backgroundColor: Colors.greenAccent,
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
                        onPressed: () => _showPostOption(context, post.postID!),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  post.described!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(
                    "https://memehay.com/meme/20210924/troll-mu-cup-trong-long-nguoi-ham-mo-la-chiec-cup-quy-gia-nhat.jpg"),
                ),
                const SizedBox(
                  height: 5,
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
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            height: 25.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  'Like',
                                  style: TextStyle(color: Colors.white70),
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
                          child: Container(
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
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            height: 25.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.share,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  'Share',
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
  print(postId);
  String? token = await const FlutterSecureStorage().read(key: 'token');
  
  await deletePost(postId, token!);
  
  final homeController = Get.find<HomeController>();
  print("before" + homeController.postList!.length.toString());
  homeController.removePostFromList(postId);
  print("after" + homeController.postList!.length.toString());
}
