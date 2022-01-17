import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/controllers/post/create_post_controller.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final CreatePostController createPostController =
      Get.put(CreatePostController());

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
        body: Stack(
          children: [
            Container(
              color: backGroundColor,
            ),
            SingleChildScrollView(
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
                      builder: (_) => createPostController.imagePath != []
                          // ? ListView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemCount: createPostController.imagePath.length,
                          //     itemBuilder: (context, index) {
                          //       decodeImageFromList(createPostController.imagePath[index].readAsBytesSync())
                          //       .then((value) => print("${value.height} ${value.as}"));
                          //       //print(cr);
                          //       Image image = Image.file(
                          //           createPostController.imagePath[index],);
                          //       return image;
                          //     },
                          //   )
                          ? ImageGridView(
                              listImagePath: createPostController.imagePath)
                          : Container(
                              color: backGroundColor,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: cointainerColor,
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton.icon(
                onPressed: () => createPostController.pickImage(context),
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

class ImageGridView extends StatelessWidget {
  final List<File> listImagePath;
  Map<String, double>? aspectRaito;
  int numberOfVerticalImage = 0;

  ImageGridView({Key? key, required this.listImagePath}) : super(key: key);

  Future calculateAspectRaito() async {
    for (int i = 0; i < listImagePath.length; i++) {
      final decodeImage =
          await decodeImageFromList(listImagePath[i].readAsBytesSync());
      aspectRaito!['${listImagePath[i]}'] =
          decodeImage.width / decodeImage.height;

      if (aspectRaito!['${listImagePath[i]}']! < 4 / 3) {
        numberOfVerticalImage++;
      }
    }
    listImagePath.sort((a, b) {
      return aspectRaito!["$a"]!.compareTo(aspectRaito!["$b"]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: calculateAspectRaito(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (listImagePath.length) {
          // case 1:
          //   return Image.file(
          //     listImagePath[0],
          //   );
          // case 2:
          //   return StaggeredGrid.count(
          //       crossAxisCount: 6,
          //       mainAxisSpacing: 4,
          //       crossAxisSpacing: 4,
          //       children: [
          //         StaggeredGridTile.count(
          //           crossAxisCellCount: 3,
          //           mainAxisCellCount: 4,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 fit: aspectRaito![0] < 3 / 4
          //                     ? BoxFit.fitWidth
          //                     : BoxFit.fitHeight,
          //                 alignment: FractionalOffset.center,
          //                 image: FileImage(
          //                   listImagePath[0],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         StaggeredGridTile.count(
          //           crossAxisCellCount: 3,
          //           mainAxisCellCount: 4,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 fit: aspectRaito![1] < 3 / 4
          //                     ? BoxFit.fitWidth
          //                     : BoxFit.fitHeight,
          //                 alignment: FractionalOffset.center,
          //                 image: FileImage(
          //                   listImagePath[1],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ]);

          // case 3:
          //   if (numberOfVerticalImage == 3) {
          //     return StaggeredGrid.count(
          //         crossAxisCount: 9,
          //         mainAxisSpacing: 4,
          //         crossAxisSpacing: 4,
          //         children: [
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 3,
          //             mainAxisCellCount: 4,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![0] < 3 / 4
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[0],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 3,
          //             mainAxisCellCount: 4,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![1] < 3 / 4
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[1],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 3,
          //             mainAxisCellCount: 4,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![1] < 3 / 4
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[2],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ]);
          //   } else {
          //     return StaggeredGrid.count(
          //         crossAxisCount: 6,
          //         mainAxisSpacing: 4,
          //         crossAxisSpacing: 4,
          //         children: [
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 3,
          //             mainAxisCellCount: 4,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![0] < 3 / 4
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[0],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 3,
          //             mainAxisCellCount: 4,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![1] < 3 / 4
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[1],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           StaggeredGridTile.count(
          //             crossAxisCellCount: 6,
          //             mainAxisCellCount: 4.5,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: aspectRaito![2] < 4 / 3
          //                       ? BoxFit.fitWidth
          //                       : BoxFit.fitHeight,
          //                   alignment: FractionalOffset.center,
          //                   image: FileImage(
          //                     listImagePath[2],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ]);
          //   }
          default:
            return Container();
        }
      },
    );
  }
}
