import 'package:e_commerce/features/product/domain/entities/category.dart';

class Product {
  final String id;
  final String name;
  final int seuilRupture;
  final String? description;
  final Category category;
  final double? price;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.seuilRupture,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
  });
}
