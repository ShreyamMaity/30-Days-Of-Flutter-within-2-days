// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:test_application/models/catalogue.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/itemWidget.dart';


class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(20, (index) => CatalogueModel.items[0]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalogue App"),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: dummyList.length,
            itemBuilder: (context, index) {
              return ItemWidget(
                item: dummyList[index],
              );
            },
          ),
        ),
        drawer: MyDrawer(),
    );
  }
}