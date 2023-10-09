import '../../../models/api/base_api.dart';
import 'package:start_project/categories/models/entities/category_data_api_model.dart';

class CategoriesApi extends BaseApi{
  Future<List<CategoryModel>> loadList() async {
    try {
      final parameters = <String, dynamic>{};
      final response = await get('api/common/category/list', parameters);
      final jsonData = response.dataInfo; //{categories: [{categoryId: 1774, title: СПЕЦ ИНСТ<...>
      final List<dynamic> categoriesData = jsonData['categories'];

      return  categoriesData.map((x) => CategoryModel.fromJson(x)).toList();

    } catch (e) {
      throw Exception('Не удалось загрузить категории: $e');
    }
  }
}
