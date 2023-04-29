// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/screen/layout_responsive.dart';
import 'package:instagram/screen/login_sceen.dart';
import 'package:instagram/screen/mobile_screen.dart';
import 'package:instagram/screen/web_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCI4d7GutRMagOS1JhsrnGPwS9vLzShqoU",
            appId: "1:1036612952386:web:3b9f62e537a8c90edda8db",
            messagingSenderId: "1036612952386",
            projectId: "instagram-77145",
            storageBucket: "instagram-77145.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          // home: LayoutResponsive(
          //   mobileScreen: MobileSceen(),
          //   webScreen: WebScreen(),
          // ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return LayoutResponsive(
                      mobileScreen: MobileSceen(),
                      webScreen: WebScreen(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.hasError.toString()),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return LoginScreen();
              })),
    );
  }
}
