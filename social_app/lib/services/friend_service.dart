import 'dart:convert';

import 'package:social_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/utilities/configs.dart';

Future<List<User>> getRequestFriendList(String token) async {
  var res = await http
      .post(Uri.parse(localhost + "/v1/friends/get-requested-friend/"), headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });
  var responseJson = json.decode(res.body);
  return (responseJson["data"]["friends"] as List).map((p) => User.fromFriendRequestJson(p)).toList();
}


Future<void> acceptFriendRequest(String token, String userId, bool isAccept) async {
  var res = await http
      .post(Uri.parse(localhost + "/v1/friends/set-accept/"), 
    headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    },
    body: {
      'user_id': userId,
      'is_accept': isAccept ? '1' : '2'
    }
  );
}

Future<List<User>> getFriendList(String token) async {
  var res = await http
      .post(Uri.parse(localhost + "/v1/friends/list"), headers: {
    'Context-Type': 'application/json;charSet=UTF-8',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });
  var responseJson = json.decode(res.body);
  return (responseJson["data"]["friends"] as List).map((p) => User.fromFriendRequestJson(p)).toList();
}


