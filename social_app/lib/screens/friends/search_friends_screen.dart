import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/friend/friend_screen_controller.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  _SearchFriendScreenState createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    super.initState();
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: cointainerColor,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              color: backGroundColor,
              height: double.infinity,
            ),
            GetBuilder<FriendController>(
                init: friendController,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    ));
  }
  Widget _friendCard({required User user}) {
    return Card(
      elevation: 5,
      color: cointainerColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("lib/assets/avatar.jpg"),
        ),
        title: Text(
          user.name!,
          style: kLabelStyle,
        ),
        //trailing: TextButton(onPressed: () {}, child: Text("Add")),
      ),
    );
  }
}
