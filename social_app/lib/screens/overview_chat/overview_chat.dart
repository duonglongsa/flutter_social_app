// import 'dart:html';

import 'package:flutter/material.dart';

import 'conversation.dart';
import 'story.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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
                                backgroundImage: AssetImage("images/anh1.png"),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            child: Icon(Icons.camera_alt, color: Colors.black)),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            child: Icon(Icons.edit, color: Colors.black)),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
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
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.add, size: 24, color: Colors.black),
                    ),
                  ),
                  Story(img: "anh1.png"),
                  Story(img: "anh2.png"),
                  Story(img: "anh3.png"),
                  Story(img: "anh4.png"),
                  Story(img: "anh1.png"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Conversation(
                      image: "anh1.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "anh2.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: false),
                  Conversation(
                      image: "anh3.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "anh4.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: false),
                  Conversation(
                      image: "anh5.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "anh1.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "anh2.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "jpg2.jpg",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                  Conversation(
                      image: "anh3.png",
                      name: "Your Name",
                      msg: "Hello what is your name?",
                      isRead: true),
                ],
              ),
            ),
          ])),
    );
  }
}
