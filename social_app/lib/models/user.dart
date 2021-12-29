import 'dart:convert';

import 'package:get/get.dart';

class User {
  String ?avatar;
  String ?id;
  String ?name;
  String? phoneNumber;
  String ?password;
  String ?token;

  User(this.name, this.phoneNumber, this.password);
  
  User.id(this.id);

  User.fromLoginJson(Map<String, dynamic> json)
      : name = json['data']['username'],
        phoneNumber = json['data']['phonenumber'],
        id = json['data']['id'],
        token = json['token'] ;

  User.fromPostJson(Map<String, dynamic> json)
      : name = json['username'],
        phoneNumber = json['phonenumber'],
        id = json['_id'];

  

  // Map<String, dynamic> toJson() => {
  //       'username': name,
  //       'phonenumber': phoneNumber,
  //       'password': password,
  //     };
}