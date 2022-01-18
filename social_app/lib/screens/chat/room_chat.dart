import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/chat/room_chat_controller.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/screens/chat/chat_screen.dart';
import 'package:social_app/utilities/style_constants.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final RoomChatController roomChatController = Get.put(RoomChatController());

  @override
  void initState() {
    super.initState();
    roomChatController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cointainerColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Chats',
          style: kPageHeadingStye,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
          color: backGroundColor,
          child: ListView(children: <Widget>[
            GetBuilder<RoomChatController>(
                init: roomChatController,
                builder: (context) {
                  if (roomChatController.roomChatList != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: roomChatController.roomChatList!.length,
                      itemBuilder: (context, index) => roomChat(
                          room: roomChatController.roomChatList![index]),
                    );
                  } else {
                    return Container();
                  }
                })
          ])),
    );
  }

  Widget roomChat({required RoomModel room}) {
    late double _tapPoistionX, _tapPositionY;

    _onTapDown(TapDownDetails details) {
      _tapPoistionX = details.globalPosition.dx;
      _tapPositionY = details.globalPosition.dy;
      // or user the local position method to get the offset
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => ChatScreen(
              roomId: room.roomId!,
              roomName: room.memberName[0],
            ));
      },
      onTapDown: (TapDownDetails details) => _onTapDown(details),
      onLongPress: () {
        showMenu(
          items: <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () async {
                roomChatController.deleteRoomChat(room.roomId!);
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
          position: RelativeRect.fromLTRB(_tapPoistionX, _tapPositionY, 0, 0),
        );
      },
      child: Card(
        color: backGroundColor,
        //elevation: 3,
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
          ),
          title: Text(
            room.memberName[0],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(room.lastMessage.content!,
              style: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
