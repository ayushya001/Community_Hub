import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityhubb/FirebaseServices/FirebaseServices.dart';
import 'package:communityhubb/Models/QuestionModel.dart';
import 'package:communityhubb/Models/UserModels.dart';
import 'package:communityhubb/Screens/postpage.dart';
import 'package:communityhubb/Widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/SearchingProvider.dart';
import '../Widget/CommunityHubAppBar.dart';
import 'SettingsPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QuestionModel> _ques = [];
  List<UserModel> _users = [];

  List<QuestionModel> _searchQuestionList = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    print("Home page is rebuilt");
    return Scaffold(
      appBar: CustomAppBar(
        onSearch: (query) {
          // Handle the search logic here
          if(query.isEmpty){
            print("Query is empty");
          }
          Provider.of<SearchingProvider>(context, listen: false).searchQuestions(query, _ques);
          // setState(() {
          //
          //   _isSearching = query.isNotEmpty;
          //   _searchQuestionList = _ques
          //       .where((question) => question.Question.toLowerCase()
          //           .contains(query.toLowerCase()))
          //       .toList();
          //   print("Total Questions: ${_searchQuestionList.length}");
          // });
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => postpage(),
            ),
          );
        },
        tooltip: 'Increment',
        backgroundColor: Color(0xFF4169E1),
        child: const Icon(
          CupertinoIcons.pencil,
          size: 48,
        ),
      ),
      body: Padding(
          padding:
              EdgeInsets.only(left: mq.width * 0.02, right: mq.width * 0.02),
          child: StreamBuilder<QuerySnapshot>(
            stream: firebaseServices.getQuestion(),
            builder: (context, questionSnapshot) {
              if (questionSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (questionSnapshot.hasData) {
                final questionData = questionSnapshot.data!.docs;
                print("Questions data: " + questionData.toString());

                List<String> usersIds =
                    questionData.map((doc) => doc['By'] as String).toList();

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('uid', whereIn: usersIds)
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (userSnapshot.hasData) {
                      final userData = userSnapshot.data!.docs;
                      print("Users data: " + userData.toString());

                      List<UserModel> _users = userData
                          .map((e) => UserModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      List<QuestionModel> _questions = questionData
                          .map((e) => QuestionModel.fromJson(
                              e.data() as Map<String, dynamic>))
                          .toList();

                      _ques = _questions;


                      return Consumer<SearchingProvider>(
                        builder: (context, searchProvider, child) {
                          return searchProvider.isSearching ?
                          ListView.builder(
                              itemCount: _searchQuestionList.length,
                              itemBuilder: (context, index) {
                                return appWidget(
                                  questions: _searchQuestionList[index],
                                  user: _users.firstWhere(
                                          (user) => user.uid == _searchQuestionList[index].By),
                                );
                              },
                            ) : ListView.builder(
                              itemCount: _questions.length,
                              itemBuilder: (context, index) {
                                return appWidget(
                                  questions: _questions[index],
                                  user: _users.firstWhere(
                                          (user) => user.uid == _questions[index].By),
                                );
                              },
                            );
                          },
                      );
                    } else {
                      return Center(
                        child: Container(
                          height: 200,
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Container(
                    height: 200,
                    color: Colors.black,
                  ),
                );
              }
            },
          )),
    );



  }


}



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearch;

  const CustomAppBar({super.key, required this.onSearch});

  @override
  Size get preferredSize => Size.fromHeight(500); // Set the desired height

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Container(
          // height: mq.height * 0.2,
          decoration: BoxDecoration(
              color: Color(0xFF4169E1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: mq.height * 0.02,
                    left: mq.width * 0.02,
                    right: mq.width * 0.02),
                child: Row(
                  children: [
                    Container(
                      width: 40, // Adjust the size to fit the CircleAvatar
                      height: 40, // Adjust the size to fit the CircleAvatar
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20, // Adjust the radius as needed
                        backgroundImage: AssetImage(
                            'assets/images/usericon2.png'), // Replace with your image asset path
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.04),
                      child: AutoSizeText(
                        "Community Hubs",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Cursive'),
                        maxLines: 1,
                      ),
                    ),
                    Spacer(), // Pushes the following widget to the end
                    IconButton(
                      icon: Icon(
                        Icons.settings, // Settings icon
                        color: Colors.white, // Set icon color
                      ),
                      onPressed: () {
                        print("Settings icon pressed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Settingspage()),
                        );
                        // Add your onPress functionality here
                      },
                    ),
                  ],
                ),
              ),
              SearchWidget(onSearchChanged: onSearch),
              Padding(
                padding: EdgeInsets.only(
                    left: mq.width * 0.04,
                    top: mq.width * 0.03,
                    bottom: mq.height * 0.03),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Ask your Question",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cursive'),
                      maxLines: 1,
                    ),
                    Icon(
                      CupertinoIcons.pencil,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xFFE8E6EA),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
