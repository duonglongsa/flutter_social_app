
import 'package:social_app/models/image.dart';

class User {
  ImageModel ?avatar;
  ImageModel ?coverImage;
  String ?id;
  String ?name;
  String? phoneNumber;
  String ?password;
  String ?token;
  String? gender;
  List<String>? blockedInbox;
  List<String>? blockedDiary;
  DateTime? birthDay;
  String? description;
  String? address;
  String? city;
  String? country;

  int? type;
  DateTime? timeRequested;

  User(this.name, this.phoneNumber, this.password);
  
  User.id(this.id);
  User.name(this.name);

  User.fromLoginJson(Map<String, dynamic> json)
      : name = json['data']['username'],
        phoneNumber = json['data']['phonenumber'],
        id = json['data']['id'],
        token = json['token'] ;

  User.fromPostJson(Map<String, dynamic> json)
      : name = json['username'],
        phoneNumber = json['phonenumber'],
        id = json['_id'],
        avatar = ImageModel.fileName(json['avatar']['fileName']);
        //avatar = json['avatar']['fileName'],
        //coverImage = json['cover_image']['fileName'];
  User.fromCommentJson(Map<String, dynamic> json)
      : name = json['username'],
        phoneNumber = json['phonenumber'],
        id = json['_id'];
        //avatar = ImageModel.fileName(json['avatar']['fileName']);
        //avatar = json['avatar']['fileName'],
        //coverImage = json['cover_image']['fileName'];

  User.fromInfoJson(Map<String, dynamic> json)
      : gender = json['gender'],
        blockedInbox = List.castFrom(json['blocked_inbox']),
        blockedDiary = List.castFrom(json['blocked_diary']),
        id = json['_id'],
        phoneNumber = json['phoneNumber'],
        name = json['username'],
        avatar = ImageModel.fromJson(json['avatar']),
        coverImage = ImageModel.fromJson(json['cover_image']) {
    if (json.containsKey('birthday')) {
      birthDay = DateTime.parse(json['birthday']);
    }
    if (json.containsKey('description')) {
      description = json['description'];
    }
    if (json.containsKey('address')) {
      address = json['address'];
    }
    if (json.containsKey('city')) {
      city = json['city'];
    }
    if (json.containsKey('country')) {
      country = json['country'];
    }
  }




  User.fromFriendRequestJson(Map<String, dynamic> json)
      : name = json['username'],
        timeRequested = DateTime.parse(json['createdAt']),
        id = json['_id'],
        avatar = ImageModel.fromJson(json['avatar']);
  

  // Map<String, dynamic> toJson() => {
  //       'username': name,
  //       'phonenumber': phoneNumber,
  //       'password': password,
  //     };
}