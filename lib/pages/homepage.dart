// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:test_application/widgets/drawer.dart';


class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int time = 8;
    String text = "It's a string";
    bool isTrue = true;
    var day = "Tuesday";

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalogue App"),
      ),
        body: Center(
          child: Container(
            child: Text('welcome to flutter within $time by $text and $isTrue and this is num $num ..Let\'s see a var $day'),
          ),
        ), 
        drawer: MyDrawer(),
    );
  }
}