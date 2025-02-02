import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityhubb/Screens/SignupPage.dart';
import 'package:communityhubb/Screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(

            children: [
              // Image covering the whole screen
              Image.asset(
                'assets/images/usericon2.png', // Replace with your image asset
                fit: BoxFit.fitWidth,
                height: double.infinity,
                width: double.infinity,
              ),
              // Centered Textflutdj

              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Community Hub',
                        textStyle: const TextStyle(
                          fontSize: 54.0,
                          fontFamily: 'Cursive',
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                        speed: const Duration(milliseconds: 500),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 10),
                    onFinished: (){
                      _checkAuthantication(context);

                      
                    },
                    displayFullTextOnTap: true,
                    stopPauseOnTap: false,
                  ),
                ),
              )

                //  Padding(
                //   padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child:
                //        AutoSizeText(
                //         'Community Hub',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 54,
                //           fontFamily: 'Cursive', // Replace with your cursive font
                //         ),
                //         maxLines: 1,
                //       ),
                //
                //
                //
                //   ),
                // ),


            ],
          ),
        ),
      ),
    );
  }
}

void _checkAuthantication(BuildContext context) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;


  if (user == null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Signup(),
      ),
    );

  } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

}