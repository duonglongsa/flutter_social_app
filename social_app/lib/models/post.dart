import 'package:social_app/models/user.dart';

class Post {
  String? postID;
  String? described;
  String? userId;
  DateTime? timeCreated;

  String? image;
  String? video;

  int? likeCounter;
  int? countComments;
  int? shareCounter;

  User? postUser;

  Post(this.userId, this.described, this.image, this.video);
  Post.test(this.postUser, this.described, this.image, this.video, this.timeCreated);

  Post.fromJson(Map<String, dynamic> json)
      : countComments = json["countComments"],
        postID = json["_id"],
        described = json["described"],
        timeCreated = DateTime.parse(json["createdAt"]),
        postUser = User.fromPostJson(json["author"]);

}
