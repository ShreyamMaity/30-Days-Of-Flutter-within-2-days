// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:test_application/models/catalogue.dart';
import 'package:test_application/utils/routes.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/home_widgets/catalogHeader.dart';
import 'package:test_application/widgets/home_widgets/catalogList.dart';
import 'package:test_application/widgets/itemWidget.dart';
import 'package:test_application/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';



class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final dummyList = List.generate(20, (index) => CatalogueModel.items[0]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson = await rootBundle.loadString("./assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogueModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, MyRoutes.cartRoute);
      },
      backgroundColor: context.theme.buttonColor,
      child: Icon(CupertinoIcons.cart,color: Colors.white,) ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogueModel.items != null && CatalogueModel.items!.isNotEmpty )
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
                
          ],),
        ),
      ),
    );
  }
}









