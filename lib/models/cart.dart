import 'package:velocity_x/velocity_x.dart';

import 'package:test_application/core/store.dart';
import 'package:test_application/models/catalogue.dart';

class CartModel{

  // static final cartModel = CartModel._internal(); 

  // CartModel._internal();
  // factory CartModel() => cartModel;

  //catalog field
  late CatalogueModel _catalog;


  //collection of IDs - store IDs of each item
  final List<int> _itemsIds = [];

  //get catalog
  CatalogueModel get catalog => _catalog;


  set catalog(CatalogueModel newCatalog){
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get items in the cart

  List<Item> get items => _itemsIds.map((id) => _catalog.getById(id)).toList().toList();


  //get total price of items in the cart
  num get totalPrice => items.fold(0, (total, current) => total + current.price);

}


class AddMutation extends VxMutation<MyStore> {
  final Item item;
  AddMutation({
    required this.item,
  });
  @override
  perform() {
    store.cart._itemsIds.add(item.id);
  }

}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;
  RemoveMutation({
    required this.item,
  });
  @override
  perform() {
    store.cart._itemsIds.remove(item.id);
  }

}

