class CatalogueModel{
  static final items = [Item(
  id: 1,
   name: "Iphone12pro",
    desc: "Iphone12pro max for fun",
     price: 999,
      color: "#33505a",
       image: "https://m.media-amazon.com/images/I/71MHTD3uL4L.jpg")

  ];
  

}





class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({ required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image });
}

