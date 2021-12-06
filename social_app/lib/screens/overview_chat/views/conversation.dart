import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:social_app/screens/chat/views/chat_screen.dart';

class Conversation extends StatelessWidget {
  final String image;
  final String name;
  final String msg;
  final bool isRead;

  const Conversation(
      {Key? key,
      required this.image,
      required this.name,
      required this.msg,
      required this.isRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ChatScreen()),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("lib/assets/$image"),
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(msg, style: TextStyle(color: Colors.grey)),
          trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: isRead ? Colors.white : Colors.blue))),
    );
  }
}
