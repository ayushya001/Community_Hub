import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityhubb/Widget/RoundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../FirebaseServices/FirebaseServices.dart';
import '../Provider/ImagePickerProvider.dart';
import 'SignupPage.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  void initState() {
    // TODO: implement initState
    // firebaseServices.getselfinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Users").where("uid",isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                    //  stream:firebaseServices.getselfinfo() ,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // Handle error state
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      // Handle data state
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.05,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Center(
                                child: Text("Profile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
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

                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.zero, // No rounded corners
                                              border: Border.all(
                                                color: Colors.blue, // Border color
                                                width: 1.0, // Border width
                                              ),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: userData['image'],
                                              fit: BoxFit.cover, // Ensures the image fills the container
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Placeholder while loading
                                              errorWidget: (context, url, error) => Center(
                                                child: Icon(Icons.error, color: Colors.red), // Error widget
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () async {
                                                  final imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

                                                  if(imagefile !=null){
                                                    Provider.of<ImageProviderClass>(context, listen: false)
                                                        .setImagePath(imagefile.path);

                                                    print("only image picker");
                                                  }


                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,

                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      border: Border.all(
                                                        color: Colors.black, // Set the border color to blue
                                                        width: 2.0, // Adjust the border width as needed
                                                      ),
                                                      color: Colors.black,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.camera,
                                                      size: 28,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )),

                                        ],






                                      );

                                    },
                                  ),


                                ],

                              ),

                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.05,
                            ),
                            Container(
                              alignment: Alignment.center, // Align the content in the center
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Ensures the row only takes as much space as needed
                                mainAxisAlignment: MainAxisAlignment.center, // Center the content of the row
                                children: [
                                  Text(
                                    userData['name'],
                                    style: TextStyle(
                                      fontSize: 32, // Adjust font size
                                      fontFamily: 'Cursive',
                                      fontWeight: FontWeight.bold, // Adjust font weight
                                      color: Colors.black, // Text color
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Add some spacing between text and icon
                                  // IconButton(
                                  //   onPressed: () {
                                  //     // Add your onPressed logic here
                                  //     print("Edit icon pressed");
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.edit, // Pen icon
                                  //     color: Colors.blue, // Icon color
                                  //     size: 20, // Icon size
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // Spacer(),
                            // Spacer(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.03,
                            ),
                            RoundButton(title: "Logot", onpress: (){
                              logouted(context);


                            })





                            //0902cs211016





                          ],
                        );
                      }
                        return Center(child: Text("No datas are availave"));

                    },
                ),






                //0902cs211016






            ),
          ),
        );

  }
  Future<void> logouted(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully.");

      // Navigate to the signup page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signup()), // Replace 'Signup' with your actual signup page widget
      );
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
