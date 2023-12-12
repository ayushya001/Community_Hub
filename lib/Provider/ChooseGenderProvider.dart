

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';

class GenderProvidr extends ChangeNotifier{

  String _gender = "";

  String get gender => _gender;

  void setgender(String value){
    _gender = value;
    notifyListeners();
    print(_gender);
  }


  void StoreGender(BuildContext context) async {

    try {
      final GenderMap = {'Gender': _gender};

      final CurrentUser  = FirebaseAuth.instance.currentUser;
      if(CurrentUser!=null){
        final authprovider = Provider.of<Authprovider>(context, listen: false); // Use the existing instance
        authprovider.setloading(true);
        final uid = CurrentUser.uid;
        await FirebaseFirestore.instance
            .collection("LoveriaUsers")
            .doc(uid)
            .update(GenderMap);


        authprovider.setloading(false);

        // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.InterstedPage)));



      }
    } catch (e) {
      print("Error storing interests: $e");
    }



  }

}