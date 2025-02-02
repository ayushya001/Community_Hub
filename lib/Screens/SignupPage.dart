import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:communityhubb/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../FirebaseServices/FirebaseServices.dart';
import '../Provider/AuthProvider.dart';
import '../Utils/AppComponentsColor.dart';
import '../Utils/general_utils.dart';
import '../Widget/RoundButton.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ConfirmpasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode ConfirmpasswordFocusNode = FocusNode();


  @override
  void dispose() {



    _passwordController.dispose();
    _emailController.dispose();
    _ConfirmpasswordController.dispose();
    _obsecurepassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    ConfirmpasswordFocusNode.dispose();

      super.dispose(); // Ensure the superclass dispose method is called

  }

  @override
  Widget build(BuildContext context) {
    print("whole build");
    final authProvider = Provider.of<Authprovider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
          child:Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Community Hub',
                        textStyle: const TextStyle(
                            fontSize: 54.0,
                            fontFamily: 'Cursive',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4169E1),
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 10),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: false,
                  ),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: 80, // adjust the radius as needed
                  //     backgroundImage: AssetImage('assets/images/loveria.jpg'), // replace with your image path
                  //   ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                          labelText: "Email",
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


                          prefixIcon: Icon(Icons.alternate_email,color: Appcolors.TextformIconColor,)
                      ),
                      onFieldSubmitted: (val){
                        Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                      },

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  ValueListenableBuilder(valueListenable: _obsecurepassword,
                      builder: (context,value,child) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obsecurepassword.value,
                            focusNode: passwordFocusNode,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock,color: Appcolors.TextformIconColor),

                                suffixIcon: InkWell(
                                    onTap: (){
                                      _obsecurepassword.value = !_obsecurepassword.value;
                                    },
                                    child: Icon(_obsecurepassword.value? Icons.visibility_off_outlined: Icons.visibility, color: _obsecurepassword.value ? Appcolors.TextformIconColor : Appcolors.TextformIconColor, )),
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
                        );
                      }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  ValueListenableBuilder(valueListenable: _obsecurepassword,
                      builder: (context,value,child) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                          child: TextFormField(
                            controller: _ConfirmpasswordController,
                            obscureText: _obsecurepassword.value,
                            focusNode: ConfirmpasswordFocusNode,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              hintText: "Confirm your Password",
                              hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock,color: Appcolors.TextformIconColor),

                              suffixIcon: InkWell(
                                  onTap: (){
                                    _obsecurepassword.value = !_obsecurepassword.value;
                                  },
                                  child: Icon(_obsecurepassword.value? Icons.visibility_off_outlined: Icons.visibility, color: _obsecurepassword.value ? Appcolors.TextformIconColor : Appcolors.TextformIconColor, )),
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
                        );
                      }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  RoundButton(title: 'Signup', onpress: (

                      ){
                    print("click hoo rha hai");

                    bool isValidEmail(String email) {
                      // Define a regular expression pattern for a basic email format
                      final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                      return emailRegExp.hasMatch(email);
                    }

                    if(_emailController.text.isEmpty){
                      Utils.flushBarErrorMessage("Email Cannot be empty", context);
                    } else if (!isValidEmail(_emailController.text)) {
                      Utils.flushBarErrorMessage("Invalid email format", context);
                    }
                    else if(_passwordController.text.isEmpty){
                      Utils.flushBarErrorMessage("Password cannot be empty", context);
                    }else if(_passwordController.text.length<6){
                      Utils.flushBarErrorMessage("Lenght of password must be of six character", context);
                    }else if(_ConfirmpasswordController.text.isEmpty){
                      Utils.flushBarErrorMessage("Password cannot be empty", context);
                    }else if (_passwordController.text != _ConfirmpasswordController.text) {
                      Utils.flushBarErrorMessage("Password and Confirm Password must be the same", context);
                    }
                    else{
                      authProvider.Register(context,_emailController.text.toString(),_passwordController.text.toString());
                      // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.ProfileDetails)));
                      print("api hit");
                    }

                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),

                  Consumer<Authprovider>(
                    builder: (context, authprovider, child) {
                      child: return GestureDetector(
                        onTap:(){
                          Provider.of<Authprovider>(context, listen: false).setloading2(true);

                          firebaseServices.SigninUsingGoogle(context);
                        },
                        child: authprovider.loading2
                          ?
                            Container(
                              height: MediaQuery.of(context).size.height*0.06,
                              width: MediaQuery.of(context).size.width*0.8,

                              decoration: BoxDecoration(
                                // color: Colors.grey, // Set the background color
                                border: Border.all(
                                  color: Colors.blue, // Set the border color
                                  width: 2.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(10), // Optional: Add rounded corners
                              ),
                              child: Center(
                                  child: CircularProgressIndicator(backgroundColor: Appcolors.RoundbuttonColor)

                              ),
                            ):Container(
                          height: MediaQuery.of(context).size.height*0.06,
                          width: MediaQuery.of(context).size.width*0.8,

                          decoration: BoxDecoration(
                            // color: Colors.grey, // Set the background color
                            border: Border.all(
                              color: Colors.blue, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                            borderRadius: BorderRadius.circular(10), // Optional: Add rounded corners
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center align the content
                            children: [
                              Image.asset(
                                'assets/images/gmaill.png', // Replace with the path to your image
                                height: 24.0, // Adjust the image height
                                width: 24.0, // Adjust the image width
                              ),
                              SizedBox(width: 8.0),
                              SizedBox(width: 8.0), // Add some spacing between icon and text
                              Text(
                                'Register with Gmail', // Replace with your desired text
                                style: TextStyle(
                                  fontSize: 16.0, // Adjust text size
                                  color: Colors.black, // Set text color
                                  fontWeight: FontWeight.normal, // Optional: Bold text
                                ),
                              ),
                            ],
                          ),

                        ),
                      );
                    },
                  ),

                  //previous elivated button




                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        AutoSizeText(
                          "Already have account ?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cursive',
                            fontSize: 24,
                            color: Colors.black
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: AutoSizeText(
                            " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cursive',
                              fontSize: 24,
                              color: Appcolors.labelColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
