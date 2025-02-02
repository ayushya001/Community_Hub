import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Provider/AuthProvider.dart';

import '../Utils/AppComponentsColor.dart';

class RoundButton extends StatelessWidget {

  final String title;

  final VoidCallback onpress;
  const RoundButton({Key? key, required this.title,  required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authprovider = Provider.of<Authprovider>(context,listen: false);

    return ElevatedButton(
        onPressed: (){
          onpress();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Appcolors.RoundbuttonColor),
            fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.06)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Set the circular border radius here
              ),
            ),
          ),
          child: Consumer<Authprovider>(
        builder: (context, authprovider, child) {
          return authprovider.loading
              ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white))
              : Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),
            ),
          );
        }
          ),

    );


  }
}
