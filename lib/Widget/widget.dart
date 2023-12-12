import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:communityhubb/Models/QuestionModel.dart';
import 'package:communityhubb/Models/UserModels.dart';
import 'package:communityhubb/Screens/Answer.dart';
import 'package:communityhubb/Utils/DateTimeutils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';


class appWidget extends StatefulWidget {
  final QuestionModel questions;
  final UserModel user;
  const appWidget({super.key, required this.questions, required this.user});

  @override
  State<appWidget> createState() => _appWidgetState();
}

class _appWidgetState extends State<appWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: mq.height*0.01,bottom: mq.height*0.01),
      child: widget.questions.Type == "image" ? withimage() : withoutimage(),

    );
  }
  Widget withoutimage(){
    return Container(


      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      // color: Colors.greenAccent,
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Color(0xFF4169E1),  // dark grey
              color: Color(0xFF4169E1),
              borderRadius: BorderRadius.only(
                  topLeft:
                  Radius.circular(10),
                  topRight:
                  Radius.circular(10)

              ),
              border: Border.all(
                  color: Color(0x3C3C434D)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width*.12,
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
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),
                      child: AutoSizeText(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),
                    child: AutoSizeText(
                      MyDateUtil.getTime(context: context, lastActive: widget.questions.Time),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
          Container(
            // color:Color(0xFFE8E6EA),
            color:Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Flexible(
                        child: AutoSizeText(
                          widget.questions.Question,
                          style: GoogleFonts.roboto(
                            // textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 22,

                            fontWeight: FontWeight.w400,
                            // fontStyle: FontStyle.italic,
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.01,),
                // Container(
                //   height: 1,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         color: Color(0x3C3C434D), // Set the border color to red
                //         width: 1.0, // Set the border width
                //       ),
                //     ),
                //   ),
                //
                // ),

              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.05,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Color(0xFFE8E6EA),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                  Radius.circular(10),
                  bottomRight:
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Color(0x3C3C434D),
                )

            ),
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AnswerPage(questions: widget.questions,users: widget.user,),
                          ),
                        );
                      },
                      child: Icon(Ionicons.pencil,color: Colors.black,)),
                  // Padding(
                  //   padding: EdgeInsets.only(left: mq.width*0.03),
                  //   child: Icon(Icons.share,color: Colors.black,),
                  // ),
                  // Icon(CupertinoIcons.chat_bubble,color: Colors.white,),
                ],
              ),
            ),

          )

        ],
      ),

    );
  }
  Widget withimage(){
    return Container(


      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      // color: Colors.greenAccent,
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Color(0xFF4169E1),  // dark grey
              color: Color(0xFF4169E1),
              borderRadius: BorderRadius.only(
                  topLeft:
                  Radius.circular(10),
                  topRight:
                  Radius.circular(10)

              ),
              border: Border.all(
                  color: Color(0x3C3C434D)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width*.12,
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
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),
                      child: AutoSizeText(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
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
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),
                    child: AutoSizeText(
                      MyDateUtil.getTime(context: context, lastActive: widget.questions.Time),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
          Container(
            // color:Color(0xFFE8E6EA),
            color:Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Flexible(
                        child: AutoSizeText(
                          widget.questions.Question,
                          style: GoogleFonts.roboto(
                            // textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 22,

                            fontWeight: FontWeight.w400,
                            // fontStyle: FontStyle.italic,
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02) ,
                  child: CachedNetworkImage(
                    imageUrl: widget.questions.Image,
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover, // You can use BoxFit.cover to ensure the image fits within the circle
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    // imageUrl: '',
                  ),
                ),


              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.05,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Color(0xFFE8E6EA),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                  Radius.circular(10),
                  bottomRight:
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Color(0x3C3C434D),
                )

            ),
            child: Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AnswerPage(questions: widget.questions,users: widget.user,),
                          ),
                        );
                      },
                      child: Icon(Ionicons.pencil,color: Colors.black,)),
                  // Padding(
                  //   padding: EdgeInsets.only(left: mq.width*0.03),
                  //   child: Icon(Icons.share,color: Colors.black,),
                  // ),
                  // Icon(CupertinoIcons.chat_bubble,color: Colors.white,),
                ],
              ),
            ),

          )

        ],
      ),

    );
  }



}
