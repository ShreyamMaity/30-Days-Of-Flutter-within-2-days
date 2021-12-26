// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:test_application/core/store.dart';
import 'package:test_application/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar : AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(children: [
        _CartList().p32().expand(),
        Divider(),
        _CartTotal(),
      ],),
    );
  }
}


class _CartTotal extends StatelessWidget {
  const _CartTotal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        VxConsumer(
        mutations: {RemoveMutation},
        notifications: {},
        builder: (ctx,context, _) {return "\$${_cart.totalPrice}".text.xl5.color(ctx.theme.accentColor).make();},
        ),
        30.widthBox,
        ElevatedButton(
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Buying Not Supported yet.".text.make(),));
          },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(context.theme.buttonColor)),
         child: "Buy".text.white.make()
         ).w32(context)
      ],
      ),
    );
  }
}


class _CartList extends StatelessWidget {
  // final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    VxState.watch(context,on: [RemoveMutation]);

    final CartModel _cart = (VxState.store as MyStore).cart;

    return _cart.items.isEmpty? "Nothing to show".text.xl3.makeCentered():  ListView.builder(
      itemCount: _cart.items.length ,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon : Icon(Icons.remove_circle_outline),
          onPressed: () => RemoveMutation(item: _cart.items[index]),
            
          ),
        title: _cart.items[index].name.text.make(),
      ), 
      );
  }
}