import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/controllers/chat/chat_controller.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final User member;

  const ChatScreen({Key? key, required this.roomId, required this.member})
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
  void dispose() {
    super.dispose();
    chatController.socket!.dispose();
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
                  Get.back(result: chatController.messageList!.last);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            CircleAvatar(
              radius: 15,
              backgroundImage:
                  NetworkImage("$networkFile${widget.member.avatar!.fileName}"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.member.name!, style: const TextStyle(fontSize: 25)),
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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    //chat text
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: GetBuilder<ChatController>(
                            init: chatController,
                            builder: (context) {
                              if (chatController.messageList != null) {
                                return ListView.builder(
                                  controller: chatController.scrollController,
                                  itemCount: chatController.messageList!.length,
                                  itemBuilder: (context, index) => message(
                                    chatMessage:
                                        chatController.messageList![index],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }))),
                Container(
                  //chat tools at the bottom
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
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
                                child: FocusScope(
                                  onFocusChange: (focus) {
                                    if (focus) {
                                      print("typing");
                                      chatController.onTypingMessage();
                                    } else {
                                      print("stop");
                                      chatController.onStopTypingMessage();
                                    }
                                  },
                                  child: TextField(
                                    controller:
                                        chatController.messageTextConntroller,
                                    decoration: const InputDecoration(
                                        hintText: "Type message",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        IconButton(
                            onPressed: () async {
                              await chatController.onSendTap();
                              chatController.scrollController.jumpTo(
                                  chatController.scrollController.position
                                      .maxScrollExtent);
                            },
                            icon: Icon(Icons.send),
                            color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: GetBuilder(
                init: chatController,
                builder: (_) {
                  if (!chatController.isTyping) {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 63),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              "$networkFile${widget.member.avatar!.fileName}"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xff8782CE),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              child: DefaultTextStyle(
                                style: const TextStyle(),
                                child: AnimatedTextKit(
                                  totalRepeatCount:
                                      0x7fffffffffffffff, //infinity
                                  animatedTexts: [
                                    WavyAnimatedText('Typing...'),
                                  ],
                                  isRepeatingAnimation: true,
                                ),
                              ),
                              constraints: const BoxConstraints(maxWidth: 200),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
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
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "$networkFile${widget.member.avatar!.fileName}"),
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
                        chatMessage.content = "Tin nhan da bi thu hoi";
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
                    color: chatMessage.content == "Tin nhan da bi thu hoi"
                        ? Colors.transparent
                        : chatMessage.isSender
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
                      style: chatMessage.content == "Tin nhan da bi thu hoi"
                          ? const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic)
                          : const TextStyle(color: Colors.white),
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
