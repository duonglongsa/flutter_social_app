import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/create_post/controllers/create_post_controller.dart';
import 'package:social_app/screens/template_widget.dart';
import 'package:social_app/services/comment_service.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends StatefulWidget {
  final Post post;

  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Post',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Container(
            color: backGroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  post(
                    postColor: backGroundColor,
                    context: context,
                    post: widget.post,
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: commentWidget(
                            context: context,
                          ),
                        );
                      },
                    ),
                  ),                
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: backGroundColor,
          child:  Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      //controller: commentController.commentTextController,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 7),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
  
                  IconButton(
                    color: Colors.black54,
                    onPressed: () async {
                      String? token = await const FlutterSecureStorage().read(key: 'token');
                      createComment(widget.post, token!, CommentModel("abc"));
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
