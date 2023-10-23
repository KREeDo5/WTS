import '../../../models/api/base_api.dart';
import 'package:start_project/categories/models/entities/category_model.dart';

class CategoriesApi extends BaseApi{
  Future<List<CategoryModel>> loadList({int? offSet}) async {
    try {
      final parameters = {
        'offset': offSet.toString(),
      };
      final response = await get('api/common/category/list', parameters);
      final List<dynamic> jsonData = response.dataInfo['categories'];//{categories: [{categoryId: 1774, title: СПЕЦ ИНСТ<...>

      return jsonData.map((x) => CategoryModel.fromJson(x)).toList();

    } catch (e) {
      throw Exception('Не удалось загрузить категории: $e');
    }
  }
}
