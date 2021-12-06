import 'package:flutter/material.dart';

import 'package:social_app/view/chat/views/chat_message.dart';

import 'options_screen.dart';



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //final SigninController signinController = Get.put(SigninController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202466),
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
            InkWell(
                child: CircleAvatar(backgroundImage: AssetImage("lib/assets/avatar.jpg")),
                onTap: () => _navigateToNextScreen(context),
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                Text("Girl", style: TextStyle(fontSize: 25)),
                Text("Active 3m ago", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.local_phone), color: Colors.blue,),
          IconButton(onPressed: (){}, icon: Icon(Icons.videocam), color: Colors.blue,),
          SizedBox(width: 10)
        ],
        backgroundColor: const Color(0xff312B83),
        elevation: 0,
      ),

      body:
      Column(
        children: [
          ClipPath(
            clipper: CustomShape(), // this is my own class which extendsCustomClipper
            child: Container(
              height: 35,
              color: const Color(0xff312B83),
            ),
          ),

          Expanded( //chat text
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: ListView.builder(
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) =>
                    Message(chatMessage: demeChatMessages[index], ),
              )
            )
          ),

          Container( //chat tools at the bottom
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 7
            ),
            decoration: BoxDecoration(
              color: const Color(0xff312B83),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.attach_file), color: Colors.white),
                  IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined), color: Colors.white),
                  SizedBox(
                      width: 5
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Type message",
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.sentiment_satisfied_alt_rounded)),
                          ],
                        ),
                      )
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.send), color: Colors.white),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OptionsScreen()));
  }

}

class Message extends StatelessWidget {
  const Message({required this.chatMessage});

  final ChatMessage chatMessage;

  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment:
        chatMessage.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(!chatMessage.isSender) ...[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("lib/assets/avatar.jpg"),
          ),
          SizedBox(width: 10,)
        ],

        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(color:
            chatMessage.isSender ? const Color(0xff6E65E8) : const Color(0xff8782CE),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(child: Text(chatMessage.text, style: TextStyle(color: Colors.white),),
                          constraints: BoxConstraints(maxWidth: 200),)
        )
      ],
    );
  }
}

class CustomShape extends CustomClipper<Path> { //rounded appbar
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height -25);
    path.quadraticBezierTo(width / 2, height+25, width, height - 25);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}