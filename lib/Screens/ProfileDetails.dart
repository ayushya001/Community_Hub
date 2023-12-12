import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../Provider/AuthProvider.dart';
import '../Provider/ImagePickerProvider.dart';

import '../Utils/AppComponentsColor.dart';
import '../Utils/general_utils.dart';

import '../Widget/RoundButton.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _Firstname = TextEditingController();
  TextEditingController _Enroll = TextEditingController();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode EnrollFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<Authprovider>(context,listen: false);
    final imageprovider = Provider.of<ImageProviderClass>(context,listen: false);


    print("whole rebuilt");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,
                      right: MediaQuery.of(context).size.width*0.1),
                  child: Text("Skip",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.labelColor
                  ),),
                ),

              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12),
                  child: Text("Profile details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Colors.black,

                  ),),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Center(
                child: Stack(
                  children: [
                Consumer<ImageProviderClass>(
                builder: (context, imageProvider, child) {
                      return Stack(
                        alignment: Alignment.bottomRight, // To position the plus icon at the bottom-right corner
                        children: [
                          ClipOval(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: Colors.white54
                                )
                              ),
                              child: imageProvider.imagePath.isNotEmpty
                                  ? Image.file(File(imageProvider.imagePath), fit: BoxFit.fitWidth)
                                  : Image.asset("assets/images/usersicon.png", fit: BoxFit.fill),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

                              if(imagefile !=null){
                                Provider.of<ImageProviderClass>(context, listen: false)
                                    .setImagePath(imagefile.path);

                                print("only image picker");
                              }


                            },

                            child: Container(
                              height: 40, // Adjust the size as needed
                              width: 40, // Adjust the size as needed
                              decoration: BoxDecoration(
                                color: Colors.blue, // Customize the color of the circle
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white, // Customize the icon color
                                  size: 24, // Customize the icon size
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                },
              ),

                    // Positioned(
                    //     bottom: 0,
                    //     right: 0,
                    //     child: InkWell(
                    //       onTap: () async {
                    //         final imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    //
                    //         if(imagefile !=null){
                    //           Provider.of<ImageProviderClass>(context, listen: false)
                    //               .setImagePath(imagefile.path);
                    //
                    //           print("only image picker");
                    //         }
                    //
                    //
                    //       },
                    //       child: Container(
                    //         height: 30,
                    //         width: 30,
                    //
                    //         decoration: BoxDecoration(
                    //           color: Colors.red,
                    //           shape: BoxShape.circle
                    //         ),
                    //         child: Center(
                    //           child: Icon(
                    //             Icons.add,
                    //             size: 28,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ))
                  ],

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller: _Firstname,
                  keyboardType: TextInputType.text,
                  focusNode: firstnameFocusNode,
                  decoration: InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Appcolors.labelColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                      ),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                      ),

                  ),
                  onFieldSubmitted: (val){
                    Utils.fieldFocusChange(context, firstnameFocusNode, EnrollFocusNode);
                  },

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller: _Enroll,
                  keyboardType: TextInputType.text,
                  focusNode: EnrollFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your Enrollment No",
                    hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                    labelText: "Enrollment NO",
                    labelStyle: TextStyle(color: Appcolors.labelColor),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                    ),


                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width*0.8,
              //   child: TextFormField(
              //     controller: _lastname,
              //     keyboardType: TextInputType.text,
              //     focusNode: lastnameFocusNode,
              //     decoration: InputDecoration(
              //       hintText: "",
              //       hintStyle: TextStyle(color: Appcolors.hintTextcolor),
              //       labelText: "Enrollment NO",
              //       labelStyle: TextStyle(color: Appcolors.labelColor),
              //       floatingLabelBehavior: FloatingLabelBehavior.always,
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(20),
              //           borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
              //       ),
              //
              //
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
              //       ),
              //
              //     ),
              //
              //   ),
              // ),


              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
          RoundButton(title: "Confirm", onpress: () {
            if (_Firstname.text.isEmpty) {
              Utils.flushBarErrorMessage("First name Cannot be empty", context);
            } else if (_Enroll.text.isEmpty) {
              Utils.flushBarErrorMessage("Last name cannot be empty", context);
            }
            else if (_Enroll.text.length!= 12) {
              Utils.flushBarErrorMessage("Enter your valid Enrollment no", context);
            }
            else if (imageprovider.imagePath.isEmpty) {
              Utils.flushBarErrorMessage("Please set your profile photo", context);
            }
            else {
              authprovider.Details(context, _Firstname.text.toString(), _Enroll.text.toString().toUpperCase(),imageprovider.imagePath,_Firstname,_Enroll);
              // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.ChooseGender)));
              print("api hit");
            }
          }),

              //0902cs211016





            ],
          ),
        ),
      )
    );
  }
}
