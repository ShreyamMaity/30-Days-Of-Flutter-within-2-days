import 'package:flutter/material.dart';
import 'package:test_application/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:test_application/models/catalogue.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({
    Key? key,
    required this.catalog,
  }) :assert(catalog!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: MyTheme.creamColor,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$${catalog.price}".text.bold.xl4.red800.make(),
                  ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                    
                     child: "Add to cart".text.make()
                     ).wh(120, 50)
                ],
              ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: Image.network(catalog.image)
            ).h32(context),
            Expanded(child: VxArc(
              height: 30.0,
              arcType: VxArcType.CONVEY,
              edge: VxEdge.TOP,
              child: Container(
                color: Colors.white,
                width: context.screenWidth,
                child: Column(
                  children: [
                    catalog.name.text.xl4.color(MyTheme.darkBluishColor).bold.make(),
                    catalog.desc.text.textStyle(context.captionStyle).xl.make(),
                    10.heightBox,
                    "Labore lorem no consetetur erat sed dolor. Labore lorem no eos amet ipsum, et dolor duo et elitr sanctus kasd sea nonumy dolores, sea sed no magna aliquyam, elitr sadipscing clita ipsum sanctus ea duo erat lorem, aliquyam elitr no nonumy labore voluptua sea clita sea, nonumy dolor aliquyam consetetur."
                    .text.textStyle(context.captionStyle).make().p16()
                  ],
                  ).py64(),
              ),
            ))
        ],),
      ),
    );
  }
}
