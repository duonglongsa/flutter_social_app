import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/friend/search_friend_controller.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/utilities/style_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  _SearchFriendScreenState createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  SearchFriendController searchFriendController =
      Get.put(SearchFriendController());

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
              onSubmitted: (val) {
                setState(() {
                  _items.add(val);
                });
                myController.clear();
                myFocusNode.requestFocus();
              },
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
            GetBuilder<SearchFriendController>(
                init: searchFriendController,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if (searchFriendController.searchList != null)
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchFriendController.searchList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {},
                                  child: _searchCard(
                                      user: searchFriendController
                                          .searchList![index]));
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

  Widget _searchCard({required User user}) {
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
