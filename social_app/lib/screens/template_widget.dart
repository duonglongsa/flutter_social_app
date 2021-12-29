import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/controllers/home/home_controller.dart';
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
      child: InkWell(
        onTap: (){onCreatePost();},
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                ),
                SizedBox(width: 8.0),
                Expanded(
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
                      onPressed: () async {
                        String? currentUserId = await FlutterSecureStorage().read(key: 'userId');
                        
                        if(currentUserId == post.postUser!.id){
                          return _showPostOption(context, post.postID!);
                        } else {
                          return _showOthersPostOption(context, post.postID!);
                        }
                        
                      },
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
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
                        '${post.countLikes} Likes',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Text(
                      '${post.countComments} Comments',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Shares',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
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
                            String? token = await FlutterSecureStorage().read(key: 'token');
                            likePost(post.postID!, token!);
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
                                  color: post.isLike ? Colors.blue:Colors.white70,
                                ),
                                const SizedBox(width: 4.0),
                                const Text(
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
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
          //backgroundImage: NetworkImage(rootComment.avatarUrl),
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

void _showOthersPostOption(BuildContext context, String postId){
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
                onTap: () => _showRepostForm(context, postId),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showRepostForm(BuildContext context, String postId){
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
                      onPressed: (){}, 
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        String? token = await FlutterSecureStorage().read(key: 'token');
                        print(token);
                        reportPost(
                          postId,
                          subjectTextController.text,
                          detailsTextController.text, 
                          token!,
                        );
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
  print(postId);
  String? token = await const FlutterSecureStorage().read(key: 'token');

  await deletePost(postId, token!);

  final homeController = Get.find<HomeController>();
  print("before" + homeController.postList!.length.toString());
  homeController.removePostFromList(postId);
  print("after" + homeController.postList!.length.toString());
}
