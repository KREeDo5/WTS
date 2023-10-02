import 'dart:convert';
import '../../../models/api/base_api.dart';
import 'package:start_project/categories/models/entities/category_data_api_model.dart';

class CategoriesApi {
  Future<List<CategoryModel>> loadList() async {
    try {
      final parameters = <String, dynamic>{};
      final response = await BaseApi().get('api/common/category/list', parameters);
      final jsonData = response.dataInfo;

      final categoriesData = CategoriesData.fromJson(jsonData);
      return categoriesData.categories ?? [];
    } catch (e) {
      throw Exception('Не удалось загрузить категории: $e');
    }
  }
}

CategoriesData categoriesDataFromJson(String str) =>
    CategoriesData.fromJson(json.decode(str));
String categoriesDataToJson(CategoriesData data) => json.encode(data.toJson());
//TODO: избавиться от класса CategoriesData
class CategoriesData {
  CategoriesData({
    required this.categories,
  });
  List<CategoryModel>? categories;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    categories: List<CategoryModel>.from(
        json["categories"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}
