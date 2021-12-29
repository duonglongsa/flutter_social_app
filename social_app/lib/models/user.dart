
class User {
  String ?avatar;
  String ?id;
  String ?name;
  String? phoneNumber;
  String ?password;
  String ?token;

  DateTime? timeRequested;

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

  User.fromFriendRequestJson(Map<String, dynamic> json)
      : name = json['username'],
        timeRequested = DateTime.parse(json['createdAt']),
        id = json['_id'];
  

  // Map<String, dynamic> toJson() => {
  //       'username': name,
  //       'phonenumber': phoneNumber,
  //       'password': password,
  //     };
}