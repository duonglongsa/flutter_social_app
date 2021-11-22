import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/create_post/controllers/create_post_controller.dart';
import 'package:social_app/screens/template_widget.dart';
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
          backgroundColor: cointainerColor,
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
        body: SingleChildScrollView(
          child: Container(
            color: backGroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  post(
                    context: context,
                    post: widget.post,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
