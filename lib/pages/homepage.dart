// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:test_application/models/catalogue.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/itemWidget.dart';


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
      appBar: AppBar(
        title: Text("Catalogue App"),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (CatalogueModel.items!= null && CatalogueModel.items!.isNotEmpty)? ListView.builder(
            itemCount: CatalogueModel.items!.length,
            itemBuilder: (context, index) {
              return ItemWidget(
                item: CatalogueModel.items![index],
              );
            },
          ): Center( child: CircularProgressIndicator(),),
        ),
        drawer: MyDrawer(),
    );
  }
}