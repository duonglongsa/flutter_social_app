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

class _SearchFriendScreenState extends State<SearchFriendScreen>  with TickerProviderStateMixin{
  SearchFriendController searchFriendController =
      Get.put(SearchFriendController());

  late TabController _tabController;

  final List<Tab> tabs = <Tab>[
    const Tab(
      text: "Friends",
    ),
    const Tab(
      text: "All",
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
        title: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextField(
              onSubmitted: (val) async {
                await searchFriendController.getSearchList(val);
              },
              decoration: const InputDecoration(
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
                         DefaultTabController(
                          length: tabs.length,
                          child: TabBar(
                            controller: _tabController,
                            onTap: (index) async {
                              setState(() {
                                _tabController.index = index;
                              });
                            },
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            tabs: tabs,
                          ),
                        ),
                        if (searchFriendController.searchFriendList != null && _tabController.index == 0)
                          !searchFriendController.isLoading ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchFriendController.searchFriendList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {},
                                  child: _searchCard(
                                      user: searchFriendController
                                          .searchFriendList![index]));
                            },
                          ) :const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
                          ),
                           if (searchFriendController.searchFriendList != null && _tabController.index == 1)
                          !searchFriendController.isLoading ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                searchFriendController.searchUserList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {},
                                  child: _searchCard(
                                      user: searchFriendController
                                          .searchUserList![index]));
                            },
                          ) :const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
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
