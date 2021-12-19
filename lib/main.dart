import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_application/pages/homepage.dart';
import 'package:test_application/pages/loginPage.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // home: Homepage(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark
      ),
      initialRoute: "/login",
      routes: {
        "/home" : (context) => Homepage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}