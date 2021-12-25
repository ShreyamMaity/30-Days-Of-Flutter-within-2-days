import 'package:flutter/material.dart';
import 'package:test_application/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';


class CatalogHeader extends StatelessWidget {
  const CatalogHeader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Catalog App".text.xl5.bold.color(MyTheme.darkBluishColor).make(),
              "Trending products".text.xl2.make()
          ],);
  }
}