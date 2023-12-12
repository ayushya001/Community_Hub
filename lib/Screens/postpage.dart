import 'dart:ffi';
import 'dart:io';

import 'package:communityhubb/FirebaseServices/FirebaseServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/general_utils.dart';
import 'PostImageQuestion.dart';

class postpage extends StatefulWidget {
  const postpage({super.key});

  @override
  State<postpage> createState() => _postpageState();
}

class _postpageState extends State<postpage> {
  final _postTextController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? selectedFile;




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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: mq.height*0.02,
                left: mq.width*0.02,
                right: mq.width*0.02
              ),
              child: Align(
                alignment:Alignment.topLeft,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
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
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: mq.height*0.02,right: mq.width*0.03,left: mq.width*0.04),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  InkWell(
                      onTap: (){
                        _imgFromCamera();


                      },
                      child: Icon(Icons.camera_alt,
                        color: Color(0xFF4169E1)
                        ,size: 32,)),
                  SizedBox(width: mq.width*0.04,),
                  InkWell(
                      onTap: (){
                        _imgFromGallery();

                      }
                      ,child: Icon(Icons.image,color: Color(0xFF4169E1)
                    ,size: 32,)),
                  SizedBox(width: mq.width*0.04,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4169E1)), // Change the color here
                    ),

                    onPressed: (){

                      if(_postTextController.text.isEmpty){
                        print("field is empty");
                        Utils.flushBarErrorMessage("Please write your question", context);
                      }else{
                        firebaseServices.postQuestion(_postTextController,context,"text",File(""));
                      }

                    },
                    child: Container(
                      width: mq.width*0.6,
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
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
  _imgFromGallery() async {
    await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    ).then((value) {
      if (value != null) {
        print(File(value.path));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageQuestionPage(selectedFile: File(value.path)),
          ),
        );
      }
    });
  }
  _imgFromCamera() async {
    await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if (value != null) {
        print(File(value.path));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageQuestionPage(selectedFile: File(value.path)),
          ),
        );
      }
    });
  }
}
