
class Item{
  final String id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({ required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image });
}

final products = [Item(
  id: "test1",
   name: "Iphone12pro",
    desc: "Iphone12pro max for fun",
     price: 999,
      color: "#33505a",
       image: "https://cdn.pixabay.com/photo/2016/11/29/05/47/smartphone-1867461_960_720.jpg")

];