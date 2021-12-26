// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:test_application/core/store.dart';
import 'package:test_application/models/cart.dart';
import 'package:test_application/models/catalogue.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;

  AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  

  // final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    
    VxState.listen(context,to:[AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;

    bool isInCart = _cart.items.contains(catalog) ? true : false;
    return ElevatedButton(
      onPressed: (){
        if(!isInCart){
          AddMutation(item: catalog);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
      
       child: isInCart? Icon(Icons.done): Icon(CupertinoIcons.cart_badge_plus),
       );
  }
}