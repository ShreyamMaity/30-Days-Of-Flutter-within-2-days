// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:test_application/models/cart.dart';
import 'package:test_application/models/catalogue.dart';
import 'package:velocity_x/velocity_x.dart';


class MyStore extends VxStore{

  
  late CatalogueModel catalog;
  late CartModel cart;


  MyStore() {
    catalog = CatalogueModel();
    cart = CartModel();
    cart.catalog = catalog;
  }

}