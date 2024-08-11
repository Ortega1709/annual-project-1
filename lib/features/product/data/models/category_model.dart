import 'package:e_commerce/features/product/domain/entities/category.dart';
import 'package:pocketbase/pocketbase.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(RecordModel map) {
    return CategoryModel(
      id: map.id,
      name: map.data["name"] ?? ""
    );
  }
}