import 'package:http/http.dart' as http;
import 'package:social_app/models/user.dart';
import 'package:social_app/utilities/configs.dart';

Future<http.Response> register(User user) async {
  var res = await http.post(Uri.parse(localhost + "/v1/users/register"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: {
        "username": user.name,
        "phonenumber": user.phoneNumber,
        "password": user.password
      });
  return res;
}

Future<http.Response> login(String phonenumber, String password) async {
  var res = await http.post(Uri.parse(localhost + "/v1/users/login"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: {
        "phonenumber": phonenumber,
        "password": password
      });
  print("sucess: $res");
  return res;
}

