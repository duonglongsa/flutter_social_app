import 'dart:convert';
import 'dart:developer';

import 'package:social_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/utilities/configs.dart';

class FriendService {
  static Future<List<User>> getRequestFriendList(String token) async {
    var res = await http.post(
        Uri.parse(localhost + "/v1/friends/get-requested-friend/"),
        headers: {
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    var responseJson = json.decode(res.body);
    return (responseJson["data"]["friends"] as List)
        .map((p) => User.fromFriendRequestJson(p))
        .toList();
  }

  static Future<void> acceptFriendRequest(
      String token, String userId, bool isAccept) async {
    var res = await http
        .post(Uri.parse(localhost + "/v1/friends/set-accept/"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'user_id': userId,
      'is_accept': isAccept ? '1' : '2'
    });
  }

  static Future<void> sendRequestFriend(String token, String userId) async {
    var res = await http.post(
        Uri.parse(localhost + "/v1/friends/set-request-friend/"),
        headers: {
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'user_id': userId,
        });
    print(res.body);
  }

  static Future<List<User>> getFriendList(String token) async {
    var res =
        await http.post(Uri.parse(localhost + "/v1/friends/list"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    var responseJson = json.decode(res.body);
    print(res.body);
    return (responseJson["data"]["friends"] as List)
        .map((p) => User.fromFriendRequestJson(p))
        .toList();
  }

  static Future<List<User>> getSearchFriendList(
      String token, String keyword) async {
    var res =
        await http.post(Uri.parse(localhost + "/v1/friends/list"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'keyword': keyword
    });
    var responseJson = json.decode(res.body);
    return (responseJson["data"]["friends"] as List)
        .map((p) => User.fromFriendRequestJson(p))
        .toList();
  }

  static Future<List<User>> getSearchUserList(
      String token, String keyword) async {
    var res =
        await http.post(Uri.parse(localhost + "/v1/users/search"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'keyword': keyword
    });
    var responseJson = json.decode(res.body);
    return (responseJson["data"] as List)
        .map((p) => User.fromFriendRequestJson(p))
        .toList();
  }

  static Future<void> blockUser(String token, String blockId) async {
    var res =
        await http.post(Uri.parse(localhost + "/v1/users/set-block-diary"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    }, body: {
      'user_id': blockId,
      'type': '0'
    });
    log(res.body);
  }


  static Future<User> getUserInfo(String token, String userId) async {
    User user;
    var res = await http
        .get(Uri.parse(localhost + "/v1/users/show/$userId"), headers: {
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    var responseJson = json.decode(res.body);
    user = User.fromInfoJson(responseJson["data"]);
    user.type = responseJson["type"];
    return user;
  }
  
}
