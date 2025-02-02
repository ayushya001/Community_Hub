import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityhubb/Screens/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Models/UserModels.dart';
import '../Provider/AuthProvider.dart';
import '../Screens/ProfileDetails.dart';
import '../Screens/homepage.dart';
import '../Screens/postpage.dart';
import '../Utils/general_utils.dart';



class firebaseServices{

  static final currentUser = FirebaseAuth.instance.currentUser;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();


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





  static SigninUsingGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled the sign-in

      // Obtain the auth details from the Google user
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      // Sign in to Firebase
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user was successfully signed in
      if (userCredential.user != null) {
        // Check if the user's document exists in the "Users" collection
        FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get().then((documentSnapshot){
          if (documentSnapshot.exists) {
            // If the document exists, navigate to the Homepage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          } else {
            // If the document does not exist, navigate to the ProfileDetails page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetails(),
              ),
            );
          }
          Provider.of<Authprovider>(context, listen: false).setloading2(false);

        }).catchError((error) {
          // Handle any errors that might occur
          print("Error checking user document: $error");
        });



      }
    }  catch (e) {
      print("Error signing in with Google: $e");
      Provider.of<Authprovider>(context, listen: false).setloading2(false);
      return null;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getQuestion() {
    return FirebaseFirestore.instance
        .collection('Questions')
        .orderBy('Time', descending: true)
        .snapshots();
  }

  static Future<void> deleteQuestion(String questionId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Questions')
          .doc(questionId)
          .delete();
      print('Question deleted successfully');


      await FirebaseFirestore.instance
          .collection('Answers')
          .where('QuestionId', isEqualTo: questionId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (error) {
      print('Error deleting question: $error');
    }
  }

  static Future<void> deleteAnswer(String answerid) async {
    try {
      await FirebaseFirestore.instance
          .collection('Answers')
          .doc(answerid)
          .delete();
      print('answer deleted successfully');



    } catch (error) {
      print('Error deleting answer: $error');
    }
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

  static logouted() async {
    try {
      // Log out the current user
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully.");

      // Navigate to the signup page
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Signup()), // Replace 'Signup' with your actual signup page widget
      // );
    } catch (e) {
      print("Error logging out: $e");
    }
  }





}