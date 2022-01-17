import 'package:social_app/models/image.dart';

class UserInfo {
  String? gender;
  List<String>? blockedInbox;
  List<String>? blockedDiary;
  String? id;
  String? phoneNumber;
  String? userName;
  DateTime? birthDay;

  ImageModel? avatar;
  ImageModel? coverImage;

  UserInfo.fromJson(Map<String, dynamic> json)
      : gender = json['gender'],
        blockedInbox = List.castFrom(json['blocked_inbox']),
        blockedDiary = List.castFrom(json['blocked_diary']),
        id = json['_id'],
        phoneNumber = json['phoneNumber'],
        userName = json['username'],
        avatar = ImageModel.fromJson(json['avatar']),
        coverImage = ImageModel.fromJson(json['cover_image']) {
    if (json.containsKey('birthday')) {
      birthDay = DateTime.parse(json['birthday']);
    }
  }
}
