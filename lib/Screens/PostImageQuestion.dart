import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:communityhubb/FirebaseServices/FirebaseServices.dart';
import '../Utils/general_utils.dart';

class ImageQuestionPage extends StatefulWidget {
  final File selectedFile;
  const ImageQuestionPage({super.key, required this.selectedFile});

  @override
  State<ImageQuestionPage> createState() => _ImageQuestionPageState();
}

class _ImageQuestionPageState extends State<ImageQuestionPage> {
  final _postTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _postTextController.clear();
    _postTextController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4169E1),
        title: Text(
          "Ask Question",
          style: GoogleFonts.roboto(
              color: Colors.white
          ),
        ),
      ),

      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: mq.height * 0.3,
              width: mq.width * 1,
              child: widget.selectedFile != null
                  ? Image.file(widget.selectedFile, fit: BoxFit.fill,)
                  : Text('No image selected'),
            ),
          ),
          Container(height: 2, color: Colors.black,),
          Expanded( // Place the Expanded widget here
            child: Padding(
              padding: EdgeInsets.only(
                  top: mq.height * 0.005,
                  left: mq.width * 0.02,
                  right: mq.width * 0.02
              ),
              child: TextField(
                controller: _postTextController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onTap: () {

                },
                decoration: InputDecoration(
                    hintText: "Ask Your  Question.....",
                    hintStyle: TextStyle(color: Color(0xFF707070)),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: mq.height * 0.02),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4169E1)), // Change the color here
                ),
                onPressed: () {
                  if (_postTextController.text.isEmpty) {
                    print("field is empty");
                    Utils.flushBarErrorMessage("Please write your question", context);
                  } else {
                    // Utils.flushBarErrorMessage("Clicked", context);
                    firebaseServices.postQuestion(_postTextController,context,"image",widget.selectedFile);
                  }
                },
                child: Container(
                  width: mq.width * 0.8,
                  height: mq.height*0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.roboto(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
