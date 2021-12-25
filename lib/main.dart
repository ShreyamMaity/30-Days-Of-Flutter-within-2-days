// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_application/pages/cartPage.dart';
import 'package:test_application/pages/homepage.dart';
import 'package:test_application/pages/loginPage.dart';
import 'package:test_application/utils/routes.dart';
import 'package:test_application/widgets/themes.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // home: Homepage(),
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: MyRoutes.homeRoute,
      routes: {
        MyRoutes.homeRoute : (context) => Homepage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.cartRoute: (context) => Cartpage(),
      },
    );
  }
}