import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Screens/homepage.dart';
import '../Screens/postpage.dart';
import '../Utils/general_utils.dart';



class firebaseServices{

  final currentUser = FirebaseAuth.instance.currentUser;


  bool _loading = false;

  String _gender = "";
  //
  // bool get loading => _loading;
  //
  setloading(bool value) {
    _loading = value;
    // notifyListeners();
  }

  void setgender(String value){
    _gender = value;
    // notifyListeners();
    print(_gender);
  }

  static void postQuestion(TextEditingController question,BuildContext context,String Type, File file) async {

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent the user from dismissing the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF4169E1),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator(color: Colors.white,)),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Text("Posting...",style: TextStyle(
                  color: Colors.white
              ),),
            ],
          ),
        );
      },
    );


    final currentUser = FirebaseAuth.instance.currentUser;
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final random = Random();
    final String questionid = "ques${random.nextInt(5555)}";

    try{
      if (currentUser != null) {
        final uid = currentUser.uid;

        if(Type=="image"){
          //getting image file extension
          final ext = file.path.split('.').last;

          //storage file ref with path
          final ref = FirebaseStorage.instance.ref().child(
              'images/$questionid/${DateTime.now().millisecondsSinceEpoch}.$ext');

          //uploading image
          await ref
              .putFile(file, SettableMetadata(contentType: 'image/$ext'))
              .then((p0) {
            print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
          });

          //updating image in firestore database
          final imageUrl = await ref.getDownloadURL();
          Map<String, dynamic> postQues = {
            'QuestionId': questionid,
            'Question': question.text,
            'Type': Type,
            'Image': imageUrl,
            'Time': time ,
            'By' : uid,
          };

          await FirebaseFirestore.instance
              .collection("Questions")
              .doc(questionid)
              .set(postQues);

        }

        else{
          Map<String, dynamic> postQues = {
            'QuestionId': questionid,
            'Question': question.text,
            'Type': Type,
            'Time': time ,
            'By' : uid,
          };

          await FirebaseFirestore.instance
              .collection("Questions")
              .doc(questionid)
              .set(postQues);
        }

      }


    }finally{
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Homepage(),
        ),
      );


    }


  }

  static void postAnswer(TextEditingController answer,BuildContext context,String Type,String Questionid) async {

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent the user from dismissing the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF4169E1),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator(color: Colors.white,)),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Text("Posting...",style: TextStyle(
                  color: Colors.white
              ),),
            ],
          ),
        );
      },
    );


    final currentUser = FirebaseAuth.instance.currentUser;
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final random = Random();
    final String answerid = "ans${random.nextInt(5555)}";

    try{
      if (currentUser != null) {
        final uid = currentUser.uid;


        Map<String, dynamic> postAns = {
          'AnswerId': answerid,
          'Answer': answer.text,
          'Type': Type,
          'Time': time ,
          'By' : uid,
          'QuestionId' : Questionid,
        };

        await FirebaseFirestore.instance
            .collection("Answers")
            .doc(answerid)
            .set(postAns);
      }


    }finally{
      Navigator.of(context).pop();
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) =>
      //
      //   ),
      // );


    }


  }

  static getselfinfo(){

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final uid = currentUser.uid;
      try {
        FirebaseFirestore.instance
            .collection("Users").doc(uid)
            .get();
      } catch(e){
        print(e.toString());
      }

    }else{
      print("user is null");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getQuestion() {
    return FirebaseFirestore.instance
        .collection('Questions')
        .orderBy('Time', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAnswer(String quesid) {
    return FirebaseFirestore.instance
        .collection('Answers').where('QuestionId', isEqualTo: quesid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance
        .collection('Users')
        .snapshots();
  }





}