// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_application/core/store.dart';
import 'package:test_application/models/cart.dart';
import 'dart:convert';
import 'package:test_application/models/catalogue.dart';
import 'package:test_application/utils/routes.dart';
import 'package:test_application/widgets/drawer.dart';
import 'package:test_application/widgets/home_widgets/catalogHeader.dart';
import 'package:test_application/widgets/home_widgets/catalogList.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;



class Homepage extends StatefulWidget {
  
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final dummyList = List.generate(20, (index) => CatalogueModel.items[0]);
  final url = dotenv.env['databaseAPI'].toString();
  var headers = {'X-Master-Key': dotenv.env['databaseAPIKey'].toString()};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // final catalogJson = await rootBundle.loadString("./assets/files/catalog.json");

    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    final response = await request.send();
    final catalogJson = await response.stream.bytesToString();

    final decodedData = jsonDecode(catalogJson);
    var data = decodedData['record'];
    var productsData = data["products"];
    CatalogueModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
        mutations: {AddMutation,RemoveMutation},
        builder:(ctx,context,status) =>  FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(ctx, MyRoutes.cartRoute);
        },
        backgroundColor: ctx.theme.buttonColor,
        child: Icon(CupertinoIcons.cart,color: Colors.white,) ).badge(size:  22, count: _cart.items.length, textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        )),
      ),
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









