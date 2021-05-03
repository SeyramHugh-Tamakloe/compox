class Part {
  final String name;
  final int price;
  final String desc;
  final String type;
  final String imagePath;

  Part(
      {required this.name,
      required this.price,
      required this.desc,
      required this.type,
      required this.imagePath});
}

class Cart {
  final String name;
  final int price;
  final int quantity;

  Cart({required this.name, required this.price, required this.quantity});
}
