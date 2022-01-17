import 'package:flutter/cupertino.dart';
import 'package:social_app/models/image.dart';
import 'package:social_app/models/user.dart';

class Post {
  String? postID;
  String? described;
  String? userId;
  DateTime? timeCreated;

  List<ImageModel>? image;
  String? video;

  List<dynamic>? likedUserId;

  int? countLikes;
  int? countComments;
  int? countShares;

  bool isLike = false;

  User? postUser;

  Post(this.userId, this.described, this.image, this.video);
  Post.test(this.postUser, this.described, this.image, this.video, this.timeCreated);

  Post.fromJson(Map<String, dynamic> json)
      : countComments = json["countComments"],
        postID = json["_id"],
        described = json["described"],
        timeCreated = DateTime.parse(json["createdAt"]),
        postUser = User.fromPostJson(json["author"]),
        countLikes = (json["like"] as List).length,
        likedUserId = json["like"],
        isLike = json["isLike"],
        image = (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList();

}
