import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../Provider/ChooseGenderProvider.dart';
import '../Utils/AppComponentsColor.dart';
import '../Widget/RoundButton.dart';



class ChooseGender extends StatefulWidget {
  const ChooseGender({Key? key}) : super(key: key);

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {

      String selectedGenderIndex = "-1";

  final List<String> genders = [
    "Male",
    "Women",
    "Others"
  ];

      String selectedGender = "";

      // List<String> tempGender =  List.generate(0, (index) => '');


  @override
  Widget build(BuildContext context) {
        final genderprovider = Provider.of<GenderProvidr>(context,listen: false);
        print("whole build");

        return Scaffold(
          body: SafeArea(
                child: SingleChildScrollView(
                      child: Padding(
                            padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.08,
                                  left: MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                        Row(
                                              children: [
                                                    Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                                                          child: InkWell(
                                                                onTap: () {

                                                                },
                                                                child: Container(
                                                                      height: MediaQuery.of(context).size.height * 0.06,
                                                                      width: MediaQuery.of(context).size.width * 0.12,
                                                                      decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                            border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
                                                                      ),
                                                                      child: Icon(
                                                                            Icons.arrow_back_ios_new,
                                                                            color: Appcolors.featuresNamecolor, // Set the arrow color here
                                                                      ),
                                                                ),
                                                          ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                                          child: InkWell(
                                                                onTap: () {
                                                                      print("Skip is touched in choose gender");
                                                                },
                                                                child: Text(
                                                                      "Skip",
                                                                      style: TextStyle(
                                                                            fontSize: 22,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Appcolors.featuresNamecolor,
                                                                      ),
                                                                ),
                                                          ),
                                                    ),
                                              ],
                                        ),
                                        Padding(
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                                              child: Text(
                                                    "I am a",
                                                    style: TextStyle(
                                                          fontSize: 42,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                    ),
                                              ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                                        ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: genders.length,

                                              itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.04),
                                                      child: InkWell(
                                                            onTap: () {
                                                                        if (selectedGender == genders[index]) {
                                                                              // selectedGender = ""; // Clear the selection if tapped again
                                                                          genderprovider.setgender("");


                                                                        } else {
                                                                              // selectedGender = genders[index];
                                                                              genderprovider.setgender(genders[index]);
                                                                        }
                                                                  print(selectedGender.toString());
                                                            },

                                                            child:Padding(
                                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),

                                                                  child:Consumer<GenderProvidr>(
                                                                     builder: (context, genderprovider, child) {
                                                                  return Container(
                                                                    height: MediaQuery.of(context).size.height * 0.07,
                                                                    width: MediaQuery.of(context).size.width * 0.8,
                                                                    decoration: BoxDecoration(
                                                                          color: genderprovider.gender == genders[index]
                                                                              ? Colors.red
                                                                              : Colors.white,
                                                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                          border: Border.all(
                                                                              color: genderprovider.gender == genders[index]
                                                                                  ? Appcolors.featuresNamecolor
                                                                                  : Appcolors.borderColorApplogo,
                                                                              width: 2),
                                                                    ),
                                                                    child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: [
                                                                                Padding(
                                                                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                                                                                      child: Text(
                                                                                            genders[index].toString(),
                                                                                            style: TextStyle(
                                                                                                  fontSize: 22,
                                                                                                  color: genderprovider.gender == genders[index] ? Colors.white : Colors.black,
                                                                                            ),
                                                                                      ),
                                                                                ),
                                                                                Spacer(),
                                                                                Padding(
                                                                                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                                                                                      child: Icon(
                                                                                            Icons.check,
                                                                                            color: genderprovider.gender == genders[index] ? Colors.white : Appcolors.inactive,
                                                                                      ),
                                                                                )
                                                                          ],
                                                                    ),
                                                              );
                                                                  }
                                                                  )
                                                            ),
                                                      ),
                                                    );
                                              },
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                                        RoundButton(title: "Continue",
                                            onpress: () {

                                            genderprovider.StoreGender(context);

                                            }

                                        ),
                                  ],
                            ),
                      ),
                ),
          ),
    );
  }


  }

