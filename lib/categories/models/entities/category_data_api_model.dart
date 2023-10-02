import 'package:json_annotation/json_annotation.dart';
import 'package:start_project/categories/models/api/categories_api.dart';
part 'category_data_api_model.g.dart';

@JsonSerializable()
class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription, //if you use it, catch null
  });

  int categoryId;
  String title;
  String imageUrl;
  int hasSubcategories;
  String fullName;
  String? categoryDescription;         //if you use it, catch null

  static final _categoriesApi = CategoriesApi();

  static Future<List<CategoryModel>> loadList() async {
    final categories = await _categoriesApi.loadList();
    return categories;
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}