import 'dart:convert';
import 'dart:io';

import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_app/utilities/configs.dart';


Future<List<Post>> getPostList(String userId, String token) async {
  var res = await http
      .get(Uri.parse(localhost + "/v1/posts/list?userId=" + userId), headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });
  var responseJson = json.decode(res.body);
  print(responseJson["data"].toString());
  return (responseJson["data"] as List).map((p) => Post.fromJson(p)).toList();
}

Future<String> createPost(Post post, String token) async {
  print("image:" + post.image!);
  print("Caption:" + post.described!);

  // List<int> imageBytes = File(post.image!).readAsBytesSync();
  // String base64Image = base64Encode(imageBytes);
  // print(base64Image);

  // List<String> images = [base64Image] ;

  var res = await http.post(Uri.parse(localhost + "/v1/posts/create?userId=" + post.userId!),
      headers: {
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        //'Content-Type': 'application/json',
      },
      body: {
        "described": post.described,
        "images": "",
        "videos": "",
        "countComments": '0',
      });

  return res.statusCode.toString();
}


Future<void> deletePost(String postId, String token) async {
  var res = await http
      .get(Uri.parse(localhost + "/v1/posts/delete/$postId"), headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });
  var responseJson = json.decode(res.body);
  print(responseJson["message"].toString());
}


