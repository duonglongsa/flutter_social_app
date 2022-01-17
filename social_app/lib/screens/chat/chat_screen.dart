import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/controllers/chat/chat_controller.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  final String roomId;
  final String roomName;

  const ChatScreen({Key? key, required this.roomId, required this.roomName})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.roomId = widget.roomId;
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
                },
                icon: const Icon(Icons.arrow_back_ios)),
            const SizedBox(
              width: 10,
            ),
            Text(widget.roomName, style: const TextStyle(fontSize: 25)),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
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
                              //reverse: true,
                              itemCount: chatController.messageList!.length,
                              itemBuilder: (context, index) => message(
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
      ),
    );
  }

  Widget message({required MessageModel chatMessage}) {
    late double _tapPoistionX, _tapPositionY;

    _onTapDown(TapDownDetails details) {
      _tapPoistionX = details.globalPosition.dx;
      _tapPositionY = details.globalPosition.dy;
      // or user the local position method to get the offset
    }

    return Column(
      children: [
        Text(
          timeago.format(chatMessage.timeCreated!),
          style: kHintTextStyle,
        ),
        Row(
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
            GestureDetector(
              onTapDown: (TapDownDetails details) => _onTapDown(details),
              onLongPress: () {
                showMenu(
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () async {
                        chatController.deleteMessage(chatMessage.messageId!);
                      },
                      height: 20,
                      value: 0,
                      child: const SizedBox(
                        height: 20,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                  context: context,
                  position:
                      RelativeRect.fromLTRB(_tapPoistionX, _tapPositionY, 0, 0),
                );
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    child: Text(
                      chatMessage.content!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                  )),
            )
          ],
        ),
      ],
    );
  }
}
