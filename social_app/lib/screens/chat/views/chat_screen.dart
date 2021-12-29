
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/screens/chat/controllers/chat_controller.dart';
import 'package:social_app/services/chat_service.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'chat_message.dart';
import 'options_screen.dart';



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    print("init");
    chatController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Row(
          children: [

            IconButton(
                onPressed: () async {
                  chatController.onInit();
                }, icon: Icon(Icons.arrow_back_ios)),
            InkWell(
              child: const CircleAvatar(
                  backgroundImage: AssetImage("lib/assets/avatar.jpg")),
              onTap: () => _navigateToNextScreen(context),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text("Girl", style: TextStyle(fontSize: 25)),
                Text("Active 3m ago", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        
        ),
        backgroundColor: cointainerColor,
        elevation: 5,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),

      ),
      body: Column(
        children: [
          Expanded(
              //chat text
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: GetBuilder<ChatController>(
                      init: chatController,
                      builder: (context) {
                        if (chatController.messageList != null) {
                          return ListView.builder(
                            itemCount: chatController.messageList!.length,
                            itemBuilder: (context, index) => Message(
                              chatMessage: chatController.messageList![index],
                            ),
                          );
                        } else {
                          return Container();
                        }
                        ;
                      }))),
          Container(
            //chat tools at the bottom
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
            decoration: BoxDecoration(
              color: cointainerColor,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.attach_file),
                      color: Colors.white),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt_outlined),
                      color: Colors.white),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: chatController.messageTextConntroller,
                            decoration: const InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none),
                          ),
                        ),
                        
                      ],
                    ),
                  )),
                  IconButton(
                      onPressed: () => chatController.onSendTap(),
                      icon: Icon(Icons.send),
                      color: Colors.white),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OptionsScreen()));
  }
}

class Message extends StatelessWidget {
  const Message({required this.chatMessage});

  final MessageModel chatMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chatMessage.isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!chatMessage.isSender) ...[
          const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("lib/assets/avatar.jpg"),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: chatMessage.isSender
                  ? const Color(0xff6E65E8)
                  : const Color(0xff8782CE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(2, 8), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              child: Text(
                chatMessage.content!,
                style: TextStyle(color: Colors.white),
              ),
              constraints: BoxConstraints(maxWidth: 200),
            ))
      ],
    );
  }
}
