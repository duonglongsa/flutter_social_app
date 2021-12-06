import 'dart:convert';
import 'dart:io';

import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_app/utilities/configs.dart';

Future<String> createComment(Post post, String token, CommentModel comment) async {
 
  var res = await http.post(Uri.parse(localhost + "/v1/postComment/create/${post.postID}"),
      headers: {
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        //'Content-Type': 'application/json',
      },
      body: {
        "content": comment.content,
        "commentAnswered": "",
      });

  print(res.body);
  return res.statusCode.toString();
}
