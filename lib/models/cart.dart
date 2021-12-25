import 'package:test_application/models/catalogue.dart';

class CartModel{

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

  //add item to cart
  void add(Item item){
    _itemsIds.add(item.id);
  }

  //remove item from cart
  void remove(Item item){
    _itemsIds.remove(item.id);
  }

}