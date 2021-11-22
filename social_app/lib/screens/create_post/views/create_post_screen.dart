import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:social_app/screens/create_post/controllers/create_post_controller.dart';
import 'package:social_app/utilities/style_constants.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  final CreatePostController createPostController = Get.put(CreatePostController());

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
            onPressed: () => createPostController.back(),
          ),
          title: const Text(
            'Create post',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => createPostController.addPost(),
              child: const Text(
                'POST',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: backGroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: createPostController.describedController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    decoration: const InputDecoration(
                      hintText: "What is on your mind?",
                      hintStyle: kHintTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                 
                  GetBuilder(
                    init: createPostController,
                    builder: (_) => createPostController.imagePath != ''? 
                    Image.file(File(createPostController.imagePath)) 
                    :const SizedBox()
                    ,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: cointainerColor,
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton.icon(
                onPressed: ()  => createPostController.pickImage(),
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
                color: Colors.white10,
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
      ),
    );
  }
}
