import '../../../models/api/base_api.dart';
import 'package:start_project/product/models/entities/product_model.dart';

class ProductsApi extends BaseApi {
  Future<List<ProductModel>> loadList({int? categoryId, int? offSet}) async {
    try {
      final parameters = {
        'categoryId': categoryId.toString(),
        'offset': offSet.toString(),
      };
      final response = await get('api/common/product/list', parameters);
      final List<dynamic> jsonData = response.dataInfo;

      return jsonData.map((x) => ProductModel.fromJson(x)).toList();

    } catch (e) {
      throw Exception('Не удалось загрузить список товаров:\n$e');
    }
  }
  Future<ProductModel?> loadDetails({int? productId }) async {
    try {
      final parameters = {
        'productId': productId.toString(),
      };
      final response = await get('api/common/product/details', parameters);
      final jsonData = response.dataInfo;
    
      return ProductModel.fromJson(jsonData);

    } catch (e) {
      throw Exception('Не удалось загрузить детали товара:\n$e');
    }
  }
}
