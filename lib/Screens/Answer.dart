import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityhubb/FirebaseServices/FirebaseServices.dart';
import 'package:communityhubb/Models/AnswerModel.dart';
import 'package:communityhubb/Models/QuestionModel.dart';
import 'package:communityhubb/Utils/AppComponentsColor.dart';
import 'package:communityhubb/Utils/general_utils.dart';
import 'package:communityhubb/Widget/AnswerWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/UserModels.dart';
import '../Widget/widget.dart';

class AnswerPage extends StatefulWidget {

  final QuestionModel questions;
  final UserModel users;
  AnswerPage({super.key, required this.users, required this.questions});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  List<AnswerModel> _ans = [];
  List<UserModel> _users = [];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("the imge is "+widget.users.image);
    final mq  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4169E1),
        title: Text(
          "Community Hub",
              style: TextStyle(
            fontSize: 24,
                fontFamily:'cursive'
        ),

        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: mq.width*0.06,top: 10),
            child: AutoSizeText(
              widget.questions.Question,
              style: GoogleFonts.roboto(
                // textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,

                fontWeight: FontWeight.w400,
                // fontStyle: FontStyle.italic,
              ),


            ),
          ),
          SizedBox(height: mq.height*0.01,),
          Container(
            color: Appcolors.borderColorApplogo,
            width: double.infinity,
            height: 1,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseServices.getAnswer(widget.questions.QuestionId),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // or a loading indicator
                }
                if (userSnapshot.hasData) {
                  print("snapshot has data");
                  final data = userSnapshot.data!.docs;
                  print(data.toString());

                  _ans = data
                      .map((e) => AnswerModel.fromJson(e.data() as Map<String, dynamic>))
                      .toList();

                  print("The answers are:-"+_ans.toString());

                  List<String> usersIds = data
                      .map((doc) => doc['By'] as String)
                      .toList();

                  if (usersIds.isEmpty) {
                    // If there are no answers, display "No answers" in the center
                    return Center(
                      child: Text("No answers!! write the first answer.."),
                    );
                  }

                  print("the usersIds are:--"+usersIds.toString());

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('uid', whereIn: usersIds)
                        .snapshots(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // or a loading indicator
                      }
                      if (userSnapshot.hasData) {
                        print("snapshot has users  data");
                        final data = userSnapshot.data!.docs;
                        print("users data are:-"+data.toString());

                        _users = data
                            .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
                            .toList();



                        return ListView.builder(
                          itemCount: _users.length,

                          itemBuilder: (context, index) {
                            final answer = _ans[index];
                            final user = _users[index];
                            // final question = _users[]
                            return AnswerWidget(answers: answer,user:user,);
                          },
                        );
                      } else {
                        // Default return statement for when there is no data
                        return Center(
                          child: Container(
                            height: 200,
                            color: Colors.black,
                          ),
                        ); // You can replace this with an appropriate widget
                      }
                    },
                  );
                } else {
                  // Default return statement for when there is no data
                  return Center(
                    child: Container(
                      height: 200,
                      color: Colors.black,
                    ),
                  ); // You can replace this with an appropriate widget
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        color:  Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color:Appcolors.borderColorApplogo , // Change this color to your desired border color
                            width: 1, // You can adjust the border width as needed
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onTap: () {
                              // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                            },
                            decoration: InputDecoration(
                                hintText: "Write Something",
                                hintStyle: TextStyle(color: Color(0xFF4169E1)),
                                border: InputBorder.none
                            ),

                          ),
                        ),
                      ),
                    ),
                    MaterialButton(onPressed: (){
                      if(_textController.text.isEmpty){
                        Utils.flushBarErrorMessage("Please write Answer first", context);
                      }else{
                        firebaseServices.postAnswer(_textController, context, "String",widget.questions.QuestionId);
                        _textController.clear();
                      }

                    },
                      padding: EdgeInsets.only(left: 3),
                      shape: CircleBorder(),
                      minWidth: 0,
                      color: Color(0xFF4169E1),
                      child: Icon(Icons.send , color: Colors.white, size: 40,),


                    )

                  ],
                ),
              ),
          ),
        ],

      ),




    );
  }
}
