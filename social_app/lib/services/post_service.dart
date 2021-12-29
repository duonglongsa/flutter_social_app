import 'dart:convert';

import 'package:social_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/utilities/configs.dart';

//todo: chinh lai api de fetch

Future<List<Post>> getPostList(String token) async {
  var res = await http
      .get(Uri.parse(localhost + "/v1/posts/list"), headers: {
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
      .get(Uri.parse(localhost + "/v1/posts/delete/$postId"),
  headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });
  var responseJson = json.decode(res.body);
  print(responseJson["message"].toString());
}

Future<void> reportPost(String postId, String subject, String details, String token) async {
  var res = await http
      .post(Uri.parse(localhost + "/v1/postReport/create/" + postId), 
  headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  },
  body: {
        "subject": subject,
        "details": details,
  });
  var responseJson = json.decode(res.body);
  print(responseJson["data"].toString());
}

Future<void> likePost(String postId, String token) async {
  var res = await http
      .post(Uri.parse(localhost + "/v1//postLike/action/" + postId), 
  headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  },);
  var responseJson = json.decode(res.body);
  print(responseJson["data"].toString());
}



