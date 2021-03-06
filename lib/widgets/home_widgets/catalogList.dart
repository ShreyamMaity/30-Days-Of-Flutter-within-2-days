// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:test_application/widgets/home_widgets/addToCart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:test_application/models/catalogue.dart';
import 'package:test_application/pages/homeDetailPage.dart';


import 'catalogImage.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogueModel.items!.length,
      itemBuilder: (context, index) {
        final catalog = CatalogueModel.items![index];
        return InkWell(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(catalog: catalog))),
          child: CatalogItem(catalog : catalog));
      },

      );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({ Key? key, required this.catalog }) :assert(catalog!= null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(
              image: catalog.image)),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            catalog.name.text.lg.color(context.accentColor).bold.make(),
            catalog.desc.text.make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                AddToCart(catalog: catalog),
              ],
            ).pOnly(right: 8),
          ],)
          ),
        ],
      )
    ).rounded.color(context.cardColor).square(150).make().py16();
  }
}

