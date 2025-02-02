import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:communityhubb/Models/AnswerModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../FirebaseServices/FirebaseServices.dart';


import '../Models/QuestionModel.dart';
import '../Models/UserModels.dart';
import '../Utils/DateTimeutils.dart';

class AnswerWidget extends StatefulWidget {

  final UserModel user;
  final AnswerModel answers;
  const AnswerWidget({super.key, required this.user, required this.answers});

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final String? userId = firebaseServices.currentUser?.uid;

    return Padding(
      padding: EdgeInsets.only(top: mq.height*0.01,bottom: mq.height*0.01),
      child: Container(


        width: mq.width,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        // color: Colors.greenAccent,
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: mq.height*0.07,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color(0xFF4169E1),  // dark grey
                // color: Color(0xFF4169E1),
                borderRadius: BorderRadius.only(
                    topLeft:
                    Radius.circular(10),
                    topRight:
                    Radius.circular(10)

                ),
                // border: Border.all(
                //     color: Color(0x3C3C434D)
                // ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: mq.width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          width: mq.width*.08,
                          imageUrl: widget.user.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover, // You can use BoxFit.cover to ensure the image fits within the circle
                              ),
                            ),
                          ),
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          // imageUrl: '',
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: mq.width*0.03,right: mq.width*0.01),
                          child: AutoSizeText(
                            widget.user.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Cursive'
                            ),
                            maxLines: 1,
                          ),
                        ),

                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(left: mq.width*0.01,right: mq.width*0.04),
                        child: AutoSizeText(
                          MyDateUtil.getTime(context: context, lastActive: widget.answers.Time),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'cursive',
                              fontWeight: FontWeight.bold

                            // fontFamily: 'Cursive'
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              // color:Color(0xFFE8E6EA),
              color:Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: mq.height*0.01,left: mq.width*0.08,right: mq.width*0.02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(




                        child: AutoSizeText(
                          widget.answers.Answer,
                          style: GoogleFonts.roboto(
                            // textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 18,

                            fontWeight: FontWeight.w400,
                            // fontStyle: FontStyle.italic,
                          ),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height*0.01,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey, // specify the border color here
                          width: 2.0, // specify the border width here
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height*0.01,),
                  if (widget.answers.By == userId)
                  InkWell(
                    onTap: () {
                      firebaseServices.deleteAnswer(widget.answers.AnswerId);
                    },
                    child: Icon(Ionicons.trash_bin, color: Colors.redAccent),
                  ),
                  SizedBox(height: mq.height*0.01,),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey, // specify the border color here
                          width: 2.0, // specify the border width here
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
