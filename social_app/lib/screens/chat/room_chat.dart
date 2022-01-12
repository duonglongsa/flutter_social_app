import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/chat/room_chat_controller.dart';
import 'package:social_app/models/room_model.dart';
import 'package:social_app/screens/chat/chat_screen.dart';

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
      body: Container(
          color: Color(0xFF202466),
          child: ListView(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Positioned(
                                right: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "+9",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ))))
                          ],
                        ),
                        Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25)),
                width: MediaQuery.of(context).size.width - 40,
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        icon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<RoomChatController>(
                init: roomChatController,
                builder: (context) {
                  if (roomChatController.roomChatList != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: roomChatController.roomChatList!.length,
                      itemBuilder: (context, index) => roomChat(
                        room: roomChatController.roomChatList![index]
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
          ])),
    );
  }

  Widget roomChat({required RoomModel room}) {
    return InkWell(
      onTap: (){
        Get.to(() => ChatScreen(roomId: room.roomId!, roomName: room.memberName[0],));
      },
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
          trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white))),
    );
  }
}
