import 'package:e_commerce/features/product/data/models/category_model.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.seuilRupture,
    required super.description,
    required super.category,
    required super.price,
    required super.image,
  });

  factory ProductModel.fromJson(RecordModel map) {
    return ProductModel(
        id: map.data["produitid"],
        name: map.expand["produitid"]?.first.data["name"] ?? "",
        seuilRupture: map.expand["produitid"]?.first.data["seuilrupture"] ?? 0,
        description: map.expand["produitid"]?.first.data["description"] ?? "",
        category: CategoryModel.fromJson(
          map.expand["produitid"]?.first.expand["categorynum"]?.first ??
              RecordModel.fromJson({"id": "", "name": ""}),
        ),
        price: map.data["prix"],
        image: map.expand["produitid"]?.first.data["image"] ?? "");
  }
}
