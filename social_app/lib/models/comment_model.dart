import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';

class CommentModel {
  Post? post;
  User? user;
  late String content;
  //List<CommentModel> commentAnswered;
  late String timeCreated;

  CommentModel(this.content);
}
