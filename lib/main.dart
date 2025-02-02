import 'package:communityhubb/Screens/Answer.dart';
import 'package:communityhubb/Screens/ProfileDetails.dart';
import 'package:communityhubb/Screens/SettingsPage.dart';
import 'package:communityhubb/Screens/SignupPage.dart';
import 'package:communityhubb/Screens/homepage.dart';
import 'package:communityhubb/Screens/postpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/AuthProvider.dart';
import 'Provider/ChooseGenderProvider.dart';
import 'Provider/ImagePickerProvider.dart';
import 'Provider/SearchingProvider.dart';
import 'Screens/LoginPage.dart';
import 'Screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) =>  Authprovider()),
        ChangeNotifierProvider(create: (_) =>  GenderProvidr()),
        ChangeNotifierProvider(create: (_) =>  ImageProviderClass()),
        ChangeNotifierProvider(create: (context) => SearchingProvider()),

        // ChangeNotifierProvider(create: (_) =>  ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // set to false to remove debug banner
        routes: {
        '/':(context)=> SplashScreen()
      },
      ),

    );



    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //
    //   routes: {
    //     '/':(context)=> Homepage()
    //   },
    //
    // );
  }
}


