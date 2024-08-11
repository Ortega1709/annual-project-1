class Cart {
  final String id;
  final String name;
  final String? image;
  final double? price;
  final int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity
  });
}