import 'dart:convert';

import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';

class CommentModel {
  late String postId;
  User? user;
  late String content;
  //List<CommentModel> commentAnswered;
  late DateTime timeCreated;
  late DateTime timeUpdated;

  late String commentAnsweredId;


  CommentModel(this.content, this.commentAnsweredId);

  
  CommentModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        timeCreated = DateTime.parse(json["createdAt"]),
        timeUpdated = DateTime.parse(json["updatedAt"]),
        user = User.fromPostJson(json["user"]),
        postId = json["post"],
        commentAnsweredId = json["commentAnswered"]??"";
}
