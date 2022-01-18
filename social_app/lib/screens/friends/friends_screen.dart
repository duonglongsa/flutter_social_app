import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/friend/friend_screen_controller.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/friends/search_friends_screen.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen>
    with TickerProviderStateMixin {
  FriendController friendController = Get.put(FriendController());
  late TabController _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(
      text: "Friend list",
    ),
    Tab(
      text: "Pending",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: cointainerColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Friends',
          style: kPageHeadingStye,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            onPressed: () => Get.to(() => const SearchFriendScreen()),
          ),
        ],
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
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(14, 20, 14, 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.grey[200],
                        //         borderRadius: BorderRadius.circular(25)),
                        //     child: const Padding(
                        //       padding: EdgeInsets.only(left: 12),
                        //       child: TextField(
                        //         decoration: InputDecoration(
                        //             hintText: "Search",
                        //             border: InputBorder.none,
                        //             icon: Icon(Icons.search)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        DefaultTabController(
                          length: tabs.length,
                          child: TabBar(
                            controller: _tabController,
                            onTap: (index) async {
                              setState(() {
                                _tabController.index = index;
                              });
                              if (index == 1) {
                                await friendController.getRequestList();
                              }
                            },
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            tabs: tabs,
                          ),
                        ),
                        if (_tabController.index == 0 &&
                            friendController.friendList != null)
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: friendController.friendList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {},
                                  child: _friendCard(
                                      user:
                                          friendController.friendList![index]));
                            },
                          ),
                        if (_tabController.index == 1 &&
                            friendController.requestFriendList != null)
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                friendController.requestFriendList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {},
                                  child: _pendingCard(
                                      user: friendController
                                          .requestFriendList![index]));
                            },
                          ),
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
          backgroundImage: NetworkImage('$networkFile${user.avatar!.fileName}'),
        ),
        title: Text(
          user.name!,
          style: kLabelStyle,
        ),
        //trailing: TextButton(onPressed: () {}, child: Text("Add")),
      ),
    );
  }

  Widget _pendingCard({required User user}) {
    return Card(
      elevation: 5,
      color: cointainerColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('$networkFile${user.avatar!.fileName}'),
        ),
        title: Text(
          user.name!,
          style: kLabelStyle,
        ),
        subtitle: Text(
          timeago.format(user.timeRequested!),
          style: kHintTextStyle,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () async {
                  friendController.acceptFriend(user.id!, true);
                },
                child: const Text("Accept")),
            TextButton(
                onPressed: () async {
                  friendController.acceptFriend(user.id!, false);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}
